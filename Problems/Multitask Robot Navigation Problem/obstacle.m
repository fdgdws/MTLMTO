classdef obstacle < handle
    properties
        % 中心点，障碍物为正方形，边长为0.05
        centre_x;
        centre_y;
        angle = point.empty;
    end
    methods
        function [obj] = obstacle(x, y)
            obj.centre_x = x;
            obj.centre_y = y;
            obj.angle(1) = point(x-0.025,y+0.025);
            obj.angle(2) = point(x+0.025,y+0.025);
            obj.angle(3) = point(x+0.025,y-0.025);
            obj.angle(4)= point(x-0.025,y-0.025);
        end
    end
end
    