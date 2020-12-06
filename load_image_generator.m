
function [load_image_function] = load_image_generator(image_size)
    function [image] = load_image(image_path)
        read_image = imread(image_path);
        read_image_size = size(read_image);
        max_size = max(read_image_size(1:2));
        min_size = min(read_image_size(1:2));
        offset = floor((max_size - min_size) / 2);
        if read_image_size(1) > read_image_size(2)
            image = imresize(...
                imcrop(read_image, [0, offset, min_size, min_size]),...
                image_size);
        else
            image = imresize(...
                imcrop(read_image, [offset, 0, min_size, min_size]),...
                image_size);
        end
    end
    load_image_function = @load_image;
end
