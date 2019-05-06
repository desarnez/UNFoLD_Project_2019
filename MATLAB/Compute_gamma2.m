warning('off','MATLAB:polyshape:boundary3Points')
warning('off','MATLAB:polyshape:repairedBySimplify')

disk_size = 10;
clear gamma2

gamma2.gam2 = zeros(size(u_comp,1), size(u_comp,2),size(u_comp,3));
gamma2.regionsCW = polyshape.empty(0, size(u_comp,3));
gamma2.regionsCCW = polyshape.empty(0, size(u_comp,3));

for n = 1:size(u_comp,3)
%     gam2_tmp = gamma2.gam2(:,:,n)
    gam2_tmp = gamma2g(u_comp(:,:,n), v_comp(:,:,n), disk_size);
    gamma2.regionsCW(1,n) = findCWVortex(gam2_tmp,x,y, param.c, 6);
    gamma2.regionsCCW(1,n) = findCCWVortex(gam2_tmp,x,y, param.c, 6);
    gamma2.gam2(:,:,n) = gam2_tmp;
end
[gamma2.circulationCW, gamma2.circulationCCW] = circulation(gamma2, o_comp, param, x, y)
clear gam2_tmp n disk_size