%% load data
clear;clc;
load('F:\252\matrix2');
%load('F:\252\warrior2');
%load('F:\252\dino2');
%I1 = rgb2gray(warrior01);
%I2 = rgb2gray(warrior02);
%I1 = rgb2gray(dino01);
%I2 = rgb2gray(dino02);
I1 = rgb2gray(matrix01);
I2 = rgb2gray(matrix02);
height1 = size(I1, 1);width1 = size(I1, 2);
height2 = size(I2, 1);width2 = size(I2, 2);
nCorners = 14;

%% calculate fundamental matrix
F = fund(cor1,cor2);
for i=1:nCorners
    line2(i,:,:) = F*[cor1(i,:),1]';
    line1(i,:,:) = F'*[cor2(i,:),1]';
end
for i=1:nCorners
    pts1(:,:,i) = linePts(line1(i,:,:), [1;width1], [1;height1]);
end
for i=1:nCorners
    pts2(:,:,i) = linePts(line2(i,:,:), [1;width2], [1;height2]);
end
%% output images
figure(1);
imshow(I1);
hold on;
 for i=1:nCorners
    r = 30;
    sita=0:pi/20:2*pi;
    plot(cor1(i,1)+r*cos(sita),cor1(i,2)+r*sin(sita),'LineWidth',2);
    line([pts1(1,1,i) pts1(2,1,i)],[pts1(1,2,i) pts1(2,2,i)],'LineWidth',2,'Color','b');
 end
 
 figure(2)
 imshow(I2);
 hold on;
for i=1:nCorners
    r = 30;
    sita=0:pi/20:2*pi;
    plot(cor2(i,1)+r*cos(sita),cor2(i,2)+r*sin(sita),'LineWidth',2);
    line([pts2(1,1,i) pts2(2,1,i)],[pts2(1,2,i) pts2(2,2,i)],'LineWidth',2,'Color','b');
end
       