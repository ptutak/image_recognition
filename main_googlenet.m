image_size = [224, 224, 3];

[raw_training, training] = load_images(...
    fullfile(pwd,'imagenette2/train'),...
    image_size,...
    @imread);

[raw_validation, ~] = load_images(...
    fullfile(pwd, 'imagenette2/val'),...
    image_size,...
    simple_image_load(image_size));

image_recognition_net = googlenet;


lgraph = layerGraph(image_recognition_net);


[learnable_layer, class_layer] = findLayersToReplace(lgraph);


number_of_classes = numel(categories(raw_training.Labels));


new_learnable_layer = fullyConnectedLayer(number_of_classes,...
    'Name', 'new_fully_connected',...
    'WeightLearnRageFactor', 10,...
    'BiasLearnRateFactor', 10);
new_class_layer = classificationLayer('Name', 'new_class_output');


lgraph.replaceLayer(learnable_layer.Name, new_learnable_layer);
lgraph.replaceLayer(class_layer.Name, new_class_layer);

layers = lgraph.Layers;
connections = lgraph.Connections;

layers(1:10) = freezeWeights(layers(1:10));

YTest = raw_validation.Labels;
YPred = classify(image_recognition_net, raw_validation);

accuracy = sum(YPred == YTest) / numel(YTest)
accuracy_str = strrep(num2str(accuracy * 100, '%.2f'), '.', '_');
path = ['nets/', 'googlenet_', accuracy_str];

save(path)