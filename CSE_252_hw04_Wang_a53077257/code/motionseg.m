%% load image
clear;clc;
%I1=im2double(imread('F:\252\corridor\bt.000.png'));
%I2=im2double(imread('F:\252\corridor\bt.001.png'));
%I1=im2double(imread('F:\252\synth\synth_000.png'));
%I2=im2double(imread('F:\252\synth\synth_001.png'));
%I1=im2double(rgb2gray(imread('F:\252\sphere\sphere.0.png')));
%I2=im2double(rgb2gray(imread('F:\252\sphere\sphere.1.png'))); 
I1=im2double(rgb2gray(imread('F:\252\flower\00035.png')));
I2=im2double(rgb2gray(imread('F:\252\flower\00036.png')));
max1=max(max(I1)); max2=max(max(I2));
I1=I1/max1;I2=I2/max2;
% if mod(size(I1,1),2)~=0
%     I1=imresize(I1,[size(I1,1)+1,size(I1,2)]);
%     I2=imresize(I2,[size(I2,1)+1,size(I2,2)]);
% end
% if mod(size(I1,2),2)~=0
%     I1=imresize(I1,[size(I1,1),size(I1,2)+1]);
%     I2=imresize(I2,[size(I2,1),size(I2,2)+1]);
% end
windowSize=10;
tau=0.005;
NumPyramid = 5;
NumIteration = 10;
windowSize2 = 7;
smoothSTD = 1;
th=9;
%% make image pyramid
I1_pyramid{1}=I1;
I2_pyramid{1}=I2;

for i = 2:NumPyramid
    I1_pyramid{i} = impyramid( I1_pyramid{i-1}, 'reduce' );
    I2_pyramid{i} = impyramid( I2_pyramid{i-1}, 'reduce' );
end


%% pyramid LK optical flow

for k=NumPyramid:-1:1
    I1current=I1_pyramid{k};
    I2current=I2_pyramid{k};
    if k==NumPyramid
        u = zeros(size(I1_pyramid{k}));
        v = zeros(size(I1_pyramid{k}));
    end
    uin = zeros(size(I1_pyramid{k}));
    vin = zeros(size(I1_pyramid{k}));
     utmp = zeros(size(I1_pyramid{k}));
     vtmp = zeros(size(I1_pyramid{k}));
    % in-level iteration refinement
    I1warp=warp2(I1current,u,v);
     for j=1:NumIteration
         I1warp = warp2(I1current,utmp,vtmp);
    [uin vin hitMap] = opticalFlow(I1current,I2current,I1warp,windowSize, tau);
         uin = uin + utmp;
         vin = vin + vtmp;
     end
    u=u+uin;
    v=v+vin;
    if k~= 1   
        sizerow=size(u,1); sizecol=size(u,2);
        sizerow2=2*sizerow; sizecol2=2*sizecol;
        if sizerow2~=size(I1_pyramid{k-1},1)
            sizerow2=size(I1_pyramid{k-1},1);
        end
        if sizecol2~=size(I1_pyramid{k-1},2)
            sizecol2=size(I1_pyramid{k-1},2);
        end
        u = 2 * imresize(u,[sizerow2 sizecol2],'bilinear');
        v = 2 * imresize(v,[sizerow2 sizecol2],'bilinear');
    end
end
%% sparse optical flow

for i=1:size(I1,1)
    for j=1:size(I1,2)
        if sqrt(u(i,j)^2+v(i,j)^2)>th
            tree(i,j)=I1(i,j);
        else
            tree(i,j)=0;
        end
    end
end

figure(1);
imshow(tree);




