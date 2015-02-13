function [ overlap ] = OverlapFunc(x1min,y1min,x1max,y1max,x2min,y2min,x2max,y2max)
w1 = (x1max-x1min+1); h1 = (y1max-y1min+1);
w2 = (x2max-x2min+1); h2 = (y2max-y2min+1);
x1c = (x1min+x1max)/2; y1c = (y1min+y1max)/2;
x2c = (x2min+x2max)/2; y2c = (y2min+y2max)/2;
xv1 = [x1min x1max x1max x1min]; yv1 = [y1min y1min y1max y1max];
xv2 = [x2min x2max x2max x2min]; yv2 = [y2min y2min y2max y2max];

xmin = round(min(x1min,x2min)); xmax = round(max(x1max,x2max));
ymin = round(min(y1min,y2min)); ymax = round(max(y1max,y2max));

x = repmat([xmin:xmax], ymax-ymin+1, 1);
x = x(:);
y = repmat([ymin:ymax]', 1, xmax-xmin+1);
y = y(:);


in1 = inpolygon(x, y, xv1, yv1);
in2 = inpolygon(x, y, xv2, yv2);
in = in1 + in2;
op = sum(in==2); tp = sum(in>0);
overlap = (op)/(tp);
end

