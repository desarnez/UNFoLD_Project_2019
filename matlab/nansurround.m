function y=nansurround(x,d)
    y=nan(size(x)+[2*d-1,2*d-1]);
    y(d:end-d,d:end-d)=x;