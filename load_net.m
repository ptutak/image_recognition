function [output] = load_net(file_path)
    file_path
    load(file_path,...
        'accuracy',...
        'image_recognition_net',...
        'options',...
        'training');
    output = struct;
    
    layer_strings = {};
    for i = 1:length(image_recognition_net.Layers)
        layer = image_recognition_net.Layers(i);
        layer_name = '';
        if startsWith(layer.Name, 'conv')
            filter_size = [num2str(layer.FilterSize(1)), 'x', num2str(layer.FilterSize(2))];
            layer_name = ['Conv, ', filter_size, ', ', num2str(layer.NumFilters)];
        elseif startsWith(layer.Name, 'maxpool')
            pool_size = [num2str(layer.PoolSize(1)), 'x', num2str(layer.PoolSize(2))];
            layer_name = ['MaxPool, ', pool_size];
        elseif startsWith(layer.Name, 'avgpool')
            pool_size = [num2str(layer.PoolSize(1)), 'x', num2str(layer.PoolSize(2))];
            layer_name = ['AvgPool, ', pool_size];
        elseif startsWith(layer.Name, 'dropout')
            layer_name = ['Dropout, ', num2str(layer.Probability)];
        elseif startsWith(layer.Name, 'fc')
            layer_name = ['FullyConnected, ', num2str(min(layer.InputSize, layer.OutputSize))];
        elseif startsWith(layer.Name, 'softmax')
            layer_name = ['SoftMax'];
        elseif startsWith(layer.Name, 'classoutput')
            layer_name = ['ClassOutput, ', num2str(layer.OutputSize)];
        elseif startsWith(layer.Name, 'imageinput')
            input_size = [num2str(layer.InputSize(1)), 'x', num2str(layer.InputSize(2))];
            layer_name = ['ImageInput, ', input_size];
        end
        if ~ strcmp(layer_name, '')
            layer_strings = [layer_strings; string(layer_name)];
        end
    end
    
    output.layers = layer_strings;
    output.accuracy = accuracy;
    option_output = struct;
    if isa(options, 'nnet.cnn.TrainingOptionsSGDM')
        option_output.optimizer = "SGDM";
    else
        option_output.optimizer = "ADAM";
    end
    option_output.learn_rate = options.InitialLearnRate;
    option_output.patience = options.ValidationPatience;
    option_output.drop_period = options.LearnRateScheduleSettings.DropPeriod;
    option_output.drop_rate_factor = options.LearnRateScheduleSettings.DropRateFactor;
    if ~ isa(training.DataAugmentation, 'imageDataAugmenter')
        option_output.image_augmentation = "No";
    else
        option_output.image_augmentation = "Yes";
    end
    output.options = option_output;
end