clear;
Rz=[cosd(20) -sind(20) 0;sind(20) cosd(20) 0;0 0 1];
Ry=[cosd(40) 0 sind(40);0 1 0;-sind(40) 0 cosd(40)];  %degree can be altered
R=Ry*Rz;
O=[0;0;1];                                           %O can be altered
bottom=[0 0 0 1];
Pe=[R O;bottom];
f=1;                                                  %f can be altered
Pipp=[f 0 0 0;0 f 0 0;0 0 1 0];
con=1;                                                %condition can be altered

taylorw1=[0;0;2;1];taylorw2=[0;5;2;1];
taylorc1=Pe*taylorw1;
taylorc2=Pe*taylorw2;
if con==1
x0=taylorc1(1,:);y0=taylorc1(2,:);z0=taylorc1(3,:);
end
if con==2
x0=taylorc2(1,:);y0=taylorc2(2,:);z0=taylorc2(3,:);
end

Piap1=[f/z0 0 -f*x0/z0^2 f*x0/z0;0 f/z0 -f*y0/z0^2 f*y0/z0;0 0 0 1];

X=[-1 1 1 -1;-0.5 -0.5 0.5 0.5;2 2 2 2;1 1 1 1];
PP=Pipp*Pe*X;
AP=Piap1*Pe*X;

I=AP;

colors = 'rrrr';
I = I ./repmat(I(3, :), 3, 1);
hold on
for i = 1 : 4
    line([I(1, i) I(1, mod(i, 4) + 1)], [I(2, i) I(2, mod(i, 4) + 1)], 'LineWidth', 2);
    plot(I(1, i), I(2, i), strcat(colors(i),'*'));
    text(I(1,i)-sign(I(1,i)) * .05, I(2,i) - sign(I(2,i)) *.05, sprintf('[%.3f, %.3f]', I(1,i), I(2,i)));
end



