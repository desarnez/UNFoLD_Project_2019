function [row, col] = saddlePoints(M)

min_y = islocalmin(M(2:end-1,2:end-1),1);
min_x = islocalmin(M(2:end-1,2:end-1),2);
max_y = islocalmax(M(2:end-1,2:end-1),1);
max_x = islocalmax(M(2:end-1,2:end-1),2);

saddles = min_x.*max_y + min_y.*max_x;


[row, col] = find(saddles) ;
