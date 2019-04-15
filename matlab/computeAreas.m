function [areaCW, areaCCW] = computeAreas(gamma2)
areaCW = zeros(1,length(gamma2.regionsCW));
areaCCW = areaCW;

for n = 1:length(gamma2.regionsCW)
    areaCW(n)  = area(gamma2.regionsCW(n));
    areaCCW(n) = area(gamma2.regionsCCW(n));
end
end

    