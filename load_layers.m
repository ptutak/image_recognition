function [layers] = load_layers()
    layers = [
        imageInputLayer([256 256 3])

        convolution2dLayer(3,64,'Padding','same')
        batchNormalizationLayer
        reluLayer
        
        dropoutLayer(0.3)

%        convolution2dLayer(3,64,'Padding','same')
%        batchNormalizationLayer
%        reluLayer

        maxPooling2dLayer(2,'Stride',2)

 %       convolution2dLayer(3,128,'Padding','same')
 %       batchNormalizationLayer
 %       reluLayer
        
        convolution2dLayer(3,128,'Padding','same')
        batchNormalizationLayer
        reluLayer

        maxPooling2dLayer(2,'Stride',2)

  %      convolution2dLayer(3,256,'Padding','same')
  %      batchNormalizationLayer
  %      reluLayer
        
        convolution2dLayer(3,256,'Padding','same')
        batchNormalizationLayer
        reluLayer

        dropoutLayer(0.3)
        
        convolution2dLayer(3,256,'Padding','same')
        batchNormalizationLayer
        reluLayer

        maxPooling2dLayer(2,'Stride',2)

   %     convolution2dLayer(3,512,'Padding','same')
   %     batchNormalizationLayer
   %     reluLayer

        convolution2dLayer(3,512,'Padding','same')
        batchNormalizationLayer
        reluLayer

        dropoutLayer(0.3)

        convolution2dLayer(3,512,'Padding','same')
        batchNormalizationLayer
        reluLayer

        maxPooling2dLayer(2,'Stride',2)

    %    convolution2dLayer(3,512,'Padding','same')
    %    batchNormalizationLayer
    %    reluLayer

        convolution2dLayer(3,512,'Padding','same')
        batchNormalizationLayer
        reluLayer

        dropoutLayer(0.3)

        convolution2dLayer(3,512,'Padding','same')
        batchNormalizationLayer
        reluLayer

        maxPooling2dLayer(2,'Stride',2)

        fullyConnectedLayer(4096)
        reluLayer

        dropoutLayer(0.3)

        fullyConnectedLayer(4096)
        reluLayer
        fullyConnectedLayer(10)

        softmaxLayer
        classificationLayer
    ];
end

