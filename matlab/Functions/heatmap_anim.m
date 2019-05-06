figure
for i=1:400
    gam = gamma2g(u_comp(:,:,i),v_comp(:,:,i),5);
    subplot(2,1,1)
    pcolor(o_comp(:,:,i));
    subplot(2,1,2)
    pcolor(gam)
    pause(0.01);
end
