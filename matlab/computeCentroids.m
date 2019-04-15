function [centroidsCW, centroidsCCW] = computeCentroids(gamma2)
xCW = zeros(length(gamma2.regionsCW),1);
xCCW = xCW;
yCW = xCW;
yCCW = xCW;

for n = 1:length(gamma2.regionsCW)
    [xCW(n), yCW(n)]  = centroid(gamma2.regionsCW(n));
    [xCCW(n), yCCW(n)] = centroid(gamma2.regionsCCW(n));
end
centroidsCW = [xCW, yCW];
centroidsCCW = [xCCW, yCCW];
end

    