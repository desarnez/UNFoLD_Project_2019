function m=nanmean2(M)
    v=~isnan(M);
    m=mean(M(v)); 
   