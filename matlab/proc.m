clear all, close all, clc
%%% convert lab book pages into labbook.m
run labbook
%%% extract angles of attack and origin 

for c=1:length(LB)
    load(pivmat(LB(c).ms,LB(c).mpt))
    
    folder=sprintf('ms%.3dmpt%.3d',LB(c).ms,LB(c).mpt);
    im = @(n,AorB) fullfile(root.data,folder,sprintf('im_%.4d%c.tiff',n,AorB)); 
    minim = @(n,AorB) fullfile(root.res,folder,'min',sprintf('min_%.4d%c.tiff',n,AorB));
    out2c = @(n) fullfile(root.res,folder,'2c',sprintf('res_%.4d.nc',n));
    mask = @(n) fullfile(root.res,'masks',sprintf('mask_%.4d.bmp',n));
    par = fullfile(root.res,'par','');

    unix(sprintf('mkdir -p %s/par/',root.res));
    unix(sprintf('mkdir -p %s%s/min/',root.res,folder));
    unix(sprintf('mkdir -p %s/masks/',root.res));
    unix(sprintf('mkdir -p %s%s/2c/',root.res,folder));

    %%% calculate minimum image using pivutils
    imgbatchcommand = ['imgbatch -min -o',minim(0,'A'),' ',im(1,'A'),' ',im(LB(c).N,'A')];
    unix(imgbatchcommand);
    imgbatchcommand = ['imgbatch -min -o',minim(0,'B'),' ',im(1,'B'),' ',im(LB(c).N,'B')];
    unix(imgbatchcommand);

    %%% calculate minimum image using matlab
    % use the angle information to create minimum images for the individual angle bins
    
    %%% make masks 
    %%% by hand for various angles or automatically based on the raw image
    %%% or the angle information
    [xpx,ypx]=meshgrid(1:param.ncolpx,1:param.nrowpx);
    wingx=[-param.c0*param.cmm*param.M, -param.c0*param.cmm*param.M, ...
        (1-param.c0)*param.cmm*param.M, (1-param.c0)*param.cmm*param.M];
    wingy=[-20,20,20,-20]; %thickness in px
    wx=wingx+param.x0;
    wy=wingy+param.y0;
    
    for j=1:length(anglebin)
        maskim=zeros(param.nrowpx,param.ncolpx);
         
        tomask=inpolygon(xpx,ypx,wx,wy);
        maskim(tomask)=1;
        imwrite(maskim,mask(j));
    end
    
    %%% generate the par file using PIVview - save as ascii 
    % if magnification factor or delta t change for different ms or mpt,
    % use 1 and correct later
    % set origin at the pitching axis of the wing determined using find
    % angle
    
    %%% piv pocessing 
    % you can use the paralel computing toolbox to speed up the processing
    parfor n=1:LB(c).N
        dpivcommand = ['dpiv -mask',mask(anglenr(n)),' -o',feval(out2c,n),' ',par,' ',im(n,'A'),' ',im(n,'B')];
        unix(dpivcommand);
    end
end