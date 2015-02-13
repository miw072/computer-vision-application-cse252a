clear;
borc=imread('F:/border2.jpeg');  %Input can be changed.
cenc=imread('F:/center2.png');  %Input can be changed.

cen1=cenc(:,:,1);
cen2=cenc(:,:,2);
cen3=cenc(:,:,3);
bor1=borc(:,:,1);
bor2=borc(:,:,2);
bor3=borc(:,:,3);

borg=rgb2gray(borc);  %transform the rgb image to gray.
borg=double(borg);    %transform the unit8 image to double.
ceng=rgb2gray(cenc);
ceng=double(ceng);
[height1,width1]=size(borg);  %get the size of the image
[height2,width2]=size(ceng);

fil=ones(height2,width2);        %filter
F=filter2(fil,borg,'valid');

mini1=min(F);
mini2=min(mini1);

[col,row]=find(F==mini2);  
y1=col(1,1);
y2=y1+height2;
x1=row(1,1);
x2=x1+width2;

diff=-1;               %error correction
up=zeros(y1+diff,width1);
down=zeros(height1-y2-diff,width1);
left=zeros(height2,x1+diff);
right=zeros(height2,width1-x2-diff);

temp01=[left,cen1];    %joint matrixes
temp11=[temp01,right];
temp21=[up;temp11];
temp31=[temp21;down];
temp02=[left,cen2];
temp12=[temp02,right];
temp22=[up;temp12];
temp32=[temp22;down];
temp03=[left,cen3];
temp13=[temp03,right];
temp23=[up;temp13];
temp33=[temp23;down];

result1=temp31+bor1;
result2=temp32+bor2;
result3=temp33+bor3;

result(:,:,1)=result1;  %transform to rgb image
result(:,:,2)=result2;
result(:,:,3)=result3;

figure;imshow(result);  %show the image


