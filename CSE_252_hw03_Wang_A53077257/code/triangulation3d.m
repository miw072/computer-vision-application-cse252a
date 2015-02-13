%% load data
clear;clc;
%load('F:\252\matrix2');
%load('F:\252\warrior2');
load('F:\252\dino2');
%I1 = rgb2gray(warrior01);
%I2 = rgb2gray(warrior02);
I1 = rgb2gray(dino01);
I2 = rgb2gray(dino02);
%I1 = rgb2gray(matrix01);
%I2 = rgb2gray(matrix02);
P1 = proj_dino01; P2 = proj_dino02;
%P1 = proj_warrior01; P2 = proj_warrior02;
%P1 = proj_matrix01; P2 = proj_matrix02;
height1 = size(I1, 1);width1 = size(I1, 2);
height2 = size(I2, 1);width2 = size(I2, 2);


%% find 50 corners for each picture
nCorners = 50;
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


%% triangulation and find outliers
outlierTH = 20;
points3D = triangulate(corsSSD, P1, P2);
[ inlier, outlier ] = findOutliers(points3D, P2, outlierTH, corsSSD);

%% output images

figure(1);
imshow(I2);
hold on;
axis on;
 for i=1:nCorners
     r = 20;
     sita=0:pi/20:2*pi;
    if (corsSSD(i,1)~=0)
        xm = corsSSD(i,1);
        ym = corsSSD(i,2);
        plot(xm+r*cos(sita),ym+r*sin(sita),'k','LineWidth',2);
    end
end
 hold on;
for i=1:size(inlier,1)
     plot(inlier(i,1),inlier(i,2),'b+','LineWidth',2);  
end
for i=1:size(outlier,1)
     plot(outlier(i,1),outlier(i,2),'r+','LineWidth',2);  
end
