function G1=gamma1(x,y,u,v,d)

    s=size(u);
    SE = strel('disk', d, 0);
    theSE=getnhood(SE);
    [I,J]=find(theSE);
    I=I-d-1;
    J=J-d-1;
    ind0=round(0.5*prod(s));
    [i0,j0]=ind2sub(s,ind0);
    IN=sub2ind(s,I+i0,J+j0);
    
    A=cart2pol(x(IN)-x(ind0), y(IN)-y(ind0));
    
    U=nansurround(u,d);
    V=nansurround(v,d);
    S=size(U);
    
    localS=[];
    for k=1:length(I)
        ANGLE=ones(S(1),S(2)).*A(k);
        [T,~]=cart2pol(circshift(U,[I(k) J(k)]), circshift(V,[I(k) J(k)]));
        localS=cat(3,localS,sin(ANGLE-T));
    end
    G1=-nansum(localS,3)/length(I);
    G1=unsurround(G1,d);
    
    ROI=ones(s(1),s(2));
    IND=(isnan(u) & isnan(v));
    ROI(IND)=nan;
    G1=G1.*ROI;
    
%     function G1=gamma1(x,y,u,v,d)
% 
%     s=size(u);
%     SE = strel('disk', d, 0);
%     theSE=getnhood(SE);
%     [I,J]=find(theSE);
%     I=I-d-1;
%     J=J-d-1;
%     ind0=round(0.5*prod(s));
%     [i0,j0]=ind2sub(s,ind0);
%     IN=sub2ind(s,I+i0,J+j0);
%     
%     A=cart2pol(x(IN)-x(ind0), y(IN)-y(ind0));
%     
%     localS=[];
%     for k=1:length(I)
%         ANGLE=ones(s(1),s(2)).*A(k);
%         [T,~]=cart2pol(circshift(u,[I(k) J(k)]), circshift(v,[I(k) J(k)]));
%         localS=cat(3,localS,sin(ANGLE-T));
%     end
%     G1=-nanmean(localS,3);
%     
%     ROI=ones(s(1),s(2));
%     IND=(isnan(u) & isnan(v));
%     ROI(IND)=nan;
% %     ROI([1:d,end-d:end],:)=nan; ROI(:,[1:d,end-d:end])=nan;
%     G1=G1.*ROI;