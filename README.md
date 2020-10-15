# **Senior-Project**

This project was created in association with The Geisler & Geisler-Lee Laboratory and the department of Plant Biology at SIU

The purpose of this project was to create a more time efficient process for the analysis of images of root systems.  To perform analysis we needed to take an unedited input images, and automatically crop it down to size, find the edges of the root, and finally perform several types of analysis.  This is the code that accomplishes these goals.

# 1.0 How to use this code

The entry point into the program can be found in reader.m

This portion of the program handles all read/write functions along with directory management.  Lines 1-3 are to be changed depending upon the location of the pre-existing images (line 1) and where you want the canny output (line 2) and analysis data (line 3).  Folders currently need to be created manually before running the code!  The root directory (rootdir) is to contain images in JPG form, this is case-sensitive but can be changed on line 5

The rest of this code is broken into 3 main functions, an Autocropper, canny edge detection, and analysis.

# 2.0 Autocropper

This section takes an image and reduces it size to encompass the root system.  It uses the pixel density of a green-scale image to find the points with the highest concentrations of green then uses a modified Gaussian scalar to remove outliers near the edges while making the probable center point closer to the center of the image.

The same methodology is used when determining the top of the cropped image as well, but with a different Gaussian scalar that is weighted towards the top of the image.  (For visualization please see attached PowerPoint to this project)

Currently, this methodology uses static boxes 45% of the width and height of the original image. This can be changed on lines 9 and 10 of Autocropper.m respectively.  This ensures a constant pixel width for all cropped images which is important so that the analysis does not try to compare alternate sized images.

# 2.1 Canny edge detection

The canny edge detection takes the cropped image and finds the strongest edges of root system while trying to minimize noise within the image. Noise is reduced by pre-processing using a series of filters.

Canny will produce the best results when the image is clear and sharp due to the low noise within the image.  Images that are blurry will intrinsically do worse during Canny edge detection.

The most important thing here is line 31 which contains the numerical values that canny will use as a threshold for determining what is and isn't an edge.  This value was chosen by getting an average of thresholds.  It was chosen as slightly less than that average due to the idea that it would be better to have the root system plus a bit extra than to be missing part of the root system.

# 2.2 Analysis

The analysis takes several forms.  The first which is calculated for every image is the pixel density in two dimensions.  This is the same relative methodology as the Autocropper uses for finding pixel density, except that it is then reduced so that groups of 100 pixels are together for easier human viewing.

The second form of analysis is 3d pixel density which takes two 2d pixel densities and utilizes them to form a 3 dimensional analysis.

The final form of analysis is a Windrose which uses the 3d analysis to form a circular analysis.  This uses Windrose code available through the MATLAB file exchange.

# 2.3 Other code/files

options.m creates a .mat file that contains a struct with all the arguments that will be passed to windrose to make it more human readable.

reduce_pixel_density.m is used as an auxiliary function during analysis and is what reduces the pixel density to groups of 100 pixels.

test_data is a folder containing 80 images that can be used to run code with.

test_data_(Analysis/Canny) are empty output folders for the program to put the respective images.

Root Access Poster is a PowerPoint that contains visual representations of what each step is doing.

# 3.0 Known Issues

There are several minor known issues and quality of life improvements missing that are known
1. Folders are not automatically created if missing
2. All output is of canny and analysis are mixed together in 1 file rather than maintaining cohesive file structure of original file
3. No parallelization is done to increase speed
4. During canny the bottom of the box will often appear as an edge
5. Due to (4) analysis will sometimes have outliers toward the edges

# 3.1 Major issues

There is 1 known major issue on line 14 of reader.m

This line suppresses MATLAB from having images and graphs popup upon calculation.  However, the graphs and images are still created in the background taking up space in RAM.  As such after a few hundred images MATLAB will start to slow down and may even crash.  In addition, this affects MATLAB's root which means that after this line runs it will affect graphs created by other programs not associated with this program until MATLAB is restarted.

# 4.0 Possible improvements

There are several ways that the code can be improved in the future.

1. Removal of stray edges post-canny
    After canny some images will have small lines that are not part of the root system.  It should be likely that some kind of continuity checker can see if all pixels are part of a single object, and if not remove the parts that are separated.
    
2. Increased speed through parallelization
    Each image tends to take a second or two to process when done consecutively.  This could be increased by doing images in parallel across multiple    threads/processes.  The parts that would benefit the most is Canny and Analysis due to those parts taking the largest percentage of the processing time.
    
3. More user options
    This code was set up with variables within the code needing to be changed, it would be better if the user could give input options while calling the entire program as a function
    
4. Better file management
    At present this code just outputs all images to a shared directory ignoring all file structure of the input directory.  It would be better if the output was structured in a similar way to the input with MATLAB dynamically creating new files with similar names as the originals.
