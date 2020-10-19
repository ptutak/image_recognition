training = load_images(fullfile(pwd,'imagenette2/train'), [256, 256, 3])
validation = load_images(fullfile(pwd, "imagenette2/val"), [256, 256, 3])
options = trainingOptions(...
    'sgdm',...
    'MaxEpochs',100,...
    "InitialLearnRate", 0.01,...
    'MiniBatchSize',10,...
    'ValidationData',validation, ...
    'ValidationFrequency',1000, ...
    'Verbose',false, ...
    'Plots','training-progress');
layers = load_layers
trainNetwork(training, layers, options)