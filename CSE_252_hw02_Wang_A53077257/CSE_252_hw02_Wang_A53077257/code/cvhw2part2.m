clear;clc; 
load('F:\specular-pear');
img1=rgb2gray(im1);img2=rgb2gray(im2);img3=rgb2gray(im3);img4=rgb2gray(im4);
[h1,w1]=size(img1);[h2,w2]=size(img2);[h3,w3]=size(img3);[h4,w4]=size(img4);
a=1

%calculate R
b=[1 0 0]';
b1=1;b2=0;b3=0;
cz=dot(c,c');
ct=c/cz;
a1=ct(1,:);a2=ct(2,:);a3=ct(3,:);
axis1=a2*b3-a3*b2;
axis2=a3*b1-a1*b3;
axis3=a1*b2-a2*b1;
theta=subspace(b,c);
o1=axis1/sqrt(axis1^2+axis2^2+axis3^2);
o2=axis2/sqrt(axis1^2+axis2^2+axis3^2);
o3=axis3/sqrt(axis1^2+axis2^2+axis3^2);
R1=[cos(theta)+o1^2*(1-cos(theta)) o1*o2*(1-cos(theta))-o3*sin(theta) o2*sin(theta)+o1*o3*(1-cos(theta))];
R2=[o3*sin(theta)+o1*o2*(1-cos(theta)) cos(theta)+o2^2*(1-cos(theta)) -o1*sin(theta)+o2*o3*(1-cos(theta))];
R3=[-o2*sin(theta)+o1*o3*(1-cos(theta)) o1*sin(theta)+o2*o3*(1-cos(theta)) cos(theta)+o3^2*(1-cos(theta))];
R=[R1;R2;R3];

%transfer into SUV 
for i=1:h1
    for j=1:w1
        s1(i,j)=R1*[im1(i,j,1);im1(i,j,2);im1(i,j,3)];
        u1(i,j)=R2*[im1(i,j,1);im1(i,j,2);im1(i,j,3)];
        v1(i,j)=R3*[im1(i,j,1);im1(i,j,2);im1(i,j,3)];
        G1(i,j)=sqrt(u1(i,j)^2+v1(i,j)^2);
    end
end

for i=1:h1
    for j=1:w1
        s2(i,j)=R1*[im2(i,j,1);im2(i,j,2);im2(i,j,3)];
        u2(i,j)=R2*[im2(i,j,1);im2(i,j,2);im2(i,j,3)];
        v2(i,j)=R3*[im2(i,j,1);im2(i,j,2);im2(i,j,3)];
        G2(i,j)=sqrt(u2(i,j)^2+v2(i,j)^2);
    end
end
for i=1:h1
    for j=1:w1
        s3(i,j)=R1*[im3(i,j,1);im3(i,j,2);im3(i,j,3)];
        u3(i,j)=R2*[im3(i,j,1);im3(i,j,2);im3(i,j,3)];
        v3(i,j)=R3*[im3(i,j,1);im3(i,j,2);im3(i,j,3)];
        G3(i,j)=sqrt(u3(i,j)^2+v3(i,j)^2);
    end
end
for i=1:h1
    for j=1:w1
        s4(i,j)=R1*[im4(i,j,1);im4(i,j,2);im4(i,j,3)];
        u4(i,j)=R2*[im4(i,j,1);im4(i,j,2);im4(i,j,3)];
        v4(i,j)=R3*[im4(i,j,1);im4(i,j,2);im4(i,j,3)];
        G4(i,j)=sqrt(u4(i,j)^2+v4(i,j)^2);
    end
end

figure(1)
subplot(1,3,1);
imshow(im1/max(im1(:)));
subplot(1,3,2);
imshow(s1,[]);
subplot(1,3,3);
imshow(G1,[]);


