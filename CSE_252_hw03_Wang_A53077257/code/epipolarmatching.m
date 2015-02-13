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


%% find 10 corners for each picture
nCorners = 10;
windowSize = 11;
smoothSTD = 0.5;
SSDth = 2.5;
R = 5;
[corners1y corners1x] = CornerDetect(I1, nCorners, smoothSTD, windowSize);
corners1 = [corners1x corners1y];

%% calculate fundamental matrix 
F = fund(cor1,cor2);

% search along the epipolar line in I2


[I,corsSSD] = correspondanceMatchingLine( I1, I2, corners1, F, R, SSDth);



%% output images

figure(1);
imshow(I);
hold on;
axis on;
 for i=1:nCorners
    r = 20;
    sita=0:pi/20:2*pi;
    plot(corners1y(i)+r*cos(sita),corners1x(i)+r*sin(sita),'LineWidth',2);
 end
 hold on;
for i=1:nCorners
    if (corsSSD(i,1)~=0)
        xm = corsSSD(i,1);
        ym = corsSSD(i,2);
        plot(xm+size(I1, 2)+r*cos(sita),ym+r*sin(sita),'LineWidth',2);
        line([corners1y(i) xm+size(I1, 2)],[corners1x(i) ym],'LineWidth',2,'Color','r');
    end
end
% figure(2)
% imshow(I2);
% hold on;
% axis on;
% for i=1:nCorners
%     line([pts2(1,1,i) pts2(2,1,i)],[pts2(1,2,i) pts2(2,2,i)],'LineWidth',1,'Color','b');
% end
