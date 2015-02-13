function [ I ] = Window( Img, centerX,centerY,WSize )

ImgX=size(Img,2);
ImgY=size(Img,1);

xs=round(centerX-WSize);
if xs<1
    xs=1;
end
xe=round(centerX+WSize);
if xe>ImgX
    xe=ImgX;
end

ys=round(centerY-WSize);
if ys<1
    ys=1;
end
ye=round(centerY+WSize);
if ye>ImgY
    ye=ImgY;
end

I=Img(ys:ye, xs:xe);
end