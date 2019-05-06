function y = running_average(data, timestep, frequency)
n = 1;
range = (timestep*frequency)/1000;
for i=(range+1):length(data)
    y(i) = mean(data(i-range:i));
end
end

