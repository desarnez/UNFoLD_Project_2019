function [x,y] = thewing2(M)

% M = u_comp(:,:,1);
[row, col] = find(isnan(M));
pos = [row, col];

x= []; y = [];

max_row = find(row==max(row));
min_row = find(row==min(row));
x = [pos(min(max_row),2), pos(max(max_row),2), pos(max(min_row),2),  pos(min(min_row),2)];
y = [pos(min(max_row),1), pos(max(max_row),1), pos(min(min_row),1), pos(max(min_row),1)];

end
