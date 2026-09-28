classdef MTLMTO < Algorithm
    % <Multi-task> <Single-objective> <None>
    % 基于流形迁移学习的多任务优化算法。
    properties (SetAccess = private)
        % 子空间维度和测地线上采样的中间子空间数量。
        DLat = 1
        subspacesN = 5
        % 自我进化的 DE/rand/1 参数，以及迁移个体的二项式交叉率。
        F = 0.5
        CR = 0.8
        BCR = 0.9
        % Num 是每任务种群规模；maxFEs 是所有任务合计的函数评估预算。
        Num = 50
        maxFEs = 100000
    end

    methods
        function Parameter = getParameter(Algo)
            % 返回平台使用的“参数名、参数值”交替排列的单元数组。
            Parameter = {
                'DLat', num2str(Algo.DLat), ...
                'subspacesN', num2str(Algo.subspacesN), ...
                'F', num2str(Algo.F), ...
                'CR', num2str(Algo.CR), ...
                'BCR', num2str(Algo.BCR), ...
                'Num', num2str(Algo.Num), ...
                'maxFEs', num2str(Algo.maxFEs)
            };
        end

        function Algo = setParameter(Algo, Parameter)
            % 按 getParameter 中的顺序读取参数值。
            i = 1;
            Algo.DLat = str2double(Parameter{i}); i = i + 1;
            Algo.subspacesN = str2double(Parameter{i}); i = i + 1;
            Algo.F = str2double(Parameter{i}); i = i + 1;
            Algo.CR = str2double(Parameter{i}); i = i + 1;
            Algo.BCR = str2double(Parameter{i}); i = i + 1;
            Algo.Num = str2double(Parameter{i}); i = i + 1;
            Algo.maxFEs = str2double(Parameter{i});
        end

        function run(Algo, Prob)
            % 为所有任务设置统一的种群规模和合计评估预算。
            Prob.N = Algo.Num;
            Prob.maxFE = Algo.maxFEs;

            % 不同维度的任务在最大维度 D 的归一化空间 [0,1] 中表示。
            % Initialization 对较低维任务的缺失维度填入随机值，再分别评估。
            maxDim = max(Prob.D);
            population = Initialization(Algo, Prob, Individual);

            while Algo.notTerminated(Prob, population, false)
                for t = 1:Prob.T
                    % 为每个目标个体选取三个不同的同任务个体，
                    % 用 DE/rand/1 变异和二项式交叉生成自我进化子代。
                    offspring = population{t};
                    for i = 1:length(offspring)
                        candidates = setdiff(1:length(population{t}), i);
                        selected = candidates(randperm(numel(candidates), 3));
                        parent = population{t}(i).Dec;
                        donor = population{t}(selected(1)).Dec + Algo.F * ...
                            (population{t}(selected(2)).Dec - population{t}(selected(3)).Dec);
                        offspring(i).Dec = DE_Crossover(donor, parent, Algo.CR);
                        % 修复越界变量，保持统一的归一化决策空间。
                        offspring(i).Dec = min(max(offspring(i).Dec, 0), 1);
                    end

                    % 评估自我进化子代。
                    [offspring, bestUpdated] = Algo.Evaluation(offspring, Prob, t);

                    % 当前任务的最优解未更新时启动知识迁移。
                    if ~bestUpdated
                        % 随机选择另一个任务作为源任务，只向当前任务传递信息。
                        transferOffspring = population{t};
                        sourceTask = randi(Prob.T);
                        while sourceTask == t
                            sourceTask = randi(Prob.T);
                        end

                        % 使用两个种群的全部个体分别提取 PCA 基，再构造源子空间到目标子空间之间的中间投影基。
                        sourceDec = population{sourceTask}.Decs;
                        targetDec = population{t}.Decs;
                        phi = SGF(pca(sourceDec), pca(targetDec), Algo.DLat, Algo.subspacesN);
                        % 将源个体投影到全部中间子空间，并按采样顺序拼接
                        % 投影结果，得到每个源个体的流形特征。
                        sourceFeatures = sourceDec * phi;

                        % 逐个处理源种群前半部分的精英个体。
                        % 在归一化决策空间内，用随机初值和内点法重建迁移个体。
                        options = optimoptions('fmincon', ...
                            'Algorithm', 'interior-point', 'Display', 'off');
                        eliteCount = round(Prob.N / 2);
                        for idx = 1:eliteCount
                            % 寻找投影特征最接近当前源精英的决策向量。
                            % 使用平方欧氏距离作为优化目标。
                            sourceFeature = sourceFeatures(idx, :);
                            distance = @(x) sum((sourceFeature - x' * phi).^2);
                            transferredDec = fmincon(distance, rand(maxDim, 1), ...
                                [], [], [], [], zeros(maxDim, 1), ones(maxDim, 1), ...
                                [], options)';
                            % 从目标种群前半精英中随机选一个体，并等概率
                            % 选择一种交叉方向生成迁移子代。
                            targetEliteDec = population{t}(randi(eliteCount)).Dec;
                            if rand() < 0.5
                                transferOffspring(idx).Dec = DE_Crossover( ...
                                    transferredDec, targetEliteDec, Algo.BCR);
                            else
                                transferOffspring(idx).Dec = DE_Crossover( ...
                                    targetEliteDec, transferredDec, Algo.BCR);
                            end
                        end

                        % 将 eliteCount 个迁移子代与自我进化子代一起参与选择。
                        transferOffspring = transferOffspring(1:eliteCount);
                        [transferOffspring, ~] = Algo.Evaluation(transferOffspring, Prob, t);
                        offspring = [offspring, transferOffspring];
                    end

                    % 合并父代和全部子代，保留 Prob.N 个最优个体。
                    [population{t}, ~] = Selection_Elit(population{t}, offspring);
                end
            end
        end
    end
end
