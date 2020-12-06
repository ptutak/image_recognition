function [load_function] = simple_image_load(image_size)
    cropped_image_size = image_size(1:2);
    function [data] = simple_load(file_name)
        [image, cmap] = imread(file_name);
        if size(size(image)) == [1 2]
            if isempty(cmap)
                image = cat(3, image, image, image);
            else
                image = ind2rgb(image, cmap);
            end
        end
        data = imresize(image, cropped_image_size);
    end
    load_function = @simple_load;
end

