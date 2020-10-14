# **Senior-Project**

This project was created in association with The Geisler & Geisler-Lee Laboratory and the department of Plant Biology at SIU

The purpose of this project was to create a more time effcient process for the analysis of images of root systems.  To perform analysis we needed to take an unedited input images, and automatically crop it down to size, find the edges of the root, and finally perform several types of analysis.  This is the code that accomplishes these goals

# 1.0 How to use this code

The entry point into the program can be found in reader.m

This portion of the program handles all read/write functions along with directory management.  Lines 1-3 are to be changed depending upon the location of the prexisting images (line 1) and where you want the canny output (line 2) and analysis data (line 3).  The root directory (rootdir) is to contain images in JPG form, this is case-sensitive but can be changed on line 5

The rest of this code is broken into 3 main sections, an autocropper, canny edge detection, and analysis.

# 2.0 Autocropper

This section takes an image and reduces it size to encompass the root system.  It uses the pixel density of a green-scale image to find the points with the highest concentrations of green then uses a modified gaussian scalar to remove outliers near the edges while making the probable center point closer to the center of the image.

![x axis](http://75.66.68.24:13689/image1.png?raw=true)

![Image of Yaktocat](https://octodex.github.com/images/yaktocat.png)
