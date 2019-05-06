function y = add_zeros(x)
str = num2str(x)
switch length(str)
    case 1
        y = strcat('00',str);
    case 2
        y = strcat('0',str);
    case 3
        y = str;
end
