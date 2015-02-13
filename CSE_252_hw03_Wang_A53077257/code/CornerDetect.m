function [cornery,cornerx] = CornerDetect( Image, nCorners, smoothSTD, windowSize)
%% load data
image = Image;
imgHeight = size(image, 1);imgWidth = size(image, 2);
halfWsize = floor(windowSize/2);

%% apply gaussian filter
GaussFil = fspecial('gaussian',[5 5],smoothSTD);
Ig_Filted = imfilter(image,GaussFil,'same');

%% compute the gradient everywhere.
[Ix,Iy] = gradient(Ig_Filted);
for i=1:(halfWsize+1)
    Ix(:,i)=0;
end
for i=(imgWidth-halfWsize):imgWidth
    Ix(:,i)=0;
end
for i=1:(halfWsize+1)
    Iy(i,:)=0;
end
for i=(imgHeight-halfWsize):imgHeight
    Iy(i,:)=0;
end

%% move window over image and construct C over the window.
lamda = zeros(imgWidth,imgHeight);
for x=1:imgWidth
    for y=1:imgHeight
        Ixsub = Window(Ix, x, y, halfWsize);
        Iysub = Window(Iy, x, y, halfWsize);
        Ixx=Ixsub.*Ixsub;
        Ixy=Ixsub.*Iysub;
        Iyy=Iysub.*Iysub;
        C=[sum(sum(Ixx)),sum(sum(Ixy));sum(sum(Ixy)),sum(sum(Iyy))];
        [V,D]=eig(C);
        lamda(x,y) = min(D(1,1),D(2,2));
    end
end

[cornery cornerx] = NMS2(lamda,nCorners);

end



