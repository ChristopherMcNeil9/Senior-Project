function [ret_bar] = plot_2Dpixel_density(reduced_pix_density, g_title, xtick_scale)
    %PLOT_PIXEL_DENSITY Plots the root pixel density into a histogram like
    %bar graph.
    ret_bar = figure('visible','off');
    l_length = length(reduced_pix_density);
    range = (1:l_length);
    bar(range, reduced_pix_density);
    title(g_title);
    xlabel('X');
    ylabel('Number of Pixels');
    
    xticks = get(gca,'xtick');
    newlabels = arrayfun(@(range) sprintf('%d', range * xtick_scale), xticks, 'un', 0);
    set(gca, 'xticklabel', newlabels);
    
    h = zoom;
    set(h,'ActionPostCallback',{@zoomCallback, xtick_scale});
    set(h,'Enable','on');
    
end

function zoomCallback(obj, evd, scale) %#ok<INUSL>
    newLim = evd.Axes.XLim; %#ok<NASGU>
    xticks = get(gca,'xtick');
    newlabels = arrayfun(@(newLim) sprintf('%d', newLim * scale), xticks, 'un', 0);
    set(gca, 'xticklabel', newlabels);    
end
