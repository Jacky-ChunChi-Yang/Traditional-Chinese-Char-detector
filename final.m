

% Training part
cd ("/Users/yangchunchi/Documents/Traditional-Chinese-Char-detector/data/");
imgTrain = imageDatastore("train", "IncludeSubfolders",true, "LabelSource","foldernames");
train_data = load("/Users/yangchunchi/Documents/Traditional-Chinese-Char-detector/data/label6.mat");

trainingData = objectDetectorTrainingData(train_data.gTruth);
layers = "resnet18";
options = trainingOptions("adam", 'MaxEpochs', 30, 'MiniBatchSize', 1, ...
    'InitialLearnRate', 1e-4, 'Plots','training-progress');

detector = trainFastRCNNObjectDetector(trainingData, layers, options);






% Accuracy
% load("/Users/yangchunchi/Documents/Traditional-Chinese-Char-detector/result/detector6.mat");
test_data = load("/Users/yangchunchi/Documents/Traditional-Chinese-Char-detector/test_2/test_label5.mat");
testingData = objectDetectorTrainingData(test_data.gTruth);


error = 0;
count = 0;
overlapRatio_average = 0;
for i = 1:size(testingData,1)
    count = count + 1;
    img = imread(testingData.imageFilename{i});
    yaoBox_g = testingData.yao{i};
    cuBox_g = testingData.cu{i};
    biaoBox_g = testingData.biao{i};
    count_biao = 0;
    count_yao = 0;
    count_cu = 0;
    [Allboxes, scores, labels] = detect(detector, img);
    new_label = cell(size(labels));
    if ~isempty(Allboxes)
        for j = 1:size(labels)
            if(labels(j) == "biao")
                count_biao = count_biao + 1;
                labels(j) = "biao: ㄅㄧㄠ";
            end

            if(labels(j) == "yao")
                count_yao = count_yao + 1;
                labels(j) = "yao: 一ㄠˊ";
            end    

            if(labels(j) == "cu")
                count_cu = count_cu + 1;
                labels(j) = "cu: ㄘㄨ";
            end 
        end
        I = insertObjectAnnotation(img, 'rectangle', Allboxes, labels, FontSize=30, Font='Arial Unicode');
        % figure, imshow(I);
    end 


    temp_overlapRatio1 = bboxOverlapRatio(Allboxes, yaoBox_g);
    temp_overlapRatio1(temp_overlapRatio1==0)=[];
    temp_overlapRatio2 = bboxOverlapRatio(Allboxes, biaoBox_g);
    temp_overlapRatio2(temp_overlapRatio2==0)=[];
    temp_overlapRatio3 = bboxOverlapRatio(Allboxes, cuBox_g);
    temp_overlapRatio3(temp_overlapRatio3==0)=[];
    n=0;
    overlapRatio(i)=0;
    if(size(yaoBox_g, 1)>=1)
        overlapRatio(i) = overlapRatio(i) + mean(temp_overlapRatio1(:));
        n = n+1;
    end 
    if(size(biaoBox_g, 1)>=1)
        overlapRatio(i) = overlapRatio(i) + mean(temp_overlapRatio2(:));
        n = n+1;
    end 
    if(size(cuBox_g, 1)>=1)
        overlapRatio(i) = overlapRatio(i) + mean(temp_overlapRatio3(:));
        n = n+1;
    end
    overlapRatio(i) = overlapRatio(i)/n;
    overlapRatio_average = overlapRatio_average + overlapRatio(i);

   
    if(size(yaoBox_g, 1) ~= count_yao || size(cuBox_g, 1) ~= count_cu || size(biaoBox_g, 1) ~= count_biao || overlapRatio(i)<0.5 || isnan(overlapRatio(i)))
        error = error + 1;
        disp(num2str(i) + " " + testingData.imageFilename{i} + " : Error");
        if isempty(Allboxes)
            % show no rectangle image
            figure, imshow(img)
        else 
            % show error image
            figure, imshow(I);
        end

    else 
        % show correct image
        disp(num2str(i) + " " + testingData.imageFilename{i} + " : Correct");
        % figure, imshow(I);
    end 


    disp("  The IoU score: " + num2str(overlapRatio(i)) + ...
        " yao: (" + num2str(size(yaoBox_g, 1)) + ", " + num2str(count_yao) + ")" + ...
        " biao: (" + num2str(size(biaoBox_g, 1)) + ", " + num2str(count_biao) + ")" + ...
        " cu: (" + num2str(size(cuBox_g, 1)) + ", " + num2str(count_cu) +  ")");
    disp(" ");
    


    % if(i==1)
    %     break
    % end
end 


acc = (count-error)/count;
disp("The accuracy: " + num2str(acc) + "(" + num2str(count-error) + "/" + num2str(count) + ")");
overlapRatio_average = overlapRatio_average/count;
disp("Average OverlapRatio: " + num2str(overlapRatio_average));







% Delete the Block
name = "/Users/yangchunchi/Documents/Traditional-Chinese-Char-detector/test_2/test_Image/jacky_5.jpg";
img = imread(name);
[Allboxes, scores, labels] = detect(detector, img);

for i = 1:size(labels)
    labels(i) = string(labels(i)) + ": " + num2str(scores(i));
end 

for i = 1:size(labels)
    if(scores(i)<0.75)
        scores(i) = 0;
        labels(i) = '0';
        for j = 1:4
            Allboxes(i+(j-1)*4) = 0;
        end 
    end 

end 

if ~isempty(Allboxes)
    img = insertObjectAnnotation(img, 'rectangle', Allboxes, labels, FontSize=40);
end
figure, imshow(img);

