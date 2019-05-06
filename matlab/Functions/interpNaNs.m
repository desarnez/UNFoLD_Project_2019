function A = interpNaNs(M)
A = M;
[row, col]  = find(isnan(M));
Z =[];
i =1;
xx = [];
yy = [];
while i < length(col)
    max_row = row(max(find(col == col(i))));
    interp = (M(row(i)-1,col(i))+M(max_row+1,col(i)))/2;
    z = [ones(4-(max_row-row(i)),1)*M(row(i)-1, col(i));ones((max_row-row(i)),1)*interp];
    A(row(i):row(i)+3, col(i)) = z;
    i = find(col>col(i),1);
end
end

