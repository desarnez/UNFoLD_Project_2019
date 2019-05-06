%%% find angle and origin
clear all, close all, clc
run labbook

c=10; 
folder=sprintf('ms%.3dmpt%.3d',LB(c).ms,LB(c).mpt);
im = @(n,AorB) fullfile(root.data,folder,sprintf('im_%.4d%c.tiff',n,AorB)); 

angle=nan(LB(c).N,1);
area=nan(LB(c).N,1);
centroid=nan(LB(c).N,2);
WING=zeros(2160,2560);
for n=1:LB(c).N
    n
    I=imread(im(n,'A')); % figure, imagesc(I), caxis([100 2000]), axis equal
    BW=imbinarize(I,0.1); % figure, imagesc(BW), axis equal
    BW(1:end,[1:200,1000:end])=0; BW([1:600,1400:end],1:1000)=0;
    BW=bwareaopen(BW,1000); % figure, imagesc(BW), axis equal

    props=regionprops(BW,'Orientation','Area','Centroid','PixelIdxList');
    
    if length(props)<1
        BW=imbinarize(I,0.02); 
        BW(1:end,[1:200,1000:end])=0; BW([1:600,1400:end],1:1000)=0;
        BW=bwareaopen(BW,2000);
        props=regionprops(BW,'Orientation','Area','Centroid','PixelIdxList');
    end
    if length(props)>=1
        [~,mi]=max(cat(1,props.Area));
        angle(n)=props(mi).Orientation;
        area(n)=props(mi).Area;
        centroid(n,1:2)=props(mi).Centroid;
        WING(props(mi).PixelIdxList)=WING(props(mi).PixelIdxList)+1;
    end
end
figure, imagesc(WING), axis equal, hold all
mcol=max(WING,[],1); 
mrow=max(WING,[],2); 
[~,x0]=max(mcol);
[~,y0]=max(mrow);
plot(x0,y0,'r*')

%%% group images with similar angle to calculate separate minimum images
%%% and masks
d=1; anglebin=sort([0:-d:-90,d:d:90]);
[a,~,anglenr]=histcounts(angle,[-90,anglebin+d]);
while any(a==1) %% to make sure there is not just one image in the bin.
    d=d+1; anglebin=sort([0:-d:-90,d:d:90]);
    [a,~,anglenr]=histcounts(angle,[-90,anglebin+d]);
end
save(pivmat(LB(c).ms,LB(c).mpt),'angle','x0','y0','anglenr','anglebin')