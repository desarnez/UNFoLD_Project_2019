function [xw,yw,xwc,ywc]=thewing(angle)

wingx=[-0.25*0.04, -0.25*0.04, 0.75*0.04, 0.75*0.04]; % chord in m
wingy=[-0.002,0.002,0.002,-0.002]; % thickness in m
Rz=[cosd(-angle) -sind(-angle); sind(-angle) cosd(-angle)];
wxwy=Rz*[reshape(wingx,1,[]);reshape(wingy,1,[])];
xw=reshape(wxwy(1,:),1,[]); yw=reshape(wxwy(2,:),1,[]);
xwc=xw/0.04; ywc=yw/0.04;