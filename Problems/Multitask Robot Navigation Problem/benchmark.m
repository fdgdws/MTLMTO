function [Tasks] = benchmark(index)
    file_dir = [fullfile(fileparts(mfilename('fullpath')), 'Maps'), filesep];
    switch(index)
        case 1 
            load([file_dir, 'map_20_1.mat']);
            dim = 25;
            Tasks(1).Dim = dim;
            for i = 1:length(obstacle1)
                obstacle_temp(i) = obstacle(obstacle1(i,1), obstacle1(i,2));
            end
            p_start = point(p_start1(1), p_start1(2));
            p_goal = point(p_goal1(1), p_goal1(2));
            Tasks(1).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(1).Lb = 0 * ones(1, dim); 
            Tasks(1).Ub = 1 * ones(1, dim); 
            
            dim = 25;
            Tasks(2).Dim = dim;
            for i = 1:length(obstacle2)
                obstacle_temp(i) = obstacle(obstacle2(i,1), obstacle2(i,2));
            end
            p_start = point(p_start2(1), p_start2(2));
            p_goal = point(p_goal2(1), p_goal2(2));
            Tasks(2).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(2).Lb = 0 * ones(1, dim); 
            Tasks(2).Ub = 1 * ones(1, dim); 
        case 2 
            load([file_dir, 'map_20_2.mat']);
            dim = 25;
            Tasks(1).Dim = dim;
            for i = 1: length(obstacle1)
                obstacle_temp(i) = obstacle(obstacle1(i,1), obstacle1(i,2));
            end
            p_start = point(p_start1(1), p_start1(2));
            p_goal = point(p_goal1(1), p_goal1(2));
            Tasks(1).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(1).Lb = 0 * ones(1, dim); 
            Tasks(1).Ub = 1 * ones(1, dim); 
            
            dim = 25;
            Tasks(2).Dim = dim;
            for i = 1:length(obstacle2)
                obstacle_temp(i) = obstacle(obstacle2(i,1), obstacle2(i,2));
            end
            p_start = point(p_start2(1),p_start2(2));
            p_goal = point(p_goal2(1),p_goal2(2));
            Tasks(2).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(2).Lb = 0 * ones(1, dim); 
            Tasks(2).Ub = 1 * ones(1, dim); 
        case 3 
            load([file_dir, 'map_20_1.mat']);
            dim = 50;
            Tasks(1).Dim = dim;
            for i = 1:length(obstacle1)
                obstacle_temp(i) = obstacle(obstacle1(i,1), obstacle1(i,2));
            end
            p_start = point(p_start1(1), p_start1(2));
            p_goal = point(p_goal1(1), p_goal1(2));
            Tasks(1).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(1).Lb = 0 * ones(1, dim); 
            Tasks(1).Ub = 1 * ones(1, dim); 
            
            dim = 50;
            Tasks(2).Dim = dim;
            for i = 1:length(obstacle2)
                obstacle_temp(i) = obstacle(obstacle2(i,1), obstacle2(i,2));
            end
            p_start = point(p_start2(1),p_start2(2));
            p_goal = point(p_goal2(1),p_goal2(2));
            Tasks(2).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(2).Lb = 0 * ones(1, dim); 
            Tasks(2).Ub = 1 * ones(1, dim); 
        case 4 
            load([file_dir, 'map_20_2.mat']);
            dim = 50;
            Tasks(1).Dim = dim;
            for i = 1:length(obstacle1)
                obstacle_temp(i) = obstacle(obstacle1(i,1), obstacle1(i,2));
            end
            p_start = point(p_start1(1), p_start1(2));
            p_goal = point(p_goal1(1), p_goal1(2));
            Tasks(1).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(1).Lb = 0 * ones(1, dim); 
            Tasks(1).Ub = 1 * ones(1, dim); 
            
            dim = 50;
            Tasks(2).Dim = dim;
            for i = 1:length(obstacle2)
                obstacle_temp(i) = obstacle(obstacle2(i,1), obstacle2(i,2));
            end
            p_start = point(p_start2(1),p_start2(2));
            p_goal = point(p_goal2(1),p_goal2(2));
            Tasks(2).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(2).Lb = 0 * ones(1, dim); 
            Tasks(2).Ub = 1 * ones(1, dim); 
        case 5 
            load([file_dir, 'map_20_3.mat']);
            dim = 50;
            Tasks(1).Dim = dim;
            for i = 1:length(obstacle1)
                obstacle_temp(i) = obstacle(obstacle1(i,1), obstacle1(i,2));
            end
            p_start = point(p_start1(1), p_start1(2));
            p_goal = point(p_goal1(1), p_goal1(2));
            Tasks(1).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(1).Lb = 0 * ones(1, dim); 
            Tasks(1).Ub = 1 * ones(1, dim); 
            
            dim = 50;
            Tasks(2).Dim = dim;
            for i = 1:length(obstacle2)
                obstacle_temp(i) = obstacle(obstacle2(i,1), obstacle2(i,2));
            end
            p_start = point(p_start2(1),p_start2(2));
            p_goal = point(p_goal2(1),p_goal2(2));
            Tasks(2).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(2).Lb = 0 * ones(1, dim); 
            Tasks(2).Ub = 1 * ones(1, dim); 
        case 6 
            load([file_dir, 'map_20_4.mat']);
            dim = 50;
            Tasks(1).Dim = dim;
            for i = 1:length(obstacle1)
                obstacle_temp(i) = obstacle(obstacle1(i,1), obstacle1(i,2));
            end
            p_start = point(p_start1(1), p_start1(2));
            p_goal = point(p_goal1(1), p_goal1(2));
            Tasks(1).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(1).Lb = 0 * ones(1, dim); 
            Tasks(1).Ub = 1 * ones(1, dim); 
            
            dim = 50;
            Tasks(2).Dim = dim;
            for i = 1:length(obstacle2)
                obstacle_temp(i) = obstacle(obstacle2(i,1), obstacle2(i,2));
            end
            p_start = point(p_start2(1),p_start2(2));
            p_goal = point(p_goal2(1),p_goal2(2));
            Tasks(2).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(2).Lb = 0 * ones(1, dim); 
            Tasks(2).Ub = 1 * ones(1, dim); 
        case 7 
            load([file_dir, 'map_20_1.mat']);
            dim = 100;
            Tasks(1).Dim = dim;
            for i = 1:length(obstacle1)
                obstacle_temp(i) = obstacle(obstacle1(i,1), obstacle1(i,2));
            end
            p_start = point(p_start1(1), p_start1(2));
            p_goal = point(p_goal1(1), p_goal1(2));
            Tasks(1).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(1).Lb = 0 * ones(1, dim); 
            Tasks(1).Ub = 1 * ones(1, dim); 
            
            dim = 100;
            Tasks(2).Dim = dim;
            for i = 1:length(obstacle2)
                obstacle_temp(i) = obstacle(obstacle2(i,1), obstacle2(i,2));
            end
            p_start = point(p_start2(1),p_start2(2));
            p_goal = point(p_goal2(1),p_goal2(2));
            Tasks(2).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(2).Lb = 0 * ones(1, dim); 
            Tasks(2).Ub = 1 * ones(1, dim); 
        case 8 
            load([file_dir, 'map_20_2.mat']);
            dim = 100;
            Tasks(1).Dim = dim;
            for i = 1:length(obstacle1)
                obstacle_temp(i) = obstacle(obstacle1(i,1), obstacle1(i,2));
            end
            p_start = point(p_start1(1), p_start1(2));
            p_goal = point(p_goal1(1), p_goal1(2));
            Tasks(1).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(1).Lb = 0 * ones(1, dim); 
            Tasks(1).Ub = 1 * ones(1, dim); 
            
            dim = 100;
            Tasks(2).Dim = dim;
            for i = 1:length(obstacle2)
                obstacle_temp(i) = obstacle(obstacle2(i,1), obstacle2(i,2));
            end
            p_start = point(p_start2(1),p_start2(2));
            p_goal = point(p_goal2(1),p_goal2(2));
            Tasks(2).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(2).Lb = 0 * ones(1, dim); 
            Tasks(2).Ub = 1 * ones(1, dim); 
        case 9 
            load([file_dir, 'map_50_1.mat']);
            dim = 50;
            Tasks(1).Dim = dim;
            for i = 1:length(obstacle1)
                obstacle_temp(i) = obstacle(obstacle1(i,1), obstacle1(i,2));
            end
            p_start = point(p_start1(1), p_start1(2));
            p_goal = point(p_goal1(1), p_goal1(2));
            Tasks(1).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(1).Lb = 0 * ones(1, dim); 
            Tasks(1).Ub = 1 * ones(1, dim); 
            
            dim = 50;
            Tasks(2).Dim = dim;
            for i = 1:length(obstacle2)
                obstacle_temp(i) = obstacle(obstacle2(i,1), obstacle2(i,2));
            end
            p_start = point(p_start2(1),p_start2(2));
            p_goal = point(p_goal2(1),p_goal2(2));
            Tasks(2).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(2).Lb = 0 * ones(1, dim); 
            Tasks(2).Ub = 1 * ones(1, dim); 
        case 10 
            load([file_dir, 'map_50_2.mat']);
            dim = 50;
            Tasks(1).Dim = dim;
            for i = 1:length(obstacle1)
                obstacle_temp(i) = obstacle(obstacle1(i,1), obstacle1(i,2));
            end
            p_start = point(p_start1(1), p_start1(2));
            p_goal = point(p_goal1(1), p_goal1(2));
            Tasks(1).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(1).Lb = 0 * ones(1, dim); 
            Tasks(1).Ub = 1 * ones(1, dim); 
            
            dim = 50;
            Tasks(2).Dim = dim;
            for i = 1:length(obstacle2)
                obstacle_temp(i) = obstacle(obstacle2(i,1), obstacle2(i,2));
            end
            p_start = point(p_start2(1),p_start2(2));
            p_goal = point(p_goal2(1),p_goal2(2));
            Tasks(2).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(2).Lb = 0 * ones(1, dim); 
            Tasks(2).Ub = 1 * ones(1, dim); 
        case 11 
            load([file_dir, 'map_20_1.mat']);
            dim = 50;
            Tasks(1).Dim = dim;
            for i = 1:length(obstacle1)
                obstacle_temp(i) = obstacle(obstacle1(i,1), obstacle1(i,2));
            end
            p_start = point(p_start1(1), p_start1(2));
            p_goal = point(p_goal1(1), p_goal1(2));
            Tasks(1).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(1).Lb = 0 * ones(1, dim); 
            Tasks(1).Ub = 1 * ones(1, dim); 
            
            dim = 25;
            Tasks(2).Dim = dim;
            for i = 1:length(obstacle2)
                obstacle_temp(i) = obstacle(obstacle2(i,1), obstacle2(i,2));
            end
            p_start = point(p_start2(1),p_start2(2));
            p_goal = point(p_goal2(1),p_goal2(2));
            Tasks(2).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(2).Lb = 0 * ones(1, dim); 
            Tasks(2).Ub = 1 * ones(1, dim); 

        case 12 
            load([file_dir, 'map_20_2.mat']);
            dim = 50;
            Tasks(1).Dim = dim;
            for i = 1:length(obstacle1)
                obstacle_temp(i) = obstacle(obstacle1(i,1), obstacle1(i,2));
            end
            p_start = point(p_start1(1), p_start1(2));
            p_goal = point(p_goal1(1), p_goal1(2));
            Tasks(1).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(1).Lb = 0 * ones(1, dim); 
            Tasks(1).Ub = 1 * ones(1, dim); 

            dim = 25;
            Tasks(2).Dim = dim;
            for i = 1:length(obstacle2)
                obstacle_temp(i) = obstacle(obstacle2(i,1), obstacle2(i,2));
            end
            p_start = point(p_start2(1),p_start2(2));
            p_goal = point(p_goal2(1),p_goal2(2));
            Tasks(2).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(2).Lb = 0 * ones(1, dim); 
            Tasks(2).Ub = 1 * ones(1, dim); 
        case 13 
            load([file_dir, 'map_20_1.mat']);
            dim = 25;
            Tasks(1).Dim = dim;
            for i = 1:length(obstacle1)
                obstacle_temp(i) = obstacle(obstacle1(i,1), obstacle1(i,2));
            end
            p_start = point(p_start1(1), p_start1(2));
            p_goal = point(p_goal1(1), p_goal1(2));
            Tasks(1).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(1).Lb = 0 * ones(1, dim); 
            Tasks(1).Ub = 1 * ones(1, dim); 

            dim = 50;
            Tasks(2).Dim = dim;
            for i = 1:length(obstacle2)
                obstacle_temp(i) = obstacle(obstacle2(i,1), obstacle2(i,2));
            end
            p_start = point(p_start2(1),p_start2(2));
            p_goal = point(p_goal2(1),p_goal2(2));
            Tasks(2).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(2).Lb = 0 * ones(1, dim); 
            Tasks(2).Ub = 1 * ones(1, dim); 
        case 14 
            load([file_dir, 'map_20_2.mat']);
            dim = 25;
            Tasks(1).Dim = dim;
            for i = 1:length(obstacle1)
                obstacle_temp(i) = obstacle(obstacle1(i,1), obstacle1(i,2));
            end
            p_start = point(p_start1(1), p_start1(2));
            p_goal = point(p_goal1(1), p_goal1(2));
            Tasks(1).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(1).Lb = 0 * ones(1, dim); 
            Tasks(1).Ub = 1 * ones(1, dim); 

            dim = 50;
            Tasks(2).Dim = dim;
            for i = 1:length(obstacle2)
                obstacle_temp(i) = obstacle(obstacle2(i,1), obstacle2(i,2));
            end
            p_start = point(p_start2(1),p_start2(2));
            p_goal = point(p_goal2(1),p_goal2(2));
            Tasks(2).Fnc = @(x)rover_navigation(x, obstacle_temp, p_start, p_goal);
            Tasks(2).Lb = 0 * ones(1, dim); 
            Tasks(2).Ub = 1 * ones(1, dim); 
    end
	
end