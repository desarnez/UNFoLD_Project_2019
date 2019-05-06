b = 4;
n = 345;
x_box = [xwc(2), xwc(2) + b*param.c*sin(piv.alpha(n)*pi/180), xwc(3) + b*param.c*sin(piv.alpha(n)*pi/180), xwc(3)]; % fifth value added to fit with the for loops
y_box = [ywc(2), ywc(2) + b*param.c*cos(piv.alpha(n)*pi/180), ywc(3) + b*param.c*cos(piv.alpha(n)*pi/180), ywc(3)];

a = (x_box(2)-x_box(1))/(y_box(2)-y_box(1));
b = x_box(2)-a*y_box(2);

xx = x(1,:)/param.c;
yy = y(:,1)/param.c;

x_box_n = zeros(1,4);
y_box_n = zeros(1,4);
for n = 1:4
    % Gets the columns and rows number of the edges of the box
    [~, x_box_n(n)] = min(abs(xx - x_box(n)));
    [~, y_box_n(n)] = min(abs(yy - y_box(n)));
end

edges = zeros(y_box_n(2)-y_box_n(1),2);
index = 0;
for i = y_box_n(1):y_box_n(2)
    index = index+1;
    [~,I] = min(abs(xx - (a*yy(i)+b)));
    edges(index,:) = [xx(I), yy(i)];
end


for k = 1:size(o_comp,3)
    %     o_tmp = zeros(69,120);
    o_tmp = o_comp(:,:,k);
    %     o_tmp(tmp>0.1) = tmp(tmp > 0.1);
    for n = 1:(size(edges,1)-1)
        normal = [-(edges(n+1,2)-edges(n,2)); edges(n+1,1)-edges(n,1)];
        normal = normal/norm(normal);
        U = [u_comp(y_box_n(n):y_box_n(n+1), x_box_n(n):x_box_n(n+1), k)';
            v_comp(y_box_n(n):y_box_n(n+1), x_box_n(n):x_box_n(n+1), k)'];
        o_vect = o_tmp(y_box_n(n):y_box_n(n+1), x_box_n(n):x_box_n(n+1))';
        circulation_box(k) = circulation_box(k) + trapz(linspace(y_box(n), y_box(n+1), length(o_vect)),(o_vect'.*(U'*normal)));
