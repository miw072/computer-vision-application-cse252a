function [y, x] = NMS2(cimg, max_pts)
%% initialization
[m,n] = size(cimg);
mean_cimg = mean(mean(cimg));
boarder = 1;
%% local non-maximum suppression
local_max = zeros(m,n);
x_local = zeros(1000,1);
y_local = zeros(1000,1);
value_local = zeros(1000,1);
k = 1;
nmssize = 25;
% Search for the pixels that have a corner strength larger than the pixels 
% around it and larger than the average strength of the image. 
for i = (boarder+nmssize):(m-boarder-nmssize)
    for j = (boarder+nmssize):(n-boarder-nmssize)
        a = cimg(i,j);
        %if (a>mean_cimg)&&(a>=cimg(i-1,j-1))&&(a>=cimg(i-1,j))&&(a>=cimg(i-1,j+1))&&(a>=cimg(i,j-1))&&(a>=cimg(i,j+1))&&(a>=cimg(i+1,j-1))&&(a>=cimg(i+1,j))&&(a>=cimg(i+1,j+1))         
            b = max(max(cimg((i-nmssize):(i+nmssize),(j-nmssize):(j+nmssize))));
        if ((a>mean_cimg)&&(a>=b))
            local_max(i,j)=1;
            value_local(k) = a;
            y_local(k) = i;
            x_local(k) = j;
            k = k+1;
        end
    end
end
y_local(k:end) = [];
x_local(k:end) = [];
value_local(k:end) = [];

%% sort the local maximum value and output the most NUM value and coordinate 
rij = [value_local, y_local, x_local];
rij_sorted = sortrows(rij,-1);

rij_cut = rij_sorted(1:max_pts,:);
y = rij_cut(:, 2);
x = rij_cut(:, 3);

end

