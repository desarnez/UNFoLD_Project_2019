function [areas, contour] = postContourSup2(M,x,y,c)
% clear contour
% M = gamma2g(u_comp(:,:,289), v_comp(:,:,289), 10);
% c = param.c;
C = contourc(x(1,:)/c, y(:,1)/c, M, linspace(2/pi,1,2));
% hold on, set(h, 'linewidth',3,'linecolor', 'r') 
% hold on, surf(x/c, y/c, M)
[row, col] = find(M == max(M,[],'all'));
%Create a circle around the min point
th = 0:0.1:2*pi;
x_circle = 0.0001 * cos(th) + x(1,col);
y_circle = 0.0001 * sin(th) + y(row,1);
max_point = polyshape(x_circle/c,y_circle/c);

%Get the altitude & number of vertices of each level
k=1;
level = [];
nb_vertices = [];
while k<size(C,2)
    level = [level, C(1,k)];
    nb_vertices = [nb_vertices, C(2,k)];
    k = k+nb_vertices(end)+1;
end

centeredRegions = [];
centeredLevels = [];

for i = 1:length(level)
    n = sum(nb_vertices(1:(i-1)))+i+1; % Number of vertices at level i
    leveln = C(:,n:(n+nb_vertices(i)-1)); % Vertices of level i
    
    p1 = polyshape(leveln(1,:),leveln(2,:)); % Polyshape of level
%     hold on, plot(p1)
    centered = intersect(p1, max_point);
    if centered.NumRegions ==1
%         hold on, plot(p1)
        centeredRegions = [centeredRegions, p1];
        centeredLevels = [centeredLevels , level(i)];
        %         plot(leveln(1,:),leveln(2,:),'DisplayName', num2str(i));
        
        
    end
    i = i-1;
    
end
% legend show
centeredLevels_new = centeredLevels;
centeredRegions_new = centeredRegions;
% for i = 1:length(centeredRegions)-1
% 
%     upperlvl =  centeredLevels(i+1); %gets the value of the level under the i-th centeredRegion
%     Nregions = size(find(level == upperlvl), 2); %gets the number of regions at upperlvl
%     firstlvl = find(level == upperlvl,1); % Finds the positions of the first upperlvl in the level vector
%     
%     for k = firstlvl:(firstlvl+Nregions-1) % Evaluate all levels at lowerlvl
% 		% Create the polyshape corresponding to level k
%         n = sum(nb_vertices(1:(k-1)))+k+1; % Number of vertices at level i
%         leveln = C(:,n:(n+nb_vertices(k)-1)); % Vertices of level i
%         p1 = polyshape(leveln(1,:),leveln(2,:)); % Polyshape of level i
%        hold on,  plot(p1)
% 		
%         crossing = intersect(p1, centeredRegions(i)); % Check if polyshape is included in higher level region
%         centered = intersect(p1, max_point); % Check if polyshape is over the min value
% 		
%         if crossing.NumRegions == 1 && centered.NumRegions == 0
% 			centeredRegions_new = centeredRegions(i+1:end);
%             centeredLevels_new = centeredLevels(i+1:end);
%             break
%         end
%     end
%     
% end

i = size(centeredRegions_new,2);

if i>1
    p1 = centeredRegions_new(i);
    while p1.NumRegions<2 && i>1
        i = i-1;
        p1 = centeredRegions_new(i);
    end
    
    
    areas = area(centeredRegions_new(i+1));
    contour = centeredRegions_new(i+1);
else
    try
    areas = area(centeredRegions_new(i));
    contour = centeredRegions_new(i);
    catch
        areas = area(max_point);
        contour = max_point;
    end
end
end
% 

