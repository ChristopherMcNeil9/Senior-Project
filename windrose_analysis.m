function h = windrose_analysis(raw_3D_data)
    h = figure('visible','off');
    maximum = max(max(raw_3D_data));
    [origin_x,origin_y]=find(raw_3D_data==maximum);
    if size(origin_x,1) > 1
       origin_x = origin_x(1);
       origin_y = origin_y(1);
    end
    width = size(raw_3D_data, 1);
    height = size(raw_3D_data, 2);

    direction = zeros(1, width*height);
    speed = zeros(1, width*height);

    for i = 1:width-1
        for j = 1:height-1
            x = i - origin_x;
            y = j - origin_y;
            theta = atan2(y, x) * 180 / pi;
            if theta < 0
                theta = theta + 360;
            end
            direction(i * height + j) = theta;
            speed(i * height + j) = raw_3D_data(i, j);
        end
    end
    load options.mat;
    [h,~,~,~,~] = WindRose(direction, speed, Options);
end