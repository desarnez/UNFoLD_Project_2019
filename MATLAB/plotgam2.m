clear contour
n = 475;
min_val = min(gamma2.gam2(:,:, n),[], 'all');
max_val = max(gamma2.gam2(:,:, n),[], 'all');
levels = [linspace(min_val,-2/pi, 20), linspace(2/pi,max_val,20)];
figure('units','normalized','outerposition',[0 0 2 1], 'innerposition', [0, 0, 0.6, 1.5])

limits=[-20 20]; step=0.2;
subplot(1,2,1);
% lim_sup = ones(size(gam2,1),size(gam2,2))*2/pi;
% lim_inf = ones(size(gam2,1),size(gam2,2))*-2/pi;
hold on,
% surf(lim_sup), surf(lim_inf)
[C, h] = contour(x/param.c,y/param.c,gamma2.gam2(:,:,n),levels);
title(n)
plot(gamma2.regionsCW(n))
plot(gamma2.regionsCCW(n))
% set(h, 'lineWidth',3,'linecolor','r')
% [~,region] = postContour3(gamma2.gam2CW(:,:,n),x,y,param.c);
% plot(gamma2.regionsCW(:,n));
% plot(gamma2.regionsCCW(:,n));
% plot(gamma2_test.regionsCCW(:,n));
subplot(1,2,2)
surf(gamma2.gam2(:,:,n))
hold on
[~,h] = contour3(gamma2.gam2(:,:,n), levels)
set(h, 'Linecolor', 'r','LineWidth',3)
%% x lvl
% levels = [linspace(min_val,-2/pi, 5), linspace(2/pi,1,20)];
% figure('units','normalized','outerposition',[1 0 2 1], 'innerposition', [0, 0, 0.6, 1.5])
% 
% limits=[-20 20]; step=0.2;
% subplot(1,2,1);
% % lim_sup = ones(size(gam2,1),size(gam2,2))*2/pi;
% % lim_inf = ones(size(gam2,1),size(gam2,2))*-2/pi;
% hold on,
% % surf(lim_sup), surf(lim_inf)
% [C, h] = contour(x/param.c,y/param.c,gamma2_5lvl.gam2(:,:,n),levels);
% title('5 levels')
% % set(h, 'lineWidth',3,'linecolor','r')
% % [~,region] = postContour3(gamma2.gam2CW(:,:,n),x,y,param.c);
% plot(gamma2_5lvl.regionsCW(:,n));
% plot(gamma2_5lvl.regionsCCW(:,n));
% subplot(1,2,2)
% surf(gamma2_5lvl.gam2(:,:,n))
% hold on
% [~,h] = contour3(gamma2_5lvl.gam2(:,:,n), levels)
% set(h, 'Linecolor', 'r','LineWidth',3)
