clear;clc; 
load('F:\specular-pear');
img1=rgb2gray(im1);img2=rgb2gray(im2);img3=rgb2gray(im3);img4=rgb2gray(im4);
[h1,w1]=size(img1);[h2,w2]=size(img2);[h3,w3]=size(img3);[h4,w4]=size(img4);


b=[1 0 0]';
b1=1;b2=0;b3=0;
a1=c(1,:);a2=c(2,:);a3=c(3,:);
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

for i=1:h1
    for j=1:w1
        s(i,j)=R1*[im1(i,j,1);im1(i,j,2);im1(i,j,3)];
        u(i,j)=R2*[im1(i,j,1);im1(i,j,2);im1(i,j,3)];
        v(i,j)=R3*[im1(i,j,1);im1(i,j,2);im1(i,j,3)];
        G1(i,j)=sqrt(u(i,j)^2+v(i,j)^2);
    end
end

for i=1:h1
    for j=1:w1
        s(i,j)=R1*[im2(i,j,1);im2(i,j,2);im2(i,j,3)];
        u(i,j)=R2*[im2(i,j,1);im2(i,j,2);im2(i,j,3)];
        v(i,j)=R3*[im2(i,j,1);im2(i,j,2);im2(i,j,3)];
        G2(i,j)=sqrt(u(i,j)^2+v(i,j)^2);
    end
end
for i=1:h1
    for j=1:w1
        s(i,j)=R1*[im3(i,j,1);im3(i,j,2);im3(i,j,3)];
        u(i,j)=R2*[im3(i,j,1);im3(i,j,2);im3(i,j,3)];
        v(i,j)=R3*[im3(i,j,1);im3(i,j,2);im3(i,j,3)];
        G3(i,j)=sqrt(u(i,j)^2+v(i,j)^2);
    end
end
for i=1:h1
    for j=1:w1
        s(i,j)=R1*[im4(i,j,1);im4(i,j,2);im4(i,j,3)];
        u(i,j)=R2*[im4(i,j,1);im4(i,j,2);im4(i,j,3)];
        v(i,j)=R3*[im4(i,j,1);im4(i,j,2);im4(i,j,3)];
        G4(i,j)=sqrt(u(i,j)^2+v(i,j)^2);
    end
end

for i=1:h1
    for j=1:w1
        A=-[l1;l2;l3;l4];
        Aplus=(inv(A'*A))*A';
        e=[G1(i,j);G2(i,j);G3(i,j);G4(i,j)];
        b=Aplus*e;
        albedo(i,j)=sqrt(dot(b,b'));
        normv(i,j,:,:,:)=b/albedo(i,j);
        p(i,j)=normv(i,j,1)/normv(i,j,3);
        q(i,j)=normv(i,j,2)/normv(i,j,3);
        
        u(i,j)=normv(i,j,1);
        v(i,j)=normv(i,j,2);
        w(i,j)=normv(i,j,3);
    end
end

%set marginal norm to straight up 
for i=1:h1
   normv(i,1,:,:,:)=[0;0;0.0001];
end

for i=1:w1
   normv(1,i,:,:,:)=[0;0;0.0001];
end

for i=1:h1
    for j=1:w1
        p(i,j)=normv(i,j,1)/normv(i,j,3);
        q(i,j)=normv(i,j,2)/normv(i,j,3);  
        u(i,j)=normv(i,j,1);
        v(i,j)=normv(i,j,2);
        w(i,j)=normv(i,j,3);
    end
end
    
    
height=zeros(h1,w1);


height(1,1)=q(1,1);
for i=2:h1
    height(i,1)=height(i-1,1)+q(i,1);       % notice that the coordinate is not regular
end

for i=1:h1
    for j=2:w1
    height(i,j)=height(i,j-1)+p(i,j);
    end
end

xa=1:1:w1;ya=1:1:h1;
[x,y]=meshgrid(xa,ya);
z=height;

enddx=h2;
enddy=w2;
stride=5;
x1 = x(1:stride:enddx,1:stride:enddy);y1 = y(1:stride:enddx,1:stride:enddy);z1 = z(1:stride:enddx,1:stride:enddy);
u1 = u(1:stride:enddx,1:stride:enddy);v1 = v(1:stride:enddx,1:stride:enddy);w11 = w(1:stride:enddx,1:stride:enddy);

figure(1);
subplot(2,2,1);
imshow(G1,[]);
subplot(2,2,2);
imshow(G2,[]);
subplot(2,2,3);
imshow(G3,[]);
subplot(2,2,4);
imshow(G4,[]);

figure(2);
imagesc(albedo);
figure(3);
quiver3(x1,y1,z1,u1,v1,w11);
figure(4);
surf(x,y,z);