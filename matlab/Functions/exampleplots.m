clear all, close all, clc
run labbook

c=9;
load(pivmat(LB(c).ms,LB(c).mpt))
   
%%% example plot
n=120;
[~,~,xwc,ywc]=thewing(-angle(n));
figure, hold all
toplot=o_comp(:,:,n)/param.U*param.c;
limits=[-20 20]; step=0.2;
[C,h]=contourf(x/param.c,y/param.c,toplot,[nanmin2(toplot),limits(1):step:limits(2),nanmax2(toplot)]);
set(h,'linestyle','none')
hold all
guiver(x/param.c,y/param.c,u_comp(:,:,n),v_comp(:,:,n),2,'!',2)
fill(xwc,ywc,'k')
set(gca,'clim',limits)
axis equal tight

%%% pod
[lambda, a, PSI]=do_PODn(find(x),v_comp);
figure, 
for m=1:9
    subplot(3,3,m), pcolor(x,y,PSI(:,:,m)), shading flat, axis equal tight
    title(sprintf('mode %i',m))
    caxis([-0.05 0.05])
end
figure, plot(lambda./sum(lambda),'k*'), set(gca,'xlim',[0 20])
figure, hold all, for m=2:3, plot(a(m,:)./sqrt(2*lambda(m))), end
figure, hold all, for m=4:5, plot(a(m,:)./sqrt(2*lambda(m))), end

figure, hold all
plot(a(4,:)./sqrt(2*lambda(4)), a(5,:)./sqrt(2*lambda(5)),'k*')
plot(exp(1i*linspace(0,2*pi,100)),'r')
axis equal tight

%%% phase averaging using POD
phase=atan2(a(4,:)./sqrt(2*lambda(4)), a(5,:)./sqrt(2*lambda(5)));
figure, plotyy(1:N,phase,1:N,angle)
[phases,tdcu]=tripledecompthis(phase,u_comp,11);
[~,tdcv]=tripledecompthis(phase,v_comp,11);
[~,tdco]=tripledecompthis(phase,o_comp,11);

figure 
for p=1:10
    toplot=tdcv.phavg(:,:,p);
    limits=[-0.08 0.08]; step=0.002;
    [C,h]=contourf(x/param.c,y/param.c,toplot,[nanmin2(toplot),limits(1):step:limits(2),nanmax2(toplot)]);
    set(h,'linestyle','none')
    set(gca,'clim',limits)
    axis equal tight
    pause(1)
end

figure 
for p=1:10
    hold off
    toplot=tdco.phavg(:,:,p)/param.U*param.c;
    limits=[-10 10]; step=0.2;
    [C,h]=contourf(x/param.c,y/param.c,toplot,[nanmin2(toplot),limits(1):step:limits(2),nanmax2(toplot)]);
    set(h,'linestyle','none')
    hold all
    guiver(x/param.c,y/param.c,tdcu.phavg(:,:,p),tdcv.phavg(:,:,p),2,'!',2)
    set(gca,'clim',limits)
    axis equal tight
    pause(2)
end

%%% phaseaveraging using angle of attack
figure, plot((1:N)/param.fpiv*LB(c).f,angle,'k*')
phase=mod((1:N)/param.fpiv*LB(c).f,1)*2*pi;
[phases,tdcu]=tripledecompthis(phase,u_comp,11);
[~,tdcv]=tripledecompthis(phase,v_comp,11);
[~,tdco]=tripledecompthis(phase,o_comp,11);

figure 
for p=1:20
    toplot=tdcv.phavg(:,:,p);
    limits=[-0.08 0.08]; step=0.002;
    [C,h]=contourf(x/param.c,y/param.c,toplot,[nanmin2(toplot),limits(1):step:limits(2),nanmax2(toplot)]);
    set(h,'linestyle','none')
    set(gca,'clim',limits)
    axis equal tight
    pause(1)
end

figure 
for p=1:10
    hold off
    toplot=tdco.phavg(:,:,p)/param.U*param.c;
    limits=[-10 10]; step=0.2;
    [C,h]=contourf(x/param.c,y/param.c,toplot,[nanmin2(toplot),limits(1):step:limits(2),nanmax2(toplot)]);
    set(h,'linestyle','none')
    hold all
    guiver(x/param.c,y/param.c,tdcu.phavg(:,:,p),tdcv.phavg(:,:,p),2,'!',2)
    set(gca,'clim',limits)
    axis equal tight
    pause(2)
end


