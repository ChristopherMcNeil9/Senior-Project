# **Senior-Project**

This project was created in association with The Geisler & Geisler-Lee Laboratory and the department of Plant Biology at SIU

The purpose of this project was to create a more time effcient process for the analysis of images of root systems.  To perform analysis we needed to take an unedited input images, and automatically crop it down to size, find the edges of the root, and finally perform several types of analysis.  This is the code that accomplishes these goals

# 1.0 How to use this code

The entry point into the program can be found in reader.m

This portion of the program handles all read/write functions along with directory management.  Lines 1-3 are to be changed depending upon the location of the prexisting images (line 1) and where you want the canny output (line 2) and analysis data (line 3).  Folders are currently need to be created manually before running the code!  The root directory (rootdir) is to contain images in JPG form, this is case-sensitive but can be changed on line 5

The rest of this code is broken into 3 main sections, an autocropper, canny edge detection, and analysis.

# 2.0 Autocropper

This section takes an image and reduces it size to encompass the root system.  It uses the pixel density of a green-scale image to find the points with the highest concentrations of green then uses a modified gaussian scalar to remove outliers near the edges while making the probable center point closer to the center of the image.

The same methodology is used when determing the top of the cropped image as well, but with a different gassian scalar that is weighted towards the top of the image.  (For visualization please see attached powerpoint to this project)

Currently this methodology uses static boxes 45% of the width and height of the original image. This can be changed on lines 9 and 10 of Autocropper.m respectively.
This ensures a constant pixel width for all cropped images which is important so that the analysis does not try to compare alternate sized images.

# 2.1 Canny edge detection

The canny edge detection takes the cropped image and finds the strongest edges of root system while trying to minimize noise within the image. Noise is reduced by preprocessing using a series of filters.

Canny will produce the best results when the image is clear and sharp due to the low noise within the image.  Images that are blurry will intrinsically do worse during Canny edge detection.

# 2.2 Analysis

The analysis takes several forms.  The first which is calculated for every image is the pixel density in two dimensions.  This is the same relative methodolgy as the autocropper uses for finding pixel density, except that it is then reduced so that groups of 100 pixels are together for easier human viewing.

The second form of analysis is 3d pixel density which takes two 2d pixel densities and utilizes them to form a 3 dimensional analysis.

The final form of analysis is a Windrose which uses the 3d analysis to form a circular analysis.  This uses Windrose code avaliable through the MATLAB file exchange.

# Other code

options.m creates a .mat file that contains a struct with all the arugments that will be passed to windrose to make it more human readable.

reduce_pixel_density.m is used as an auxillary function during analysis and is what reduces the pixel density to groups of 100 pixels

# 3.0 Known Issues

There are several minor known issues and quality of life improvements missing that are known
1. Folders are not auto created if missing
2. All output is of canny and analysis are mixed together in 1 file rather than maintaining cohesive file structure of orignal file
3. No parallelization is done to increase speed
4. During canny the bottom of the box will often appear as an edge
5. Due to (4) analysis will sometimes have outliers toward the edges

# 3.1 Major issues

There is 1 known major issue on line 14 of reader.m

This line suppresses MATLAB from having images and graphs popup upon calculation.  However, the graphs and images are still created in the background taking up space in RAM.  As such after a few hundred images MATLAB will start to slow down and may even crash.  In addition this affects MATLAB's root which means that after this line runs it will affect graphs created by other programs not associated with this program until MATLAB is restarted.
