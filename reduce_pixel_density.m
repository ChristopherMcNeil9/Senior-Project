function [raw_data1,raw_data2] = reduce_pixel_density(image,input_data2)
    raw_data1 = input_data2;
    % predefined variables
    reduction = 100;

    % sums the pixel values of each column of the image
    pix_density = sum(image);
    width = length(pix_density);
    
    % removes extra pixels from the far end
    magnitude = idivide(width, int16(reduction));
    remainder = mod(width, magnitude);
    pix_density = pix_density(1:width-remainder);
    
    % condenses the summation from individual columns to groups of columns
    raw_data2 = sum(reshape(pix_density, idivide(width, int16(reduction)),[]));
end