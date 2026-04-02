

load("/Users/yangchunchi/Documents/Traditional-Chinese-Char-detector/result/detector6.mat");



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


