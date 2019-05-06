function cm=kcolormap(varargin)

ncolors=length(varargin);
w=0;
l=64*floor(ncolors/2);
 
parulacolor=[];
for j=1:ncolors
    if ischar(varargin{j})
        parulacolor(j,:)=rgb(varargin{j});
    else
        parulacolor(j,:)=varargin{j};
    end
    if parulacolor(j,:)==rgb('white'), 
        w=1;
        wj=j;
    end
end

rate=linspace(0,1,ncolors);

col1=interp1(rate,parulacolor(:,1),linspace(0,1,l));
col2=interp1(rate,parulacolor(:,2),linspace(0,1,l));
col3=interp1(rate,parulacolor(:,3),linspace(0,1,l));

cm=[col1',col2',col3'];

if w
    wrow=round(rate(wj)*l);
    d=3;
    for k=-d:d
        cm(wrow+k,:)=rgb('white');
    end
end

colormap(cm);

set(0,'defaultfigurecolormap',cm);