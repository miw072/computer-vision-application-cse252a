%% load data
clear;clc;
load('F:\252\matrix2');
load('F:\252\warrior2');
load('F:\252\dino2');
warrior01_gray = rgb2gray(warrior01);
warrior02_gray = rgb2gray(warrior02);
dino01_gray = rgb2gray(dino01);
dino02_gray = rgb2gray(dino02);
matrix01_gray = rgb2gray(matrix01);
matrix02_gray = rgb2gray(matrix02);

%% compute w/ two images
nCorners = 10;
windowSize = 11;
smoothSTD = 5;
SSDth = 5;
I1 = matrix01_gray;
I2 = matrix02_gray;
R = 5;
[corners1y corners1x] = CornerDetect(I1, nCorners, smoothSTD, windowSize);
[corners2y corners2x] = CornerDetect(I2, nCorners, smoothSTD, windowSize);
corners1 = [corners1x corners1y];
corners2 = [corners2x corners2y];
[I, corsSSD] = naiveCorrespondanceMatching(I1, I2, corners1, corners2, R, SSDth);
corners2yp = size(I1, 2) + corners2y;

%% output images

figure(1);
imshow(I);
hold on;
 for i=1:nCorners
    r = 30;
    sita=0:pi/20:2*pi;
    plot(corners1y(i)+r*cos(sita),corners1x(i)+r*sin(sita),'LineWidth',2);
    plot(corners2yp(i)+r*cos(sita),corners2x(i)+r*sin(sita),'LineWidth',2);
 end
 hold on;
for i=1:nCorners
    if (corsSSD(i)~=0)
        j = corsSSD(i);
        line([corners1y(i) corners2yp(j)],[corners1x(i) corners2x(j)],'LineWidth',2,'Color','r');
    end
end
        
        
        
 