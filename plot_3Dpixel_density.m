function [h, raw_3D_data] = plot_3Dpixel_density(image1_data, image2_data)
    % takes two numerical data and combines them into a 3D graph
    h = figure('visible','off');
    raw_3D_data = image1_data.' * image2_data;
    bar3(raw_3D_data);
end