

cd ("/Users/yangchunchi/Documents/Traditional-Chinese-Char-detector/data/");
imgTrain = imageDatastore("train", "IncludeSubfolders",true, "LabelSource","foldernames");
train_data = load("/Users/yangchunchi/Documents/Traditional-Chinese-Char-detector/data/label6.mat");

trainingData = objectDetectorTrainingData(train_data.gTruth);
layers = "resnet18";
options = trainingOptions("adam", 'MaxEpochs', 30, 'MiniBatchSize', 1, ...
    'InitialLearnRate', 1e-4, 'Plots','training-progress');

detector = trainFastRCNNObjectDetector(trainingData, layers, options);