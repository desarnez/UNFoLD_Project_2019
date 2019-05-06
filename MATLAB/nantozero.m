function M = nantozero(m)
M = m;
for n = 1:size(m,3)
    tmp = m(:,:,n);
    tmp(isnan(tmp(:,:))) = 0;
    M(:,:,n) = tmp;
end
