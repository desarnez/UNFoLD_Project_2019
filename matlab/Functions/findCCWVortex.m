function region = findCCWVortex(M,x,y,c, treshold)
max_val = max(M, [], 'all');
levels  = linspace(2/pi, max_val, 20);
C = contourc(x(1,:)/c, y(:,1)/c, M,levels);

[row, col] = find(M == max(M,[],'all'));
%Create a circle around the min point
th = 0:0.1:2*pi;
x_circle = 0.001 * cos(th) + x(1,col);
y_circle = 0.001 * sin(th) + y(row,1);
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
nonCenteredRegions = [];
nonCenteredLevels = [];

for i = 1:length(level)
    nb_vertices_i = sum(nb_vertices(1:(i-1)))+i+1; % Number of vertices at level i
    leveln = C(:,nb_vertices_i:(nb_vertices_i+nb_vertices(i)-1)); % Vertices of level i
    
    p1 = polyshape(leveln(1,:),leveln(2,:)); % Polyshape of level
    centered = intersect(p1, max_point);
    if centered.NumRegions == 1
        centeredRegions = [centeredRegions, p1];
        centeredLevels = [centeredLevels , level(i)];
        %         plot(leveln(1,:),leveln(2,:),'DisplayName', num2str(i));
        
    else
        nonCenteredRegions = [nonCenteredRegions, p1];
        nonCenteredLevels = [nonCenteredLevels, level(i)];
    end
    
end
% legend show
centeredLevels_new = centeredLevels;
centeredRegions_new = centeredRegions;

for i = 1:length(centeredRegions)-1
    
    nextlvl =  centeredLevels(i+1); %gets the value of the level under the i-th centeredRegion
    nb_regions = size(find(level == nextlvl), 2); %gets the number of regions at lowerlvl
    firstlvl_pos = find(level == nextlvl,1); % Finds the positions of the first lowerlvl in the level vector
    
    for k = firstlvl_pos:(firstlvl_pos+nb_regions) % Evaluate all levels at lowerlvl
        % Create the polyshape corresponding to level k
        nb_vertices_k = sum(nb_vertices(1:(k-1)))+k+1; % Number of vertices at level k
        leveln = C(:,nb_vertices_k:(nb_vertices_k+nb_vertices(k)-1)); % Vertices of level k
        
        p1 = polyshape(leveln(1,:),leveln(2,:)); % Polyshape of level k
 
        crossing = intersect(p1, centeredRegions(i)); % Check if polyshape is included in higher level region
        centered = intersect(p1, max_point);% Check if polyshape is over the min value
        
        if crossing.NumRegions == 1 && centered.NumRegions == 0 % Check if region p1 is contained into centeredRegions(i) but not conataining the min_point
            nb_lowerRegions = 0;
            
            for j = nonCenteredRegions(nonCenteredLevels>nextlvl) % Goes through every nonCenteredRegion below nxtlevel to check the number of regions that are contained in region p1
                % If the number of level in a subpeak is > 3 then the
                % subpeak is considered big enough & deleted from the
                % region
                crossing_p1 = intersect(p1,j); % Check the intersection between j & p1
                
                if crossing_p1.NumRegions == 1 && nb_lowerRegions < treshold
                    nb_lowerRegions = nb_lowerRegions + 1;
                elseif crossing_p1.NumRegions == 1 && nb_lowerRegions >= treshold
                    centeredRegions_new = centeredRegions(i+1:end);
                    centeredLevels_new = centeredLevels(i+1:end);
                    break
                end
                
            end
            
        end
    end
end

if max_val < 2/pi
    centeredRegions_new = max_point;
end
try
region = centeredRegions_new(1);
catch
    centeredRegions_new = max_point;
    region = centeredRegions_new(1);
    'Warning : max_point was taken as a region'
end
