clear
T = 2; % 任务数量
num_obstacle = 20; % 障碍物数量

for i = 1:T
    % 初始化第 i 个任务的障碍物数组，num_obstacle 行 2 列 (x, y)
    eval(sprintf('obstacle%d = zeros(%d, 2);', i, num_obstacle));
    
    % 生成障碍物坐标
    for j = 1:num_obstacle
        eval(sprintf('obstacle%d(%d, :) = [rand()*(0.975-0.025)+0.025, rand()*(0.975-0.025)+0.025];', i, j));
    end
    
    % 生成起点坐标
    eval(sprintf('p_start%d = [0, rand()];', i));
    
    % 生成终点坐标
    eval(sprintf('p_goal%d = [1, rand()];', i));
end

% 保存所有变量到 .mat 文件
save('XXX\Multitask Robot Navigation Problem\Maps\map_20_4.mat', ...
    'obstacle1', 'obstacle2', ...
    'p_start1', 'p_start2', ...
    'p_goal1', 'p_goal2');