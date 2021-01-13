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
            layer_name = [
                'Conv, ', 'FilterSize: ', num2str(layer.FilterSize), ', ', 'FilterNumber: ', num2str(layer.NumFilters)
            ];
        elseif startsWith(layer.Name, 'maxpool')
            layer_name = ['MaxPool, ', 'PoolSize: ', num2str(layer.PoolSize), ', ', 'Stride: ', num2str(layer.Stride)];
        elseif startsWith(layer.Name, 'avgpool')
            layer_name = ['AvgPool, ', 'PoolSize: ', num2str(layer.PoolSize), ', ', 'Stride: ', num2str(layer.Stride)];
        elseif startsWith(layer.Name, 'dropout')
            layer_name = ['Dropout, ', 'Probability: ', num2str(layer.Probability)];
        elseif startsWith(layer.Name, 'fc')
            layer_name = ['FullyConnected, ', 'NeuronNumber: ', num2str(min(layer.InputSize, layer.OutputSize))];
        elseif startsWith(layer.Name, 'softmax')
            layer_name = ['SoftMax'];
        elseif startsWith(layer.Name, 'classoutput')
            layer_name = ['ClassOutput, ', 'ClassNumber: ', num2str(layer.OutputSize)];
        elseif startsWith(layer.Name, 'imageinput')
            layer_name = ['ImageInput, ', 'InputSize: ', num2str(layer.InputSize)];
        end
        if ~ strcmp(layer_name, '')
            layer_strings = [layer_strings; layer_name];
        end
    end
    
    output.layers = layer_strings;
    output.accuracy = accuracy;
    option_output = struct;
    option_output.optimizer = class(options);
    option_output.learn_rate = options.InitialLearnRate;
    option_output.patience = options.ValidationPatience;
    option_output.drop_period = options.LearnRateScheduleSettings.DropPeriod;
    option_output.drop_rate_factor = options.LearnRateScheduleSettings.DropRateFactor;
    if ~ isa(training.DataAugmentation, 'imageDataAugmenter')
        option_output.image_augmentation = "None";
    else
        option_output.image_augmentation = "RandXScale: [0.9000 1.1000], RandYScale: [0.9000 1.1000], RandXTranslation: [-30 30], RandYTranslation: [-30 30]";
    end
    output.options = option_output;
end