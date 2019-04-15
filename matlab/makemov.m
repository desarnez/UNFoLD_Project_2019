close all
clc

limits=[-20 20]; step=0.2;
clear MOV
MOV = struct('cdata',[],'colormap',[]);
MOV(size(gamma2.gam2,3)-150+1).cdata = [];
MOV(size(gamma2.gam2,3)-150+1).colormap  =[];

figure('units','normalized','outerposition',[0 0 0.7 1], 'innerposition', [0, 0, 0.6, 1.5])
kcolormap('indigo','darkblue','royalblue','white','darkorange','firebrick','maroon');

subplot(2,1,2)
yyaxis left
plot(piv.tc(150:end), piv.Cl(150:end), 'DisplayName', 'Cl')
axis([piv.tc(150), piv.tc(end), 0, 1.8])
xlabel('t_{c} [s]');
ylabel('Cl');
hold on


yyaxis right
ylabel('Circulation');
plot(piv.tc(150:end), abs(gamma2.circulationCCW(150:end)),'-b', 'DisplayName', 'TEV Circulation');
plot(piv.tc(150:end), abs(gamma2.circulationCW(150:end)),'-g', 'DisplayName', 'LEV Circulation');
legend('Cl', 'TEV Circulation', 'LEV Circulation', 'Location', 'NorthWest', 'autoupdate', 'off')
legend('boxoff')
yyaxis left
p = plot([piv.tc(150), piv.tc(150)], [0, 1.8], '-r', 'LineWidth', 2, 'DisplayName', 'time');



for n=150:size(gamma2.gam2,3)
    [~,~,xwc,ywc]=thewing(piv.alpha(n));
    toplot=o_comp(:,:,n)/param.U*param.c;
    
    subplot(2,1,1)
    hold off
    [~,h]=contourf(x/param.c,y/param.c,toplot,[nanmin2(toplot),limits(1):step:limits(2),nanmax2(toplot)]);
    set(h,'linestyle','none')
    hold all
    guiver(x/param.c,y/param.c,u_comp(:,:,n),v_comp(:,:,n),2,'!',1.5)
    title(n)
    fill(xwc,ywc,'k')
    caxis(limits)
    axis equal
%     axis([x(1,1) x(1,end) y(1,1) y(end,1)]./param.c)
    xlabel('x/c')
    ylabel('y/c')
    c_=colorbar;
    c_.Title.String='\omega c/U_{\infty}'; c_.Title.FontSize=20;
    plot(gamma2.regionsCCW(1,n));
    plot(gamma2.regionsCW(1,n));

    plot(gamma2.centroidsCW(n,1), gamma2.centroidsCW(n,2),'MarkerSize', 5, 'MarkerFaceColor', 'g','MarkerEdgeColor','none', 'Marker', 'o', 'LineStyle', 'none')
    plot(gamma2.centroidsCCW(n,1), gamma2.centroidsCCW(n,2),'MarkerSize', 5, 'MarkerFaceColor', 'b','MarkerEdgeColor','none', 'Marker', 'o', 'LineStyle', 'none')
       
    
    %%     Cl plot
    subplot(2,1,2)
    yyaxis left
    hold on
    yyaxis left
    p.XData = [piv.tc(n) piv.tc(n)];
    
    MOV(n-149) = getframe(gcf);
end

kMOV=VideoWriter('ms025mpt001_CWtresh5.mp4','MPEG-4');
kMOV.FrameRate = 10;
open(kMOV)
writeVideo(kMOV, MOV)
close(kMOV)
close all
    
