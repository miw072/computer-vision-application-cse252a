function [ SSD ] = SSDmatch( I1,I2 )
if(size(I1,1)~=size(I2,1) || size(I1,2)~=size(I2,2))
    I2=zeros(size(I2,1),size(I2,2));
end
height = min(size(I1, 1),size(I2, 1));width = min(size(I1, 2),size(I2, 2));
SSD=0;
%m=size(I1,1);
%n=size(I2,2);
for i = 1:height
    for j= 1:width
        %if pdist([ceil(m/2),ceil(n/2);i,j])<=ceil(m/2)
        diff = I1(i,j)-I2(i,j);
        square = diff^2;
        SSD = SSD + square;
        end
    end
end
%end

