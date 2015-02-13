clear;clc;
%% preprocessing--car1
a=175;b=145;c=522; d=245;
car_img = im2double(imread('F:\252\car1.jpg'));
filter_img_ori = im2double(imread('F:\252\cartemplate.jpg'));
filter_img = imresize(filter_img_ori,[d-b+30 c-a+30]);
filter_img_star1 = imresize(imcrop(filter_img,[25,55,c-a-10,d-b-40]),[100 350]);
[ltoy,wtoy] = size(car_img);[lfil,wfil] = size(filter_img_star1);
filter_img_star1 = filter_img_star1 - mean(filter_img_star1(:));
car_img_star1 = car_img - mean(car_img(:));
%median filter
filter_img_star1 = medfilt2(filter_img_star1,[5,5]);
car_img_star1 = medfilt2(car_img_star1,[3,3]);
filter_img_star1 = flipud(filter_img_star1);

%% preprocessing--car2
a=69;b=205;c=488; d=357;
car_img = im2double(imread('F:\252\car2.jpg'));
filter_img_ori = im2double(imread('F:\252\cartemplate.jpg'));
%rescale the image
filter_img = imresize(filter_img_ori,[d-b+30 c-a+30]);
filter_img_star1 = imresize(imcrop(filter_img,[25,55,c-a-10,d-b-40]),[150 420]);
[ltoy,wtoy] = size(car_img);[lfil,wfil] = size(filter_img_star1);
%transfer to bw
filter_img_star1 = double(im2bw(filter_img_star1,0.8));
car_img_star1 = double(im2bw(car_img,0.05));
%substract mean
filter_img_star1 = filter_img_star1 - mean(filter_img_star1(:));
car_img_star1 = car_img - mean(car_img(:));
%flip
filter_img_star1 = flipud(filter_img_star1);

%% preprocessing--car3
a=329;b=251;c=480; d=345;
car_img = im2double(imread('F:\252\car3.jpg'));
filter_img_ori = im2double(imread('F:\252\cartemplate.jpg'));
filter_img = imresize(filter_img_ori,[d-b+30 c-a+30]);
filter_img_star1 = imresize(imcrop(filter_img,[10,40,c-a+15,d-b-20]),[100 150]);
[ltoy,wtoy] = size(car_img);[lfil,wfil] = size(filter_img_star1);
filter_img_star1 = filter_img_star1 - mean(filter_img_star1(:));
car_img_star1 = car_img - mean(car_img(:));
% gaussian filter
GaussFil = fspecial('gaussian',[5 5],0.6);
filter_img_star1 = imfilter(filter_img_star1,GaussFil,'same');
car_img_star1 = imfilter(car_img_star1,GaussFil,'same');
% inverse color
filter_img_star1 = 0.45-filter_img_star1;
filter_img_star1 = flipud(filter_img_star1);

%% preprocessing--car4
a=173;b=163;c=463; d=261;
car_img = im2double(imread('F:\252\car4.jpg'));
filter_img_ori = im2double(imread('F:\252\cartemplate.jpg'));
filter_img = imresize(filter_img_ori,[d-b+30 c-a+30]);
filter_img_star1 = imresize(imcrop(filter_img,[20,40,c-a-15,d-b-20]),[100 300]);
[ltoy,wtoy] = size(car_img);[lfil,wfil] = size(filter_img_star1);
filter_img_star1 = filter_img_star1 - mean(filter_img_star1(:));
car_img_star1 = car_img - mean(car_img(:));
filter_img_star1 = double(im2bw(filter_img_star1,0.1));
car_img_star1 = double(im2bw(car_img_star1,0.4));
filter_img_star1 = flipud(filter_img_star1);
filter_img_star1 = fliplr(filter_img_star1);

%% preprocessing--car5
a=393;b=313;c=800; d=497;
car_img = im2double(imread('F:\252\car5.jpg'));
filter_img_ori = im2double(imread('F:\252\cartemplate.jpg'));
filter_img = imresize(filter_img_ori,[d-b+30 c-a+30]);
filter_img_star1 = imresize(imcrop(filter_img,[25,65,c-a-15,d-b-50]),[160 360]);
[ltoy,wtoy] = size(car_img);[lfil,wfil] = size(filter_img_star1);
filter_img_star1 = filter_img_star1 - mean(filter_img_star1(:));
car_img_star1 = car_img - mean(car_img(:));
filter_img_star1 = flipud(filter_img_star1);
filter_img_star1 = fliplr(filter_img_star1);

%% convolution
C = conv2(car_img_star1, filter_img_star1, 'same');
colormap('default');
figure(1);
imagesc(C);

%% find max and output the box
max1=max(C);
max2=max(max1);
[row, col] = find(C==max2);
x1=col(1)-(wfil-1)/2; y1=row(1)-(lfil-1)/2;
x1min=x1;x1max=x1+wfil-1;y1min=y1;y1max=y1+lfil-1;
x2min=a;x2max=c;y2min=b;y2max=d;

figure(2);
imshow(car_img);
axis on;
hold on;
rectangle('Position',[x1,y1,wfil,lfil],'edgecolor','b');
rectangle('Position',[x2min,y2min,x2max-x2min+1,y2max-y2min+1],'edgecolor','r');

%% calculate overlap rate 
overlaprate = OverlapFunc(x1min,y1min,x1max,y1max,x2min,y2min,x2max,y2max);


