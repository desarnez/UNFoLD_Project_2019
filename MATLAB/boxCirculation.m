%% Circulation box

circulation = 0;
circulation_out = 0;
circulation_no_out = 0;

for n=1:size(o_comp,3)
    o_tmp = zeros(69,120);
    tmp = o_comp(:,:,n);
    o_tmp(tmp < -5) = tmp(tmp < -5);
    o_tmp = o_tmp/param.U*param.c;
    circulation_out(n) = sum(o_tmp(:,end)); 
%     circulation(n) = trapz(x(1,:)/param.c, trapz(y(:,1)/param.c, o_tmp))+sum(circulation_out);
    circulation(n) = sum(o_tmp,'all')+sum(circulation_out);
    circulation_no_out(n) = sum(o_tmp,'all');
    
%     circulation(n) = sum(o_tmp,'all');
end

circulation_n = zeros(10, size(u_comp,3));  
% index = 0;
% for i = linspace(0.5, 2, 10)
%     index = index+1;
    xx = x(1,:)/param.c;
    yy = y(:,1)/param.c;
    b = 2;
    x_box = [xwc(2)-param.c*b/2, xwc(2)-param.c*b/2, xwc(2)+param.c*b/2, xwc(2)+param.c*b/2];
    y_box = [ywc(2)-param.c*b/2, ywc(2)+param.c*b/2, ywc(2)+param.c*b/2, ywc(2)-param.c*b/2];
    
    for n = 1:4
        % Gets the columns and rows number of the edges of the box
        [~, x_box_n(n)] = min(abs(xx - x_box(n)));
        [~, y_box_n(n)] = min(abs(yy - y_box(n)));
    end
    
    flux = zeros(1,size(o_comp,3));
    for k = 1:size(o_comp,3)
        %     o_tmp = zeros(69,120);
        o_tmp = o_comp(:,:,n);
        %     o_tmp(tmp>0.1) = tmp(tmp > 0.1);
        for n = 1:4
            switch n
                case 1
                    normal = [-(y_box(n+1)-y_box(n)); x_box(n+1)-x_box(n)];
                    normal = normal/norm(normal);
                    U = [u_comp(y_box_n(n):y_box_n(n+1), x_box_n(n):x_box_n(n+1), k)';
                        v_comp(y_box_n(n):y_box_n(n+1), x_box_n(n):x_box_n(n+1), k)'];
                    o_vect = o_tmp(y_box_n(n):y_box_n(n+1), x_box_n(n):x_box_n(n+1))';
                    flux(k) = flux(k) + trapz(linspace(y_box(n), y_box(n+1), length(o_vect)),(o_vect'.*(U'*normal)));
                case 2
                    normal = [-(y_box(n+1)-y_box(n)); x_box(n+1)-x_box(n)];
                    normal = normal/norm(normal);
                    U = [u_comp(y_box_n(n):y_box_n(n+1), x_box_n(n):x_box_n(n+1), k);
                        v_comp(y_box_n(n):y_box_n(n+1), x_box_n(n):x_box_n(n+1), k)];
                    o_vect = o_tmp(y_box_n(n):y_box_n(n+1), x_box_n(n):x_box_n(n+1));
                    flux(k) = flux(k) + trapz(linspace(x_box(n), x_box(n+1), length(o_vect)),(o_vect'.*(U'*normal)));
                case 3
                    normal = [-(y_box(n+1)-y_box(n)); x_box(n+1)-x_box(n)];
                    normal = normal/norm(normal);
                    U = [u_comp(y_box_n(n):-1:y_box_n(n+1), x_box_n(n):x_box_n(n+1), k)';
                        v_comp(y_box_n(n):-1:y_box_n(n+1), x_box_n(n):x_box_n(n+1), k)'];
                    o_vect = o_tmp(y_box_n(n):-1:y_box_n(n+1), x_box_n(n):x_box_n(n+1))';
                    flux(k) = flux(k) + trapz(linspace(y_box(n), y_box(n+1), length(o_vect)),(o_vect'.*(U'*normal)));
                case 4
                    normal = [-(y_box(1)-y_box(n)); x_box(1)-x_box(n)];
                    normal = normal/norm(normal);
                    U = [u_comp(y_box_n(n):y_box_n(1), x_box_n(n):-1:x_box_n(1), k);
                        v_comp(y_box_n(n):y_box_n(1), x_box_n(n):-1:x_box_n(1), k)];
                    o_vect = o_tmp(y_box_n(n):-1:y_box_n(1), x_box_n(n):-1:x_box_n(1));
                    flux(k) = flux(k) + trapz(linspace(x_box(n), x_box(1), length(o_vect)),(o_vect'.*(U'*normal)));
            end
        end
    end
    
%     circulation_n(index,:) = flux;
% end

