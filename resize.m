% inputPath =  "/Users/yangchunchi/Documents/Traditional-Chinese-Char-detector/resize/";
% outputPath = "/Users/yangchunchi/Documents/Traditional-Chinese-Char-detector/resize_new";
% 
% 
% if ~exist(outputPath)
%     mkdir(outputPath)
% end
% 
% files = dir(inputPath);
% for i = 3:length(files)
%     pic_name = files(i).name
%     pic = imread(inputPath+pic_name);
%    figure,  imshow(pic);
%     pic_resized = imresize(pic, [227,227]);
%     imwrite (pic_resized, [outputPath+'/'+pic_name]);
% 
% end


name3 = "/Users/yangchunchi/Documents/Traditional-Chinese-Char-detector/resize/old_train_17.jpg";
pic = imread(name3);
pic_resized = imresize(pic, [227,227]);
imwrite (pic_resized, ["/Users/yangchunchi/Documents/Traditional-Chinese-Char-detector/resize/old_train_17_2.jpg"]);