function [H] = computeH(points,new_points)
temp=points(:,1);
points(:,1)=points(:,2);
points(:,2)=temp;
x1=[points(1,:),1]';
x2=[points(2,:),1]';
x3=[points(3,:),1]';
x4=[points(4,:),1]';
x=[x1,x2,x3];
l=inv(x)*x4;
l1=l(1,:);l2=l(2,:);l3=l(3,:);
H1inv=[l1*x1,l2*x2,l3*x3];
H1=inv(H1inv);

x1p=[new_points(1,:),1]';
x2p=[new_points(2,:),1]';
x3p=[new_points(3,:),1]';
x4p=[new_points(4,:),1]';
xp=[x1p,x2p,x3p];
lp=inv(xp)*x4p;
l1p=lp(1,:);l2p=lp(2,:);l3p=lp(3,:);
H2inv=[l1p*x1p,l2p*x2p,l3p*x3p];

H=H2inv*H1;


end
