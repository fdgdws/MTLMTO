function phi = SGF(sourceBasis, targetBasis, d, n)
% SGF 在源任务和目标任务的 PCA 子空间之间采样中间投影基。
% sourceBasis、targetBasis 是两个种群的完整 PCA 基，列数为最大任务维度 D。
% 两组 PCA 基的前 d 列分别构成源特征子空间和目标特征子空间；
% n 是在测地线内部均匀采样的子空间数量。
% 输出 phi 按采样顺序拼接各投影基，尺寸为 D x (d*n)。

    % 将目标子空间投影到源 PCA 坐标系。前 d 行表示目标子空间
    % 在源特征子空间中的分量，其余行表示在正交补中的分量。
    targetSubspace = targetBasis(:, 1:d);
    alignedTarget = sourceBasis' * targetSubspace;

    % 对两个分量做广义奇异值分解，得到构造中间子空间所需的
    % 旋转矩阵和主角余弦。正交补分量取负以确定插值方向。
    [sourceRotation, complementRotation, ~, cosAngles, ~] = gsvd( ...
        alignedTarget(1:d, :), alignedTarget(d+1:end, :));
    complementRotation = -complementRotation(:, 1:d);
    % cosAngles 的对角元是 cos(theta_i)，theta_i 为两个子空间的主角。
    angles = real(acos(diag(cosAngles)));

    % 在开区间 (0,1) 均匀取 n 个插值位置，不包含源、目标端点。
    samples = linspace(0, 1, n + 2);
    samples = samples(2:end-1);
    phi = zeros(size(sourceBasis, 1), d * n);
    for i = 1:n
        t = samples(i);
        columns = (i - 1) * d + (1:d);
        % 用 cos(t*theta_i) 和 sin(t*theta_i) 对源子空间及其
        % 正交补加权，得到当前采样位置的投影基。各投影基拼接后，
        % x^T*phi 就是个体在全部中间子空间上的特征表示。
        phi(:, columns) = sourceBasis(:, 1:d) * sourceRotation * ...
            diag(cos(t .* angles)) + sourceBasis(:, d+1:end) * ...
            complementRotation * diag(sin(t .* angles));
    end
end
