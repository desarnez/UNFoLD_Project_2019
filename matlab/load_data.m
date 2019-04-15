clear all, close all, clc
run labbook

for c=1:length(LB)
    load(pivmat(LB(c).ms,LB(c).mpt))
    
    folder=sprintf('ms%.3dmpt%.3d',LB(c).ms,LB(c).mpt);
    out2c = @(n) fullfile(root.res,folder,'2c',sprintf('res_%.4d.nc',n));
    
    % to see what is in the results file:
    ncdisp(out2c(1));
    % get info
    info=ncinfo(out2c(1));
    nrow=info.Dimensions(2).Length;
    ncol=info.Dimensions(3).Length;
    xymin=info.Variables(8).Attributes(4).Value/1000; % in m
    xymax=info.Variables(8).Attributes(5).Value/1000; % in m
    [x,y]=meshgrid(linspace(xymin(1),xymax(1),ncol),linspace(xymin(2),xymax(2),nrow));
    
    % define output variables
    N=LB(c).N;
    u_comp=nan(nrow,ncol,N); % freesteam velocity component
    v_comp=nan(nrow,ncol,N); % normal velocity component
    o_comp=nan(nrow,ncol,N); % vorticity 
    f_comp=nan(nrow,ncol,N); % flag
        
    % read velocity data
    for n=1:N
        out=ncread(out2c(n),'velocity');
        u_comp(:,:,n)=reshape(out(1,:,:),ncol,nrow)';  
        v_comp(:,:,n)=reshape(out(2,:,:),ncol,nrow)';
        flags=ncread(out2c(n),'piv_flags');
        f_comp(:,:,n)=reshape(flags,ncol,nrow)';
    end
    dudy=gradient(u_comp,mean(diff(y(:,1))));
    dvdx=gradient(v_comp,mean(diff(x(1,:))));
    o_comp=dvdx-dudy;
    m_comp=hypot(u_comp,v_comp);
        
    save(pivmat(LB(c).ms,LB(c).mpt),'x','y','u_comp','v_comp','o_comp','m_comp','f_comp','N','-append') 
end
    
%%% example plot
n=10;
[~,~,xwc,ywc]=thewing(-angle(10));
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