function [Cl, tc] = average(data, timestep, frequency)
n = 1;
for i=1:length(data.tc)
    if i == round(n*timestep*frequency)
        tc(n) = data.tc(i);
        Cl(n) = mean(data.Cl(((n-1)*timestep*frequency+1):(n*timestep*frequency)));
        n = n+1;
    end
end
end

