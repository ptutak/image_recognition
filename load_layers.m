function [layers] = load_layers(input_size)
    layers = [
        imageInputLayer(input_size)
        
        convolution2dLayer(3,64,'Padding','same')
        batchNormalizationLayer
        reluLayer

        convolution2dLayer(3,64,'Padding','same')
        batchNormalizationLayer
        reluLayer

        convolution2dLayer(3,64,'Padding','same')
        batchNormalizationLayer
        reluLayer
        
        maxPooling2dLayer(2,'Stride',2)

        convolution2dLayer(3,64,'Padding','same')
        batchNormalizationLayer
        reluLayer
        
        convolution2dLayer(3,64,'Padding','same')
        batchNormalizationLayer
        reluLayer
 
        convolution2dLayer(3,64,'Padding','same')
        batchNormalizationLayer
        reluLayer

        maxPooling2dLayer(2,'Stride',2)

        convolution2dLayer(3,128,'Padding','same')
        batchNormalizationLayer
        reluLayer
        
        convolution2dLayer(3,128,'Padding','same')
        batchNormalizationLayer
        reluLayer
        
        convolution2dLayer(3,128,'Padding','same')
        batchNormalizationLayer
        reluLayer

        maxPooling2dLayer(2,'Stride',2)

        convolution2dLayer(3,256,'Padding','same')
        batchNormalizationLayer
        reluLayer

        convolution2dLayer(3,256,'Padding','same')
        batchNormalizationLayer
        reluLayer

        convolution2dLayer(3,256,'Padding','same')
        batchNormalizationLayer
        reluLayer

        maxPooling2dLayer(2,'Stride',2)

        convolution2dLayer(3,512,'Padding','same')
        batchNormalizationLayer
        reluLayer

        convolution2dLayer(3,512,'Padding','same')
        batchNormalizationLayer
        reluLayer

        convolution2dLayer(3,512,'Padding','same')
        batchNormalizationLayer
        reluLayer

        averagePooling2dLayer(2,'Stride',2)

        fullyConnectedLayer(1024)
        reluLayer

        dropoutLayer(0.4)

        fullyConnectedLayer(1024)
        reluLayer
    
        fullyConnectedLayer(10)

        softmaxLayer
        classificationLayer
    ];
end

