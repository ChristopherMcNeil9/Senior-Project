Options.FreqLabelAngle = 305;
%number of sectors in the wind rose
Options.ndirections    = 10;
Options.radialgridnumber = 10;
%number of lines from origin to edge of wind rose
Options.nFreq = 4;
Options.LabLegend = 'Pixel Density';
Options.min_radius = 0;
Options.cMap = 'lines';
Options.LegendType = 2;
Options.legendvariable = 'P_D';
%scale of the actual wind rose
Options.scalefactor = 1;

%Options.figColor = 'k';
%Options.textColor = [1 1 0.5];
%Options.gridColor = 'w';

% :, -, or --
Options.gridstyle = '-';
Options.gridcolor = 'k';
Options.gridwidth = 1;
Options.gridalpha = 0.25;

Options.textfontname = 'Arial Black';
Options.titlefontname = 'Courier New';
Options.legendfontname = 'Calibri Light';

save('options.mat', 'Options');