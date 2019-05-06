[~,~,xwc,ywc]=thewing(piv.alpha(300));
n_LEV = [280, 370; 430, 470; 547, 600];
n_TEV = [381, 440; 490, 560; 610, 680];

close all,

colors = [0.49, 0.18, 0.56; 0.93, 0.69, 0.13; 0.00, 0.45, 0.74; 0.47, 0.67, 0.19; 0.30, 0.75, 0.93; 0.86, 0.33, 0.10];

figure,
subplot(3,2,1:2)
% axis([x(1,1) x(1,end) y(1,1) y(end,1)]./param.c)
xlabel('x/c')
ylabel('y/c')
legend show
hold on,

subplot(3,2,3)
title('Leading Edge Vortex')
ylabel('x/c')
hold on
plot([0, 2], [0, 2]*param.U*.7116, '-k','DisplayName', 'dx/dt = U/1.4')
legend show
legend('autoupdate', 'off')
hold on

subplot(3,2,4)
title('Trailing Edge Vortex')
hold on
% plot([0, 2], [0, 2]*param.U/2+0.5, '-k', 'DisplayName', 'frac{dx}{dt} = U/2')

subplot(3,2,5)
xlabel('t_c')
ylabel('y/c')
hold on
plot([0, 1.5], [0, 1.5]*param.U*(-.1406)+0.3, '-k','DisplayName', 'dx/dt = -U/7')
legend show
legend('autoupdate', 'off')


subplot(3,2,6)
xlabel('t_c')
hold on

for n=1:3
    LEV_display_name = strcat('LEV', num2str(n));
    TEV_display_name = strcat('TEV', num2str(n));
    
    Delta_t_TEV = n_TEV(n,2)-n_TEV(n,1);
    Delta_t_LEV = n_LEV(n,2)-n_LEV(n,1);
    
    subplot(3,2,1:2)
    plot(gamma2.centroidsCW(n_LEV(n,1):n_LEV(n,2),1), gamma2.centroidsCW(n_LEV(n,1):n_LEV(n,2),2), 'DisplayName', LEV_display_name, 'color', colors(2*n-1,:))
    plot(gamma2.centroidsCCW(n_TEV(n,1):n_TEV(n,2),1), gamma2.centroidsCCW(n_TEV(n,1):n_TEV(n,2),2), 'DisplayName', TEV_display_name, 'color', colors(2*n,:))
    
    subplot(3,2,3)
    plot(piv.tc(76:76+Delta_t_LEV), gamma2.centroidsCW(n_LEV(n,1):n_LEV(n,2),1), 'color', colors(2*n-1,:))
    
    subplot(3,2,4)
    plot(piv.tc(76:76+Delta_t_TEV), gamma2.centroidsCCW(n_TEV(n,1):n_TEV(n,2),1), 'color', colors(2*n,:))

    subplot(3,2,5)
        plot(piv.tc(76:76+Delta_t_LEV), gamma2.centroidsCW(n_LEV(n,1):n_LEV(n,2),2), 'color', colors(2*n-1,:))
    
    subplot(3,2,6)
    plot(piv.tc(76:76+Delta_t_TEV), gamma2.centroidsCCW(n_TEV(n,1):n_TEV(n,2),2), 'color', colors(2*n,:))
end



subplot(3,2, 1:2)
legend('autoupdate', 'off')
fill(xwc,ywc,'k')
axis equal

