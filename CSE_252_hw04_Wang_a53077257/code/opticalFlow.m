function [u, v, hitMap] = opticalFlow(I1,I2,I1warp,windowSize, tau)
%% apply gaussian filter
smoothSTD = 1;
GaussFil = fspecial('gaussian',[3 3],smoothSTD);
I1 = imfilter(I1,GaussFil,'same');
I2 = imfilter(I2,GaussFil,'same');
I1warp = imfilter(I1warp,GaussFil,'same');
%% kernel derivative
kernel = 1/12*[-1,8,0,-8,1];
Dx_1 = conv2(I1,kernel, 'same');
Dx_2 = conv2(I2,kernel, 'same');
Dy_1 = conv2(I1,kernel','same');
Dy_2 = conv2(I2,kernel','same');
Ix = (Dx_1 + Dx_2) / 2;
Iy = (Dy_1 + Dy_2) / 2;
It = I2 - I1warp;
 
%% dense optical flow
tauhit=tau;
Ix=padarray(Ix,[floor(windowSize/2),floor(windowSize/2)],'symmetric','both');
Iy=padarray(Iy,[floor(windowSize/2),floor(windowSize/2)],'symmetric','both');
It=padarray(It,[floor(windowSize/2),floor(windowSize/2)],'symmetric','both');
height = size(Ix, 1);width = size(Ix, 2);
for i=(1+floor(windowSize/2)):(height-floor(windowSize/2))
    for j=(1+floor(windowSize/2)):(width-floor(windowSize/2))
        A=zeros(2,2);B=zeros(2,1);
        for m=i-floor(windowSize/2):i+floor(windowSize/2)
            for n=j-floor(windowSize/2):j+floor(windowSize/2)               
                B(1,1)=B(1,1) + It(m,n)*Ix(m,n);
                B(2,1)=B(2,1) + It(m,n)*Iy(m,n);
                A(1,1)=A(1,1) + Ix(m,n)*Ix(m,n);
                A(1,2)=A(1,2) + Ix(m,n)*Iy(m,n);
                A(2,1)=A(2,1) + Ix(m,n)*Iy(m,n);
                A(2,2)=A(2,2) + Iy(m,n)*Iy(m,n);                 
            end
        end
        Ahit=A;
        [V,D]=eig(A);
        [Vhit,Dhit]=eig(Ahit);
        lamda = min(D(1,1),D(2,2));
        lamdahit = min(Dhit(1,1),Dhit(2,2));
        if lamda < tau
             u(i-floor(windowSize/2),j-floor(windowSize/2))=0;
             v(i-floor(windowSize/2),j-floor(windowSize/2))=0;
        else
        Ainv=inv(A);
        result=Ainv*(-B);
        u(i-floor(windowSize/2),j-floor(windowSize/2))=result(1,1);
        v(i-floor(windowSize/2),j-floor(windowSize/2))=result(2,1);
        end
        if lamdahit<tauhit
            b(i-floor(windowSize/2),j-floor(windowSize/2))=0;
        else
            b(i-floor(windowSize/2),j-floor(windowSize/2))=1;
        end   
     end
end
hitMap=b;
end

