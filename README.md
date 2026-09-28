# MTLMTO

```
Manifold Transfer Learning for Multitask Optimization
```

MTLMTO 是用于无约束单目标多任务优化的 MATLAB 项目。项目包含基于流形迁移学习的 MTLMTO 算法、多任务与超多任务基准问题，以及机器人路径规划应用。运行方式为 MATLAB 命令行；可进行多次独立运行，并保存各任务的收敛值和最优决策变量。

## 项目结构

- `mto.m`：命令行入口。
- `Algorithms/MTLMTO/`：MTLMTO 算法；`Algorithms/Utils/`：算法所需工具。
- `Problems/`：多任务、超多任务基准问题和机器人路径规划应用及其数据。
- `GUI/MTO_CMD.m`、`GUI/Utils/`：命令行运行、并行计时和结果整理所需代码；

## 环境准备

需要 MATLAB，以及 Statistics and Machine Learning Toolbox（`pca`）和 Optimization Toolbox（`fmincon`）。并行运行还需要 Parallel Computing Toolbox；没有该工具箱时，将命令中的第四个参数改为 `false`。

在 MATLAB 命令窗口切换到包含 `mto.m` 的项目目录：

```matlab
cd('/path/to/MTLMTO')  % 替换为本机实际路径
```

## 运行命令

### 多任务基准测试

```matlab
# CEC2017 MTSO
mto('MTLMTO', {'CEC17-MTSO1-CI-HS','CEC17-MTSO2-CI-MS','CEC17-MTSO3-CI-LS','CEC17-MTSO4-PI-HS','CEC17-MTSO5-PI-MS','CEC17-MTSO6-PI-LS','CEC17-MTSO7-NI-HS','CEC17-MTSO8-NI-MS','CEC17-MTSO9-NI-LS'}, 30, true, 11, false, 'MTLMTO-CEC17-MTSO');
# WCCI2020(CEC2022) MTSO
mto('MTLMTO', {'WCCI20-MTSO1','WCCI20-MTSO2','WCCI20-MTSO3','WCCI20-MTSO4','WCCI20-MTSO5','WCCI20-MTSO6','WCCI20-MTSO7','WCCI20-MTSO8','WCCI20-MTSO9','WCCI20-MTSO10'}, 30, true, 11, false, 'MTLMTO-WCCI20-MTSO');
```

该系列使用 `cec14_func` MEX 文件，运行前须有与当前操作系统和 MATLAB 架构匹配的 MEX 文件，并确保它位于 MATLAB 路径中。

### 超多任务基准测试

```matlab
# CEC2019 MaTSO
mto('MTLMTO', {'CEC19-MaTSO1','CEC19-MaTSO2','CEC19-MaTSO3','CEC19-MaTSO4','CEC19-MaTSO5','CEC19-MaTSO6'}, 30, true, 11, false, 'MTLMTO-CEC19-MaTSO');
# WCCI2020 MaTSO
mto('MTLMTO', {'WCCI20-MaTSO1','WCCI20-MaTSO2','WCCI20-MaTSO3','WCCI20-MaTSO4','WCCI20-MaTSO5','WCCI20-MaTSO6','WCCI20-MaTSO7','WCCI20-MaTSO8','WCCI20-MaTSO9','WCCI20-MaTSO10'}, 30, true, 11, false, 'MTLMTO-WCCI20-MaTSO');
```

### 机器人路径规划应用

```matlab
# multitask robot navigation application
mto('MTLMTO', {'MRNP1','MRNP2','MRNP3','MRNP4','MRNP5','MRNP6','MRNP7','MRNP8','MRNP9','MRNP10','MRNP11','MRNP12','MRNP13','MRNP14'}, 30, true, 11, true, 'MTLMTO-MRNP');
```

## 致谢

感谢 MTO-Platform（MToP）及其作者提供多任务优化实验框架。使用相关代码开展研究时，请引用：

```
Y. Li, W. Gong, F. Ming, T. Zhang, S. Li, and Q. Gu, "MToP: A MATLAB Optimization Platform for Evolutionary Multitasking," 2023, arXiv:2312.08134.
```

