rootdir = './test_data';
canny_outputdir = './test_data_Canny/';
analysis_outputdir = './test_data_Analysis/';

filelist = dir(fullfile(rootdir, '**/*.jpg'));  %get list of files and folders in any subfolder
filelist = filelist(~[filelist.isdir]);  %remove folders from list

% removes white field images that were in certain data sets
indicies = find(contains({filelist.name}, 'white')==1);
filelist(indicies) = [];
indicies = find(contains({filelist.name}, 'BF')==1);
filelist(indicies) = [];
raw_data2 = 0;
set(groot,'defaultFigureVisible','off')

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
        
        % writes the new image to a given directory
        new_filename = strcat(canny_outputdir,name,"_cropped",".png");
        imwrite(c_image, new_filename);
        
        %%% analysis of the post canny images
        
        % gets the numerical data of the image
        [raw_data1,raw_data2] = reduce_pixel_density(c_image,raw_data2);
        % plots the figure and returns a handle to the variable
        h = plot_2Dpixel_density(raw_data2,"title",9);
        % saves the individual plot using the handle
        saveas(h,strcat(analysis_outputdir,name,"_2D_analysis"),'jpg');
        
        % only runs 3d analysis for the A and B sides of image *assumes 
        if mod(i,2) == 0 && mod(i,4) ~= 0
            % returns 3d bar graph, and raw numerical data of 3d bar graph
            [h, raw_3D_data] = plot_3Dpixel_density(raw_data1, raw_data2);
            saveas(h,strcat(analysis_outputdir,name,"_3D_analysis"),'jpg');
            
            % wind rose
            h = windrose_analysis(raw_3D_data);
            saveas(h,strcat(analysis_outputdir,name,"_windrose"),'jpg');
        end
    end
    
    if mod(i,4) == 0
        fprintf("%d out of %d completed\n",i,size(filelist,1))
    end
end
clear;
% delete(findall(0));
