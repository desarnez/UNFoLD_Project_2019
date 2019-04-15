function C= NaNconvAveraging(A,h)
% convolution of X (containing NaN) by mask h (eventually containing NaN)
% averaged by number of mask elements applied
m = isnan(A);
mn=~m;
h=rot90(h,2);
n= isnan(h);

A(m) = 0;
h(n)=0 ;

jl=h;
jl(h~=0)=1;

C = conv2(A,h,'same');         % 2-dim convolution
N = conv2(double(mn),jl,'same');     % normalization term

C = C./N;
C(m)=NaN;

end