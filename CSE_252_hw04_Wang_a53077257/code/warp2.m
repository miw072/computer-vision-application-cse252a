function [ I1warped] = warp2(I1,u,v)
[x y] = meshgrid(1:size(I1,2),1:size(I1,1));
I1warped = interp2(I1, x+u, y+v, 'cubic');
I1warped(isnan(I1warped)) = I1(isnan(I1warped));
end

