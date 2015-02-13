% function [background] = backgroundSubtract(framesequence, tau)
% end
clear;clc;
%file_path =  'F:\252\highway\';
file_path =  'F:\252\truck\';
img_path_list = dir(strcat(file_path,'*.png'));
img_num = length(img_path_list);
if img_num > 0 
        for i = 1:img_num 
            image_name = img_path_list(i).name;
            tmpimage =  im2double(imread(strcat(file_path,image_name)));
            image{i} = tmpimage;
        end
end

tau=0.4;
a=0.05;
height=size(image{1},1); width=size(image{1},2);
for i=1:img_num
    for m=1:height
        for n=1:width
            array{m}{n}(i)=image{i}(m,n);
        end
    end
end
B=zeros(height,width);
for m=1:height
    for n=1:width
        B(m,n)=median(array{m}{n});
    end
end

for i=1:img_num-1
    imgcu=image{i};
    imgne=image{i+1};
    for m=1:height
        for n=1:width
            if abs(imgcu(m,n)-imgne(m,n))>tau
                B(m,n)=(1-a)*B(m,n)+a*imgcu(m,n);
            else
                B(m,n)=B(m,n);
            end
        end
    end
end

figure(1);
imshow(B);