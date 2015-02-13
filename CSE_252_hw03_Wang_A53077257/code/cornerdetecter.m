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


%% find 10 corners for the image
nCorners = 20;
windowSize = 11;
smoothSTD = 0.5;
[corners1y corners1x] = CornerDetect(I1, nCorners, smoothSTD, windowSize);
corners1 = [corners1x corners1y];
[corners2y corners2x] = CornerDetect(I2, nCorners, smoothSTD, windowSize);
corners2 = [corners2x corners2y];

figure(1);
imshow(I1);
hold on;
axis on;
 for i=1:nCorners
    r = 30;
    sita=0:pi/20:2*pi;
    plot(corners1y(i)+r*cos(sita),corners1x(i)+r*sin(sita),'LineWidth',2);
 end
figure(2);
imshow(I2);
hold on;
axis on;
 for i=1:nCorners
    r = 30;
    sita=0:pi/20:2*pi;
    plot(corners2y(i)+r*cos(sita),corners2x(i)+r*sin(sita),'LineWidth',2);
 end
