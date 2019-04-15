% function a = thewing3(M)
% a = [];
% k = 0;
% for i=1:size(M,2) 
%     n = size(M,1);
%     k = 0;
%     while n > 0 && ~isnan(k)
%         k = M(n, i);
%         n = n-1;
%     end
%     if n~=0
%      a = [a; n+2, i, M(n+2,i)];
%     end
%      
% end
% end
% 
function a = thewing3(M)
a = [];
k = 0;
for i=1:size(M,2) 
    n = 1;
    k = 0;
    while n < size(M,1) && ~isnan(k)
        k = M(n, i);
        n = n+1;
    end
    if n~=65
     a = [a; n-2, i, M(n-2,i)];
    end
     
end
end

