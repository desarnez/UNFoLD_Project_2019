n = 0
Cl_tmp = zeros(length(piv.Cl))
for i in 1:length(piv.t)
    if n==3
        Cl_tmp[i]=piv.Cl[i]
        n = 0
    n++
