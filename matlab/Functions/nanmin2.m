function m=nanmin2(M)
    v=~isnan(M);
    m=min(M(v)); 
    