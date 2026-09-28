classdef point < handle
    properties
        % 轨迹点，多个轨迹点（不同维度）连成一点线代表运行轨迹
        x;
        y;
    end
    
    methods
        function [obj] = point(x1,y1)
            obj.x = x1;
            obj.y = y1;
        end
    end
end