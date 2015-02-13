clear;clc;
toy_img = im2double(imread('F:\252\example.png'));
filter_img = im2double(imread('F:\252\filter.jpg'));
[ltoy,wtoy] = size(toy_img);[lfil,wfil] = size(filter_img);

filter_img_star = filter_img - mean(filter_img(:));
toy_img_star = toy_img - mean(toy_img(:));
C = conv2(toy_img_star, filter_img_star, 'same');

colormap('default');
figure(1);
imagesc(C);

max1=max(C);
max2=max(max1);
[row, col] = find(C==max2);
x1=col(1)-(wfil-1)/2; y1=row(1)-(lfil-1)/2;
x2=col(2)-(wfil-1)/2; y2=row(2)-(lfil-1)/2;
x3=col(3)-(wfil-1)/2; y3=row(3)-(lfil-1)/2;

x1min=x1;x1max=x1+wfil-1;y1min=y1;y1max=y1+lfil-1;
x2min=120;x2max=165;y2min=170;y2max=195;

figure(2);
imshow(toy_img);
axis on;
hold on;
rectangle('Position',[x1,y1,wfil,lfil],'edgecolor','b');
rectangle('Position',[x2,y2,wfil,lfil],'edgecolor','b');
rectangle('Position',[x3,y3,wfil,lfil],'edgecolor','b');
rectangle('Position',[x2min,y2min,x2max-x2min+1,y2max-y2min+1],'edgecolor','r');

overlaprate = OverlapFunc(x1min,y1min,x1max,y1max,x2min,y2min,x2max,y2max);

