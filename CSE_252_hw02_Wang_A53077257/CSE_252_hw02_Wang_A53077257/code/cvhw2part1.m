clear;clc; 
load('F:\synthetic_data');
[h1,w1]=size(im1);[h2,w2]=size(im2);[h3,w3]=size(im3);[h4,w4]=size(im4);

for i=1:h1
    for j=1:w1
        A=-[l1;l2;l4];                          
        Aplus=(inv(A'*A))*A';
        e=double([im1(i,j);im2(i,j);im4(i,j)]); %can be changed
        b=Aplus*e;
        albedo(i,j)=sqrt(dot(b,b'));
        normv(i,j,:,:,:)=b/albedo(i,j);
        p(i,j)=normv(i,j,1)/normv(i,j,3);       %calculate p&q
        q(i,j)=normv(i,j,2)/normv(i,j,3);
      
        u(i,j)=normv(i,j,1);
        v(i,j)=normv(i,j,2);
        w(i,j)=normv(i,j,3);
       
       
    end
end

height=zeros(h1,w1);
%estimate height map                                            
height(1,1)=p(1,1);
for i=2:h1
    height(i,1)=height(i-1,1)+p(i,1);       % notice that the coordinate is not regular
end

for i=1:h1
    for j=2:w1
    height(i,j)=height(i,j-1)+q(i,j);
    end
end

xa=1:1:w1;ya=1:1:h1;
[x,y]=meshgrid(xa,ya);
z=-height;

%make quiver3 easier to be done
endd=100;
stride=3;
x1 = x(1:stride:endd,1:stride:endd);y1 = y(1:stride:endd,1:stride:endd);z1 = z(1:stride:endd,1:stride:endd);
u1 = u(1:stride:endd,1:stride:endd);v1 = v(1:stride:endd,1:stride:endd);w1 = w(1:stride:endd,1:stride:endd);

figure(1);
imshow(albedo,[]);
figure(2);
quiver3(x,y,z,u,v,w); 
figure(3);
surf(x,y,z);