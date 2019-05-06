function m=nanmax2(M)
    v=~isnan(M);
    m=max(M(v));  