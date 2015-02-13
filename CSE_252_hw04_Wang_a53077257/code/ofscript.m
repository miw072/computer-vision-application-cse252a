%% load image
clear;clc;
%I1=im2double(imread('F:\252\corridor\bt.000.png'));
%I2=im2double(imread('F:\252\corridor\bt.001.png'));
%I1=im2double(imread('F:\252\synth\synth_000.png'));
%I2=im2double(imread('F:\252\synth\synth_001.png'));
% I1=im2double(rgb2gray(imread('F:\252\sphere\sphere.0.png')));
% I2=im2double(rgb2gray(imread('F:\252\sphere\sphere.1.png'))); 
%I1=im2double(rgb2gray(imread('F:\252\flower\00029.png')));
%I2=im2double(rgb2gray(imread('F:\252\flower\00036.png')));
I1=im2double(rgb2gray(imread('F:\252\1.jpg')));
I2=im2double(rgb2gray(imread('F:\252\2.jpg')));
I1 = imresize(I1,[256 256]);
I2 = imresize(I2,[256 256]);
% max1=max(max(I1)); max2=max(max(I2));
% I1=I1/max1;I2=I2/max2;
I1ori=I1;
height1 = size(I1, 1);width1 = size(I1, 2);
height2 = size(I2, 1);width2 = size(I2, 2);
windowSize=25;
tau=0.09;
NumIteration=4;
nCorners = 50;
windowSize2 = 7;
smoothSTD = 1;

%% corner detection
[corners1y corners1x] = CornerDetect(I1, nCorners, smoothSTD, windowSize2);
corners1 = [corners1x corners1y];

%% dense optical flow
u = zeros(size(I1));
v = zeros(size(I1));
uin = zeros(size(I1));
vin = zeros(size(I1));
for j=1:NumIteration
        I1warp = warp2(I1,uin,vin);
        [uin vin hitMap] = opticalFlow(I1,I2,I1warp,windowSize, tau);
        u = u + uin;
        v = v + vin;
end

%% sparse optical flow

for i=1:nCorners
    qu(i)=u(corners1x(i),corners1y(i));
    qv(i)=v(corners1x(i),corners1y(i));
end
%% show result

figure(1);
imshow(I1ori);
hold on;
axis on;
 for i=1:nCorners
    r = 5;
    sita=0:pi/20:2*pi;
    plot(corners1y(i)+r*cos(sita),corners1x(i)+r*sin(sita),'r','LineWidth',2);
 end
hold on;
quiver(corners1y,corners1x,qu',qv','LineWidth',3);
figure(2);
imshow(I1ori);
hold on;
axis on;
 for i=1:nCorners
    r = 5;
    sita=0:pi/20:2*pi;
    plot(corners1y(i)+r*cos(sita),corners1x(i)+r*sin(sita),'r','LineWidth',2);
 end
u=flipud(u); v=flipud(-v);
endd1=size(I1,1);
endd2=size(I1,2);
stride=6;
u1 = u(1:stride:endd1,1:stride:endd2);v1 = v(1:stride:endd1,1:stride:endd2);
figure(3);
quiver(u1, v1, 1.5, 'LineWidth',2); 
figure(4);
imshow(hitMap);


