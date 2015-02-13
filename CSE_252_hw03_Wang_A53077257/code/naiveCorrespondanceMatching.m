function [ I, corsSSD ] = naiveCorrespondanceMatching( I1, I2, corners1, corners2, R, SSDth )
height1 = size(I1, 1);width1 = size(I1, 2);
height2 = size(I2, 1);width2 = size(I2, 2);
height = max(height1,height2);
width = width1 + width2;
I = zeros(height, width);
I(1:height1,1:width1)=I1;
I(1:height2,width1+1:width)=I2;
corners1x = corners1(:,1);
corners1y = corners1(:,2);
corners2x = corners2(:,1);
corners2y = corners2(:,2);

for i=1:length(corners1x)
    matchimg1 = Window(I1,corners1y(i),corners1x(i),R);
    for j=1:length(corners2x)
        matchimg2 = Window(I2,corners2y(j),corners2x(j),R);
        tmdSSD(1,j) = SSDmatch( matchimg1,matchimg2 );
    end
    minSSD = min(tmdSSD(tmdSSD>0));
    if (minSSD>SSDth)
        corsSSD(i,1) = 0;
    else
    corsSSD(i,1) = find(tmdSSD==minSSD);
    end
end
end

