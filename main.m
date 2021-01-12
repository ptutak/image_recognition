image_size = [224, 224, 3];

[~, training] = load_images(...
    fullfile(pwd,'imagenette2/train'),...
    image_size,...
    @imread);

[raw_validation, ~] = load_images(...
    fullfile(pwd, 'imagenette2/val'),...
    image_size,...
    simple_image_load(image_size));

options = trainingOptions(...
    'adam',...
    'LearnRateSchedule', 'piecewise',...
    'LearnRateDropFactor', 0.65,...
    'LearnRateDropPeriod', 4,...
    'MaxEpochs', 100,...
    'InitialLearnRate', 0.0001,...
    'MiniBatchSize', 10,...
    'ValidationData', raw_validation,...
    'ValidationFrequency', 946,...
    'ValidationPatience', 4,...
    'Verbose', false,...
    'ExecutionEnvironment', 'gpu',...
    'CheckpointPath', fullfile(pwd, 'checkpoints'),...
    'Plots','training-progress')

layers = load_layers(image_size)

image_recognition_net = trainNetwork(training, layers, options)

YTest = raw_validation.Labels;
YPred = classify(image_recognition_net, raw_validation);

accuracy = sum(YPred == YTest) / numel(YTest)
accuracy_str = strrep(num2str(accuracy * 100, '%.2f'), '.', '_');
path = ['nets/', 'image_recognition_net_', accuracy_str];

save(path)