function guiver(x,y,u,v,varargin)

%% Quiver with arrow color depending on magnitude
% Date:     19.1.2018
% File:     guiver.m
% By:       Guillaume de Guyon
% Source:   https://stackoverflow.com/questions/29632430/quiver3-arrow-color-corresponding-to-magnitude/36941140
%
%% Mandatory Input:
%           x,y,u,v : matrices, as you would input in quiver
%% Optional input, order doesn't matter, except for the last one
%           N       : consider one cell every N cell of the grid
%           c       : magnitude matrix, same size as x,y,u,v.
%                     default hypot(u,v)
%           colmap  : colormap, N by 3 matrix of numbers between 0 and 1.
%                     default black
%           clim    : maximum magnitude values of the colorbar. 1 by 2 vector
%                     default []
%           opt     : aditionnal options compatible with quiver function.
%                     MUST BE PASSED IN LAST, AND FOLLOW A CHAR. 'o' for
%                     example, or '', or 'I love Jesus'
%           see quiver help.
%
% Output:   a plot
%
% Update: 
%         Author: 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

u(isnan(u))=0;
v(isnan(v))=0;

% default values
N=1;
c=hypot(u,v);
colmap=[0 0 0];
clim=[];
quivin={};

%% input acquisition
for ii=1:numel(varargin)
    a=varargin{ii};
    if isnumeric(a)
        if size(a)==size(x)
            c=a;
        elseif size(a,2)==3
            colmap=a;
        elseif length(a)==2
            clim=a;
        elseif length(a)==1
            N=a;
        end
    elseif ischar(a)
        quivin=varargin(ii+1:end);
        break
    end    
end

if N>1
    x=x(1:N:end,1:N:end);
    y=y(1:N:end,1:N:end);
    u=u(1:N:end,1:N:end);
    v=v(1:N:end,1:N:end);
    c=c(1:N:end,1:N:end);
end

%%
q=quiver(x,y,u,v,quivin{:});

if isempty(clim)
        [~, ~, ind] = histcounts(c, size(colmap, 1));
else
        [~, ~, ind] = histcounts(c, [-Inf,linspace(clim(1),clim(2),size(colmap,1)),Inf]);
end

d=ind2rgb(ind(:), colmap);
cmap = uint8(d * 255);
cmap(:,:,4) = 255;
cmap = permute(repmat(cmap, [1 3 1]), [2 1 3]);

set(q.Head,'ColorBinding', 'interpolated','ColorData', reshape(cmap(1:3,:,:), [], 4).');
pause(1e-15); % crashes otherwise ... undocumented matlab function
b=reshape(q.Head.VertexData(1:2,:)',3,[]);
patch(b(:,1:end/2),b(:,end/2+1:end),d,'EdgeColor','none');
set(q.Tail,'ColorBinding', 'interpolated','ColorData', reshape(cmap(1:2,:,:), [], 4).');

end