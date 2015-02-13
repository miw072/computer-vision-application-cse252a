function [points3D] = triangulate(corsSSD, P1,P2)
%% make matrix
%P1 = proj_dino01; P2 = proj_dino02;
length = size(corsSSD,1);
for i=1:length
    x1(i) = corsSSD(i,3);
    y1(i) = corsSSD(i,4);
    x2(i) = corsSSD(i,1);
    y2(i) = corsSSD(i,2);
    A1 = x1(i)*P1(3,:)-P1(1,:); A2 = y1(i)*P1(3,:)-P1(2,:); A3 = x2(i)*P2(3,:)-P2(1,:); A4 = y2(i)*P2(3,:)-P2(2,:);
    A = [A1;A2;A3;A4];
    [U,S,V] = svd(A);
    points3D(i,1)=V(1,4); points3D(i,2)=V(2,4); points3D(i,3)=V(3,4);  points3D(i,4)=V(4,4);
end

end