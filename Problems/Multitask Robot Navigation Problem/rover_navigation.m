function [obj, Con] = rover_navigation(y, obstacle, p_start, p_goal)
    % 代价函数：给定一条由 y(i) 决定的折线路径（x 坐标按固定步长均匀取）
    %           统计路径长度 + 穿过障碍物的惩罚 + 与起终点连接的代价 + 常数项
    %
    % 输入：
    %   y         : N×dim 矩阵，每一行代表一个个体的纵坐标序列
    %   obstacle  : 1×on 的结构体数组，每个元素代表一个矩形障碍物，
    %               字段 rect.angle(1..4) 为四个角点（任意顺序，不必轴对齐）
    %               每个角点为结构体，有字段 .x, .y
    %   p_start   : 起点，结构体，有字段 .x, .y
    %   p_goal    : 终点，结构体，有字段 .x, .y
    %
    % 输出：
    %   obj : N×1 向量，存储每个个体的代价值
    %   Con : N×1 向量，全零（无约束）
    [N, dim] = size(y);       % N: 个体数量, dim: 路径点数
    on = length(obstacle);    % 障碍物数量
    x_step = 1 / (dim-1);         % x 坐标步长
    obj = zeros(N, 1);
    Con = zeros(N, 1);

    % === 预先计算障碍物的外包矩形 [xmin xmax ymin ymax] ===
    obs_bbox = zeros(on, 4);
    for j = 1:on
        xs = [obstacle(j).angle.x];
        ys = [obstacle(j).angle.y];
        obs_bbox(j,:) = [min(xs), max(xs), min(ys), max(ys)];
    end

    % === 主循环 ===
    for k = 1:N
        % 构造路径点（向量化生成）
        p = arrayfun(@(i) point(x_step*(i-1), y(k,i)), 1:dim);

        % 路径段
        punishment = 0;
        c_traj = 0;

        for i = 1:dim-1
            % 当前路径段的包围盒
            seg_xmin = min(p(i).x, p(i+1).x);
            seg_xmax = max(p(i).x, p(i+1).x);
            seg_ymin = min(p(i).y, p(i+1).y);
            seg_ymax = max(p(i).y, p(i+1).y);

            % 粗检测：包围盒相交
            cand_idx = ...
                obs_bbox(:,1) <= seg_xmax & ...
                obs_bbox(:,2) >= seg_xmin & ...
                obs_bbox(:,3) <= seg_ymax & ...
                obs_bbox(:,4) >= seg_ymin;

            % 精检测
            for j = find(cand_idx)'
                if is_collided(p(i), p(i+1), obstacle(j))
                    punishment = punishment + 1;
                end
            end

            % 累加路径长度
            c_traj = c_traj + dist(p(i), p(i+1));
        end

        c_collision = punishment * 20;
        obj(k) = c_traj + c_collision + ...
                 10 * (dist(p_start, p(1)) + dist(p_goal, p(end))) + 5;
    end
end


function [flag] = is_collided(v_start, v_end, rect)
    % 判断一条线段是否与矩形发生碰撞（包含端点在矩形内的情况）
    % 判定规则：
    %   1) 若线段任一端点在矩形内部，则算碰撞
    %   2) 否则，若线段与矩形两条对角线任一相交，则算碰撞
    %      （对角线相交法适用于凸四边形；再配合端点在内的判定，覆盖常见情况）
    %
    % 输入：
    %   v_start : 线段起点，结构体，有字段 .x, .y
    %   v_end   : 线段终点，结构体，有字段 .x, .y
    %   rect    : 矩形结构体，字段 angle(1..4) 为四个角点，结构体有字段 .x, .y
    %
    % 输出：
    %   flag    : 碰撞标志，1 表示发生碰撞，0 表示无碰撞
    if is_contains_point(v_start, rect) || is_contains_point(v_end, rect)
        flag = 1;
        return;
    end
    % 与两条对角线做相交性检测
    flag =  is_segment_intersects(v_start, v_end, rect.angle(1), rect.angle(3)) || ...
            is_segment_intersects(v_start, v_end, rect.angle(2), rect.angle(4));
end

function [flag] = is_segment_intersects(v_start1, v_end1, v_start2, v_end2)
    % 判断两条线段是否相交（包括端点重合与共线重叠）
    % 思路：
    %   设线段1：A->B，线段2：C->D
    %   若点 A 与 B 分别位于线段2 的不同侧（含有一侧为共线 0），且
    %     点 C 与 D 分别位于线段1 的不同侧（含有一侧为共线 0），
    %   则两线段相交。
    %
    % 输入：
    %   v_start1 : 第一条线段的起点，结构体，有字段 .x, .y
    %   v_end1   : 第一条线段的终点，结构体，有字段 .x, .y
    %   v_start2 : 第二条线段的起点，结构体，有字段 .x, .y
    %   v_end2   : 第二条线段的终点，结构体，有字段 .x, .y
    %
    % 输出：
    %   flag     : 相交标志，1 表示相交，0 表示不相交
    left_s = point_is_left(v_start1, v_start2, v_end2); % A 相对 CD 的左右性（叉积符号）
    left_e = point_is_left(v_end1,   v_start2, v_end2); % B 相对 CD 的左右性
    if left_s * left_e > 0
        flag = 0;   % A、B 同侧（且都不为 0），不相交
        return;
    end

    left_s = point_is_left(v_start2, v_start1, v_end1); % C 相对 AB 的左右性
    left_e = point_is_left(v_end2,   v_start1, v_end1); % D 相对 AB 的左右性
    if left_s * left_e > 0
        flag = 0;   % C、D 同侧（且都不为 0），不相交
        return;
    end

    flag = 1;       % 其余情况视为相交（含端点共线/重叠）
end

function [val] = point_is_left(v, v_start, v_end)
    % 判断点 v 相对于有向线段 v_start → v_end 的左右位置
    % val > 0 : v 在有向边 v_start → v_end 的左侧
    % val < 0 : v 在有向边 v_start → v_end 的右侧
    % val = 0 : 三点共线
    %
    % 输入：
    %   v        : 测试点，结构体，有字段 .x, .y
    %   v_start  : 线段起点，结构体，有字段 .x, .y
    %   v_end    : 线段终点，结构体，有字段 .x, .y
    %
    % 输出：
    %   val      : >0 表示 v 在左侧，<0 表示 v 在右侧，=0 表示共线
    val = (v_start.x - v.x) * (v_end.y - v.y) - (v_end.x - v.x) * (v_start.y - v.y);
end

function [flag] = is_contains_point(v, rect)
    % 判断点 v 是否在矩形 rect 内部（含边界）
    %
    % 输入：
    %   v     : 测试点，结构体，有字段 .x, .y
    %   rect  : 矩形结构体，字段 angle(1..4) 为四个角点，结构体有字段 .x, .y
    %
    % 输出：
    %   flag  : 在矩形内返回 1，否则返回 0

    xs = [rect.angle(1).x, rect.angle(2).x, rect.angle(3).x, rect.angle(4).x];
    ys = [rect.angle(1).y, rect.angle(2).y, rect.angle(3).y, rect.angle(4).y];

    left   = min(xs);
    right  = max(xs);
    bottom = min(ys);
    top    = max(ys);

    if (left <= v.x) && (v.x <= right) && (bottom <= v.y) && (v.y <= top)
        flag = 1;
    else
        flag = 0;
    end
end

function [d] = dist(p1, p2)
    % 计算两点的欧几里得距离
    %
    % 输入：
    %   p1    : 第一个点，结构体，有字段 .x, .y
    %   p2    : 第二个点，结构体，有字段 .x, .y
    %
    % 输出：
    %   d     : p1 与 p2 之间的距离
    d = sqrt((p1.x - p2.x)^2 + (p1.y - p2.y)^2);
end


