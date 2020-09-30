function image = canny_algorithm(image)
    std = std2(image)^2;
    image = imbilatfilt(image,2*std);

    image = image(:,:,2);
    image = imadjust(image);
    image = imsharpen(image);
    image = medfilt2(image); 
%     contrast limited adaptive histogram equalization (CLAHE)
    image = adapthisteq(image);

    % filter
    sigma = 6;
    masksize = 2*(sigma*2.5);
    filter = fspecial('gaussian', masksize, sigma);

%     % convolution with gaussian filter
    image = conv2(image, filter, 'valid');

%     generate threshold values using mean and stdv of image  
    lowthresh = max(1,(mean2(image)-std2(image)))/255;
    highthresh = min(254,(mean2(image)+std2(image)))/255;
    thresh = [lowthresh highthresh];

    image = edge(image,'canny',thresh);
end

