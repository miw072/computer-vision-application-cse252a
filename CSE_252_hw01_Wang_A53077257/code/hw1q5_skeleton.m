I1 = imread('F:/stadium.jpg');
% get points from the image
figure(10)
imshow(I1)
% select points on the image, preferably the corners of an ad.
points = ginput(4);
figure(1)
subplot(1,2,1);
imshow(I1);
new_points = [1 1;1 201;101 201;101 1]; % choose your own set of points to warp your ad too
H = computeH(points, new_points);
% warp will return just the ad rectified. This will require cropping the ad out of the
% stadium image.
warped_img = warp(I1, points, H);
subplot(1,2,2);
imshow(warped_img);