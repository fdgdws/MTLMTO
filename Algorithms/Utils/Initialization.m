function population = Initialization(Algo, Prob, Individual_Class, varargin)
%% Multi-task - Initialize and evaluate the population
% Input: Algorithm, Problem, Individual_Class
% Output: population

%------------------------------- Copyright --------------------------------
% Copyright (c) Yanchi Li. You are free to use the MToP for research
% purposes. All publications which use this platform should acknowledge
% the use of "MToP" or "MTO-Platform" and cite as "Y. Li, W. Gong, F. Ming,
% T. Zhang, S. Li, and Q. Gu, MToP: A MATLAB Optimization Platform for
% Evolutionary Multitasking, 2023, arXiv:2312.08134"
%--------------------------------------------------------------------------

n = numel(varargin);
if n == 0
    N = Prob.N;
    useMaxD = true;   % 默认用 max(Prob.D)
elseif n == 1
    if islogical(varargin{1}) || (isnumeric(varargin{1}) && (varargin{1}==0 || varargin{1}==1))
        % 如果传入的是布尔值（true/false）
        N = Prob.N;
        useMaxD = varargin{1};
    else
        % 如果传入的是种群大小
        N = varargin{1};
        useMaxD = true;
    end
elseif n == 2
    % 两个参数：种群大小 + 布尔开关
    N = varargin{1};
    useMaxD = varargin{2};
else
    return;
end

for t = 1:Prob.T
    for i = 1:N
        population{t}(i) = Individual_Class();
        if useMaxD
            population{t}(i).Dec = rand(1, max(Prob.D));
        else
            population{t}(i).Dec = rand(1, Prob.D(t));
        end
    end
    population{t} = Algo.Evaluation(population{t}, Prob, t);
end
end
