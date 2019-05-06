
function [circulationCW, circulationCCW] = circulation(gamma2, o_comp, param, x, y)

circulationCW = zeros(1,size(gamma2.regionsCW,2));
circulationCCW = zeros(1,size(gamma2.regionsCCW,2));

th = 0:0.1:2*pi; % Azimutal angle defined for the detection of points from the PIV grid contained in the Vortex area

for k = 1:2
    switch k
        case 1
            region = gamma2.regionsCW;
        case 2
            region = gamma2.regionsCCW;
    end
    
    circulation = zeros(1,size(region,2));
    for n=1:size(region,2)
        p1 = region(1,n);
        
        % Create a grid around region p1
        cols = find(x(1,:)/param.c > min(p1.Vertices(:,1)) & x(1,:)/param.c<max(p1.Vertices(:,1)));
        rows = find(y(:,1)/param.c > min(p1.Vertices(:,2)) & y(:,1)/param.c<max(p1.Vertices(:,2)));
        
        % rows & cols are extended to make sure that avery w elements
        % necessary will be taken into account
        xx = x(1, [cols(1)-1, cols, cols(end)+1])/param.c; 
        yy = y([rows(1)-1; rows; rows(end)+1], 1)/param.c;
        
        [X, Y] = meshgrid(xx,yy);
        
        % Reduce o_comp to the points on the predefined grid
        w = o_comp([rows(1)-1; rows; rows(end)+1], [cols(1)-1, cols, cols(end)+1], n)/param.U*param.c;
        
        % Check if a value of omega is contained in the vortex area and sets it
        % to zero if it is not
        for i = 1:length(w(:))
            if isnan(w(i))
                w(i) = 0;
                continue
            end
            
            % Create a polyshape around each points of w to check for
            % intersections with the vortex area
            [row, col] = find( w == w(i),1);
            x_circle = 0.001 * cos(th) + X(1,col);
            y_circle = 0.001 * sin(th) + Y(row,1);
            w_point = polyshape(x_circle,y_circle);
            polyout = intersect(p1, w_point);
            
            if polyout.NumRegions == 0
                w(i) = 0;
            end
        end
        
        circulation(n) = trapz(xx, trapz(yy, w));
    end
    
    switch k
        case 1
            circulationCW = circulation;
        case 2
            circulationCCW = circulation;
    end
end

end
