b = 4;
n = 345;
x_box = [xwc(2), xwc(2) + b*param.c*sin(piv.alpha(n)*pi/180), xwc(3) + b*param.c*sin(piv.alpha(n)*pi/180), xwc(3)]; % fifth value added to fit with the for loops
y_box = [ywc(2), ywc(2) + b*param.c*cos(piv.alpha(n)*pi/180), ywc(3) + b*param.c*cos(piv.alpha(n)*pi/180), ywc(3)];

figure, hold on, 
for row = 1:size(u_comp, 1)
    plot(x(1,:)/param.c,y(row,:)/param.c,'.k')
end
plot([x_box, x_box(1)], [y_box, y_box(1)], '-r', 'linewidth', 3)
axis equal
fill(xwc,ywc,'k')