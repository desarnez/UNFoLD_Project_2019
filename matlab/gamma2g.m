function gam = gamma2g(u,v,Msize)
% compute gamma 2 on vector field with disk mask of radius Msize pixel
% works fine on field boundaries. Based on cross product formula

sz=size(u);
Dist=-Msize:Msize;
[I,J]=meshgrid(Dist);
Dist=hypot(I,J);
Disk=double(Dist<=Msize);
Disk0=Disk;Disk0(Msize+1,Msize+1)=0;
Disk0(Disk0==0)=NaN;

%% compute mean locals velocity 
uap=NaNconvAveraging(u,Disk);
vap=NaNconvAveraging(v,Disk);

%% extend grids from Msize in each direction
u2=NaN(sz(1)+2*Msize,sz(2)+2*Msize);
v2=u2; uap2=u2; vap2=u2;
uap2(Msize+1:end-Msize,Msize+1:end-Msize) = uap;
vap2(Msize+1:end-Msize,Msize+1:end-Msize) = vap;
u2(Msize+1:end-Msize,Msize+1:end-Msize) = u;
v2(Msize+1:end-Msize,Msize+1:end-Msize) = v;

%% Normalized distance mask
PMx = Disk0.*I./Dist ;
PMy = PMx' ;

%% indices reorganization
[idx,idy]=find(Disk0==1);

IdsDisk=sub2ind(size(Disk0),idx,idy);
PMx=PMx(IdsDisk);
PMy=PMy(IdsDisk);

idx=idx-Msize-1;idy=idy-Msize-1;

gam=zeros(size(u2,1),size(u2,2),length(idx));

%% computing

for k=1:length(idx)
    uu=circshift(u2,[idx(k),idy(k)])-uap2;
    vv=circshift(v2,[idx(k),idy(k)])-vap2;
    gam(:,:,k)=(PMy(k)*uu-PMx(k)*vv)./hypot(uu,vv);
end
gam=nanmean(gam,3);
gam=gam(Msize+1:end-Msize,Msize+1:end-Msize);

end