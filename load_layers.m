function [layers] = load_layers(input_size)
    layers = [
        imageInputLayer(input_size)
        
        convolution2dLayer(3,64,'Padding','same')
        batchNormalizationLayer
        reluLayer

        convolution2dLayer(3,64,'Padding','same')
        batchNormalizationLayer
        reluLayer

        convolution2dLayer(1,64,'Padding','same')
        batchNormalizationLayer
        reluLayer
        
        maxPooling2dLayer(2,'Stride',2)

        convolution2dLayer(3,64,'Padding','same')
        batchNormalizationLayer
        reluLayer
        
        convolution2dLayer(3,64,'Padding','same')
        batchNormalizationLayer
        reluLayer
 
        convolution2dLayer(1,64,'Padding','same')
        batchNormalizationLayer
        reluLayer

        maxPooling2dLayer(2,'Stride',2)

        convolution2dLayer(3,128,'Padding','same')
        batchNormalizationLayer
        reluLayer
        
        convolution2dLayer(3,128,'Padding','same')
        batchNormalizationLayer
        reluLayer
        
        convolution2dLayer(1,128,'Padding','same')
        batchNormalizationLayer
        reluLayer

        maxPooling2dLayer(2,'Stride',2)

        convolution2dLayer(3,256,'Padding','same')
        batchNormalizationLayer
        reluLayer

        convolution2dLayer(3,256,'Padding','same')
        batchNormalizationLayer
        reluLayer

        convolution2dLayer(1,256,'Padding','same')
        batchNormalizationLayer
        reluLayer

        maxPooling2dLayer(2,'Stride',2)

        convolution2dLayer(3,512,'Padding','same')
        batchNormalizationLayer
        reluLayer

        convolution2dLayer(3,512,'Padding','same')
        batchNormalizationLayer
        reluLayer

        convolution2dLayer(1,512,'Padding','same')
        batchNormalizationLayer
        reluLayer

        maxPooling2dLayer(2,'Stride',2)

        fullyConnectedLayer(768)
        reluLayer

        dropoutLayer(0.35)

        fullyConnectedLayer(768)
        reluLayer
    
        fullyConnectedLayer(10)

        softmaxLayer
        classificationLayer
    ];
end

