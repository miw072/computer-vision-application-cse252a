function [ I,corsSSD ] = correspondanceMatchingLine(I1, I2, corners1, F, R, SSDth )

height1 = size(I1, 1);width1 = size(I1, 2);
height2 = size(I2, 1);width2 = size(I2, 2);
nCorners = 50;
height = max(height1,height2);
width = width1 + width2;
I = zeros(height, width);
I(1:height1,1:width1)=I1;
I(1:height2,width1+1:width)=I2;
corners1x = corners1(:,1);
corners1y = corners1(:,2);
line2 = epipolarLine(F,[corners1y corners1x]);
line2_u1(1:nCorners,1) = line2(:,1)./line2(:,3); line2_u2(1:nCorners,1) = line2(:,2)./line2(:,3);line2_u3(1:nCorners,1) = 1;
line2_homo = [line2_u1 line2_u2 line2_u3];
for i=1:nCorners
    pts2(:,:,i) = linePts(line2_homo(i,:,:), [1;width2], [1;height2]);
end
yest = zeros(width2,nCorners);
tmdSSD = zeros(width2,nCorners);
minSSD = zeros(nCorners);
corsSSD = zeros(nCorners,4);
for i=1:nCorners
    matchimg1 = Window(I1,corners1y(i),corners1x(i),R);
    for j=1:width2
        slope = (pts2(1,2,i)-pts2(2,2,i))/(pts2(1,1,i)-pts2(2,1,i));
        if (round(pts2(1,2,i)-slope*(pts2(1,1,i)-j))<height2 && round(pts2(1,2,i)-slope*(pts2(1,1,i)-j))>0)
            yest(j,i) = round(pts2(1,2,i)-slope*(pts2(1,1,i)-j));
        elseif(round(pts2(1,2,i)-slope*(pts2(1,1,i)-j))>=height2)
            yest(j,i) = height2;
        elseif(round(pts2(1,2,i)-slope*(pts2(1,1,i)-j))<=0)
            yest(j,i) = 0;   
        end
        matchimg2 = Window(I2,j,yest(j,i),R);
        tmdSSD(j,i) = SSDmatch( matchimg1,matchimg2 );
    end
        a=tmdSSD(:,i);
        minSSD(i) = min(a(a>0));
    if (minSSD(i)>SSDth)
        corsSSD(i,1) = 0;
        corsSSD(i,2) = 0;
    else
        corsSSD(i,1) = find(a==minSSD(i));
        corsSSD(i,2) = yest(corsSSD(i,1),i);
    end
    corsSSD(i,3) = corners1y(i);
    corsSSD(i,4) = corners1x(i);
end
end

