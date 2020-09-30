# Senior-Project

This project was created in association with The Geisler & Geisler-Lee Laboratory and the department of Plant Biology at SIU

The purpose of this project was to create a more time effcient process for the analysis of images of root systems.  To perform analysis we needed to take an unedited input images, and automatically crop it down to size, find the edges of the root, and finally perform several types of analysis.  This is the code that accomplishes these goals

# How to use this code

The entry point into the program can be found in reader.m

This portion of the program handles all read/write functions along with directory management.  Lines 1-3 are to be changed depending upon the location of the prexisting (line 1) and where you want the canny output (line 2) and analysis data (line 3).  The root directory (rootdir) is to contain 
