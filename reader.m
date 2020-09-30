tic;
rootdir = './senior_project/test_data';
outputdir = './senior_project/test_data_canny/';
% analysisdir = './senior_project/Analysis4/';

filelist = dir(fullfile(rootdir, '**/*.jpg'));  %get list of files and folders in any subfolder
filelist = filelist(~[filelist.isdir]);  %remove folders from list
indicies = find(contains({filelist.name}, 'white')==1);
filelist(indicies) = [];
indicies = find(contains({filelist.name}, 'BF')==1);
filelist(indicies) = [];
raw_data2 = 0;
% set(groot,'defaultFigureVisible','off')

% loops through every image in the directory, skipping brightfield images
for i = 1:size(filelist,1)
    
    if contains(filelist(i).name, "BF") == 0 && contains(filelist(i).name, "white") == 0
        % get info about the filename and reads in image
        [filepath,name,ext] = fileparts(filelist(i).name);
        image_name = strcat(filelist(i).folder,"/",filelist(i).name);
        image = imread(image_name);
        
        % crops the original image down to a new size
        image = AutoCropper(image);
        
        
        % uses canny edge detection on cropped images
        c_image = canny_algorithm(image);
        
% temp test code
image = imfuse(image, c_image, 'montage');
        % writes the new image to a given directory
        new_filename = strcat(outputdir,name,"_cropped",".png");
%         new_filename = strcat(outputdir,string(i),".JPG");
        imwrite(image, new_filename);
        
        %%% analysis of the post canny images
        
%         % gets the numerical data of the image
%         [raw_data1,raw_data2] = reduce_pixel_density(image,raw_data2);
%         % plots the figure and returns a handle to the variable
%         h = plot_2Dpixel_density(raw_data2,"title",9);
%         % saves the individual plot using the handle
%         saveas(h,strcat(analysisdir,name,"_2D_analysis"),'jpg');
%         
%         if mod(i,2) == 0 && mod(i,4) ~= 0
%             % returns 3d bar graph, and raw numerical data of 3d bar graph
%             [h, raw_3D_data] = plot_3Dpixel_density(raw_data1, raw_data2);
%             saveas(h,strcat(analysisdir,name,"_3D_analysis"),'jpg');
%             
%             % wind rose
%             h = windrose_analysis(raw_3D_data);
%             saveas(h,strcat(analysisdir,name,"_windrose"),'jpg');
%         end
    end
    
    if mod(i,4) == 0
        fprintf("%d out of %d completed\n",i,size(filelist,1))
    end
end
toc
clear;
% delete(findall(0));
