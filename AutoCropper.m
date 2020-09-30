function cropped_image = AutoCropper(image)
    % Predefined parameters
    f = @(span,width) 2.^(-((2/width*4)*(span-(width/2))).^2);
    g = @(span,height) 2.^(-((1/height*4)*(span-(height/4))).^2);
    
    height = size(image,1);
    width = size(image,2);
    crop_width = height*.45;
    crop_height = width*.45;
    
    %%% Crops Width
    % Creates a scalar function which is used to scale summed pixel value
    span = linspace(1,width,width);
    scalar = f(span,width);

    % Finds the summed pixel values for every column in green monochrome image
    values = sum((image(:,:,2)));
    values = values.*scalar;

    % finds a number of local maxima across the distribution and what their
    % indicies are
    TF = islocalmax(values);
    indicies = find(TF == 1);

    % determines the index closest to the middle point of the image
    [~,idx] = min(abs(indicies - width/2));

    % determines the 2nd closest index to middle point
    indicies2 = indicies(indicies~=indicies(idx));
    [~,idx2] = min(abs(indicies2 - width/2));

    % determines which of the two points has more green in a given column
    if values(indicies(idx)) > values(indicies2(idx2))
        centerpoint = indicies(idx);
    else
        centerpoint = indicies2(idx2);
    end

    % crops the iamge to a preset width around the center point
    cropped_image = imcrop(image,[centerpoint-crop_width/2,0,crop_width,height]);
    
    %%% Crops Height 
    % creates a scalar function to augment
    span = linspace(1,height,height);
    scalar = g(span,height);
    
    % sums and scales the distribution of pixel's values in each column
    values = sum(cropped_image(:,:,2)');
    values = values.*scalar;
    
    % finds the maximum point in the 
    m = max(values);
    index = find(values == m);
    
    % crops the image to a pre set height based upon the max
    cropped_image = imcrop(cropped_image,[0,index+(height/16),width,crop_height]);
end