function [ warped_img ] = warp( I1,points,H )
Hinv=inv(H);
%xx=points(:,2);
%yy=points(:,1);
%R=I1(:,:,1);G=I1(:,:,2);B=I1(:,:,3);
for COLOR=1:1:3
    for X_my=1:1:101
        for Y_my=1:1:201
                a=Hinv*[X_my;Y_my;1];
                xh=a(1,:);
                yh=a(2,:);
                zh=a(3,:);
                xih=floor(xh/zh);yih=floor(yh/zh);
                xih_f=floor(xih);yih_f=floor(yih);
                xih_c=ceil(xih);yih_c=ceil(yih);
                u=xih_c-xih;v=yih_c-yih;
                i1=u*v*I1(xih_f,yih_f,COLOR);
                i2=u*(1-v)*I1(xih_f,yih_c,COLOR);
                i3=v*(1-u)*I1(xih_c,yih_f,COLOR);
                i4=(1-v)*(1-u)*I1(xih_c,yih_c,COLOR);
                i=i1+i2+i3+i4;
                warped_img(X_my,Y_my,COLOR)=i;
            
        end
    end
end
              


end

