%% function [areas, contour] = postContourSup(M)
M = gam2;
C = contourc(M,20);
[row, col] = find(M == max(M,[],'all'));
%Create a circle around the min point
th = 0:0.1:2*pi;
x = 2 * cos(th) + col;
y = 2 * sin(th) + row;
max_point = polyshape(x,y);

%Get the altitude & number of vertices of each level
k=1;
level = [];
nb_vertices = [];
while k<size(C,2)
    level = [level, C(1,k)];
    nb_vertices = [nb_vertices, C(2,k)];
    k = k+nb_vertices(end)+1;
end
%% Extracts every Region that is above the min_point 
centeredRegions = [];
centeredLevels = [];

level = fliplr(level);
nb_vertices = fliplr(nb_vertices);

level = level(level>2/pi);
i = length(level);
while i>0 % Extracts every Region that is above the min_point
    
    n = sum(nb_vertices(1:(i-1)))+i+1; % Position of the first point of the contour at level i
    leveln = C(:,n:(n+nb_vertices(i)-1)); % Vertices of level i
    
    p1 = polyshape(leveln(1,:),leveln(2,:)); % Polyshape of level i
    centered = intersect(p1, max_point);
    if centered.NumRegions ==1
        centeredRegions = [centeredRegions, p1];
        centeredLevels = [centeredLevels , level(i)];
        %         plot(leveln(1,:),leveln(2,:),'DisplayName', num2str(i));
        
        
    end
    i = i-1;
    
end
% legend show

%% Eliminate regions that contain more than one region
centeredLevels_new = centeredLevels;
centeredRegions_new = centeredRegions;

for i = 1:length(centeredRegions)-1

    lowerlvl =  centeredLevels(i+1); %gets the value of the level under the i-th centeredRegion
    Nregions = size(find(level == lowerlvl), 2); %gets the number of regions at lowerlvl
    firstlvl = find(level == lowerlvl,1); % Finds the positions of the first lowerlvl in the level vector
    
    for k = firstlvl:(firstlvl+Nregions) % Evaluate all levels at lowerlvl
		% Create the polyshape corresponding to level k
        n = sum(nb_vertices(1:(k-1)))+k+1; % Number of vertices at level i
        leveln = C(:,n:(n+nb_vertices(k)-1)); % Vertices of level i
        p1 = polyshape(leveln(1,:),leveln(2,:)); % Polyshape of level i
		
        crossing = intersect(p1, centeredRegions(i)); % Check if polyshape is included in higher level region
        centered = intersect(p1, max_point); % Check if polyshape is over the min value
		
        if crossing.NumRegions == 1 && centered.NumRegions == 0
			centeredRegions_new = centeredRegions(i+1:end);
            centeredLevels_new = centeredLevels(i+1:end);
            break
        end
    end
    
end


% %% Error handling
% i = size(centeredRegions_new,2);
% 
% if i>1
%     p1 = centeredRegions_new(i);
%     while p1.NumRegions<2 && i>1
%         i = i-1;
%         p1 = centeredRegions_new(i);
%     end
%     
%     
%     areas = area(centeredRegions_new(i+1));
%     contour = centeredRegions_new(i+1);
% else
%     try
%     areas = area(centeredRegions_new(i));
%     contour = centeredRegions_new(i);
%     catch
%         areas = area(max_point);
%         contour = max_point;
%     end
% end
% 
% 
% 
