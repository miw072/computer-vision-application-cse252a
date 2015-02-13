function [ inlier, outlier ] = findOutliers(points3D, P2, outlierTH, corsSSD);
length = size(corsSSD,1);
for i=1:length
    truepts2homo(i,:) = P2*points3D(i,:)';
    truepts2(i,1)=truepts2homo(i,1)/truepts2homo(i,3);
    truepts2(i,2)=truepts2homo(i,2)/truepts2homo(i,3);
end
a=1;b=1;
for i=1:length
    if (corsSSD(i,1)~=0)
        xo(i) = corsSSD(i,1);
        yo(i) = corsSSD(i,2);
        dist = (xo(i)-truepts2(i,1))^2+(yo(i)-truepts2(i,2))^2;
        if (dist>outlierTH^2)
           outlier(a,1)= truepts2(i,1);
           outlier(a,2)= truepts2(i,2);
           a=a+1;
        else
           inlier(b,1)=truepts2(i,1);
           inlier(b,2)=truepts2(i,2);
           b=b+1;
        end
    end
end

end

