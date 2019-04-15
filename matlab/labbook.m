%%%
% add short summary of measurements
% when: 20180329 
% who: Alex, Karen 
% where: sharx
% what: 2D2C PIV small pitching panel + forces for all cases
% project: pre-REASON
%%%

%%% where is data - where will data go?
root.mat='C:/Users/Charles/Documents/EPFL/UNFoLD/matfiles/';
root.res='C:/Users/Charles/Documents/EPFL/UNFoLD/results/';
root.matlab='C:/Users/Charles/Documents/EPFL/UNFoLD/matlab/';
root.fig='C:/Users/Charles/Documents/EPFL/UNFoLF/figurematter/';
root.data='/Volumes/unfold/2018/20180329/';

%%% shortcuts to frequently used files
pivmat = @(nr1,nr2) fullfile(root.mat,sprintf('ms%.3impt%.3i.mat',nr1,nr2));
loadsmat = @(nr1,nr2) fullfile(root.mat, sprintf('ms%.3impt%.3i_loads.mat', nr1, nr2));
pressuremat = @(thecase) fullfile(root.mat,sprintf('ms%.3impt%.3i_p.mat',nr1,nr2));
fig = @(thecase,what) fullfile(root.fig,sprintf('ms%.3impt%.3i_%s',thecase,what));
instfig = @(thecase,what,n) fullfile(root.fig,'plots',sprintf('ms%.3impt%.3i_%s_%.4i',nr1,nr2,what,n));
resdat = @(thecase,what) fullfile(root.fig,'datfiles',sprintf('ms%.3impt%.3i_%s.dat',nr1,nr2,what));

%%% parameters that are the same for all tested cases
param.fpiv=15;      % acquisition rate PIV
param.c=0.04;       % chorch length in m    
param.cmm=40;       % chord length in mm 
param.c0=0.25;      % position of pitching axis in /c
param.nrowpx=2160;  % number of row of raw image in px
param.ncolpx=2560;  % number of col of raw image in px
%%% some of them can be determined after the measurements
param.U=0.5;    % free stream velocity in m/s (200 rpm) 
param.M=12.15;      % magnification factor in px/mm
%%% estimated after running findangle.m
param.x0=551;       % x coord of pitching axis wing in px 
param.y0=993;       % y coord of pitching axis wing in px

%%% specific parametes for all testcases
LB = struct('comment' , {});

currentindex=1;
LB(currentindex).ms=25;      % measurement series
LB(currentindex).mpt=1;     % measurement point
LB(currentindex).dt=4000;   % PIV pulse separation in us
LB(currentindex).N=400;     % number of images recorded
LB(currentindex).f=1.88;    % pitching frequency in Hz 
LB(currentindex).A=84;      % pitching amplitude in degree 
LB(currentindex).SorT='S';  % type of motion: "S"inusoidal or "T"rapezoidal
LB(currentindex).comment='first test, delta t too large'; % comment 

currentindex=2;
LB(currentindex).ms=1;      
LB(currentindex).mpt=2;     
LB(currentindex).dt=3000;  
LB(currentindex).N=92;     
LB(currentindex).f=1.88;     
LB(currentindex).A=84;      
LB(currentindex).SorT='S'; 
LB(currentindex).comment='delta t still too large'; 

currentindex=3;
LB(currentindex).ms=1;      
LB(currentindex).mpt=3;     
LB(currentindex).dt=2000;  
LB(currentindex).N=65;     
LB(currentindex).f=1.88;     
LB(currentindex).A=84;      
LB(currentindex).SorT='S';
LB(currentindex).comment='image saving interupted only 65 im saved';

currentindex=4;
LB(currentindex).ms=1;      
LB(currentindex).mpt=4;     
LB(currentindex).dt=2000;  
LB(currentindex).N=255;     
LB(currentindex).f=1.88;     
LB(currentindex).A=84;      
LB(currentindex).SorT='S';
LB(currentindex).comment='ok';

currentindex=5;
LB(currentindex).ms=2;      
LB(currentindex).mpt=1;     
LB(currentindex).dt=2000;  
LB(currentindex).N=400;     
LB(currentindex).f=0.54;     
LB(currentindex).A=68;      
LB(currentindex).SorT='S'; 
LB(currentindex).comment='';

currentindex=6;
LB(currentindex).ms=2;      
LB(currentindex).mpt=2;     
LB(currentindex).dt=2000;  
LB(currentindex).N=400;     
LB(currentindex).f=0.54;     
LB(currentindex).A=68;      
LB(currentindex).SorT='S'; 
LB(currentindex).comment='';

currentindex=7;
LB(currentindex).ms=3;      
LB(currentindex).mpt=1;     
LB(currentindex).dt=2000;  
LB(currentindex).N=400;     
LB(currentindex).f=0.98;     
LB(currentindex).A=72;      
LB(currentindex).SorT='T'; 
LB(currentindex).comment='';

currentindex=8;
LB(currentindex).ms=3;      
LB(currentindex).mpt=2;     
LB(currentindex).dt=2000;  
LB(currentindex).N=400;     
LB(currentindex).f=0.98;     
LB(currentindex).A=72;      
LB(currentindex).SorT='T'; 
LB(currentindex).comment='';

currentindex=9;
LB(currentindex).ms=4;      
LB(currentindex).mpt=1;     
LB(currentindex).dt=2000;  
LB(currentindex).N=400;     
LB(currentindex).f=0.3;     
LB(currentindex).A=62;      
LB(currentindex).SorT='T'; 
LB(currentindex).comment='';

currentindex=10;
LB(currentindex).ms=4;      
LB(currentindex).mpt=2;     
LB(currentindex).dt=2000;  
LB(currentindex).N=400;     
LB(currentindex).f=0.3;     
LB(currentindex).A=62;      
LB(currentindex).SorT='T'; 
LB(currentindex).comment='';

currentindex=11;
LB(currentindex).ms=5;      
LB(currentindex).mpt=1;     
LB(currentindex).dt=2000;  
LB(currentindex).N=99;     
LB(currentindex).f=4.8;     
LB(currentindex).A=17;      
LB(currentindex).SorT='S'; 
LB(currentindex).comment='';

currentindex=12;
LB(currentindex).ms=5;      
LB(currentindex).mpt=2;     
LB(currentindex).dt=2000;  
LB(currentindex).N=99;     
LB(currentindex).f=4.8;     
LB(currentindex).A=17;      
LB(currentindex).SorT='S'; 
LB(currentindex).comment='';

currentindex=13;
LB(currentindex).ms=6;      
LB(currentindex).mpt=1;     
LB(currentindex).dt=2000;  
LB(currentindex).N=72;     
LB(currentindex).f=6.6;     
LB(currentindex).A=16;      
LB(currentindex).SorT='S'; 
LB(currentindex).comment='';

currentindex=14;
LB(currentindex).ms=6;      
LB(currentindex).mpt=2;     
LB(currentindex).dt=2000;  
LB(currentindex).N=72;     
LB(currentindex).f=6.6;     
LB(currentindex).A=16;      
LB(currentindex).SorT='S';
LB(currentindex).comment='';

currentindex=15;
LB(currentindex).ms=7;      
LB(currentindex).mpt=1;     
LB(currentindex).dt=2000;  
LB(currentindex).N=338;     
LB(currentindex).f=1.4;     
LB(currentindex).A=22;      
LB(currentindex).SorT='S'; 
LB(currentindex).comment='';

currentindex=16;
LB(currentindex).ms=7;      
LB(currentindex).mpt=2;     
LB(currentindex).dt=2000;  
LB(currentindex).N=338;     
LB(currentindex).f=1.4;     
LB(currentindex).A=22;     
LB(currentindex).SorT='S'; 
LB(currentindex).comment='';

currentindex=17;
LB(currentindex).ms=8;      
LB(currentindex).mpt=1;     
LB(currentindex).dt=2000;  
LB(currentindex).N=400;     
LB(currentindex).f=0.3;     
LB(currentindex).A=62;      
LB(currentindex).SorT='S'; 
LB(currentindex).comment='';

currentindex=18;
LB(currentindex).ms=8;      
LB(currentindex).mpt=2;     
LB(currentindex).dt=2000;  
LB(currentindex).N=400;     
LB(currentindex).f=0.3;     
LB(currentindex).A=62;      
LB(currentindex).SorT='S'; 
LB(currentindex).comment='';

currentindex=19;
LB(currentindex).ms=9;      
LB(currentindex).mpt=1;     
LB(currentindex).dt=2000;  
LB(currentindex).N=135;     
LB(currentindex).f=3.56;     
LB(currentindex).A=32;      
LB(currentindex).SorT='S'; 
LB(currentindex).comment='tunnel was not on';

currentindex=20;
LB(currentindex).ms=10;      
LB(currentindex).mpt=1;     
LB(currentindex).dt=2000;  
LB(currentindex).N=135;     
LB(currentindex).f=3.56;     
LB(currentindex).A=32;      
LB(currentindex).SorT='S'; 
LB(currentindex).comment='';

currentindex=21;
LB(currentindex).ms=10;      
LB(currentindex).mpt=2;     
LB(currentindex).dt=2000;  
LB(currentindex).N=135;     
LB(currentindex).f=3.56;     
LB(currentindex).A=32;      
LB(currentindex).SorT='S'; 
LB(currentindex).comment='';

currentindex=22;
LB(currentindex).ms=11;      
LB(currentindex).mpt=1;     
LB(currentindex).dt=2000;  
LB(currentindex).N=174;     
LB(currentindex).f=2.7;     
LB(currentindex).A=44;      
LB(currentindex).SorT='S'; 
LB(currentindex).comment='';

currentindex=23;
LB(currentindex).ms=11;      
LB(currentindex).mpt=2;     
LB(currentindex).dt=2000;  
LB(currentindex).N=174;     
LB(currentindex).f=2.7;     
LB(currentindex).A=44;      
LB(currentindex).SorT='S'; 
LB(currentindex).comment='';

currentindex=24;
LB(currentindex).ms=12;      
LB(currentindex).mpt=1;     
LB(currentindex).dt=2000;  
LB(currentindex).N=104;     
LB(currentindex).f=4.6;     
LB(currentindex).A=24;      
LB(currentindex).SorT='S'; 
LB(currentindex).comment='';

currentindex=25;
LB(currentindex).ms=12;      
LB(currentindex).mpt=2;     
LB(currentindex).dt=2000;  
LB(currentindex).N=104;     
LB(currentindex).f=4.6;     
LB(currentindex).A=24;      
LB(currentindex).SorT='S'; 
LB(currentindex).comment='';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%