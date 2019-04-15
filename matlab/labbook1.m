%%%
% add short summary of measurements
% when: 15.02.19 + 19.02.19
% who: Sabrina
% where: sharx
% what: 2D2C high speed PIV for some cases; 2 cameras + mirrors; forces for
% all cases; ramp motion flat plate with two sharp edges
% project: smartH
%%%


%%% where is data - where will data go?
root.raw = @(nr3) fullfile('\\sti1raw.epfl.ch\unfold\smartH\2019_SH_001\',sprintf('%i',nr3),'\loads'); % Raw data location
% root.raw = '\\sti1raw.epfl.ch\unfold\smartH\2018_SH_004\20180629\loads'; % Raw data location

root.pivmat='\\sti1raw.epfl.ch\unfold\smartH\2019_SH_001\Postprocessing\matfiles\piv';
root.loadmat='\\sti1raw.epfl.ch\unfold\smartH\2019_SH_001\Postprocessing\matfiles\loads';
root.fig='\\sti1raw.epfl.ch\unfold\smartH\smartH\2019_SH_001\Postprocessing\figurematter';
root.data=@(nr3) fullfile('\\sti1raw.epfl.ch\unfold\smartH\2019_SH_001\',sprintf('%i',nr3));

root.res='C:\Users\sabrinahenne\Documents\SmartH\2019_SH_001\results';
root.matlab='\\sti1raw.epfl.ch\unfold\smartH\MATLAB';

%%% shortcuts to frequently used files
raw_force = @(nr3,nr1,nr2) fullfile(root.raw(nr3),sprintf('ms%.3impt%.3i_FORCES*.bin',nr1,nr2)); % Force data
raw_pos = @(nr3,nr1,nr2) fullfile(root.raw(nr3),sprintf('ms%.3impt%.3i_POSITION*.bin',nr1,nr2)); % Position data
raw_par = @(nr3,nr1,nr2) fullfile(root.raw(nr3),sprintf('ms%.3impt%.3i*.txt',nr1,nr2)); % Parameters 

pivmat_avg = @(nr1,nr2) fullfile(root.pivmat,sprintf('ms%.3i_avg.mat',nr1));
pivmat = @(nr1,nr2) fullfile(root.pivmat,sprintf('ms%.3impt%.3i.mat',nr1,nr2));
loadmat = @(nr1,nr2) fullfile(root.loadmat, sprintf('ms%.3impt%.3i_loads.mat',nr1,nr2));

pressuremat = @(thecase) fullfile(root.mat,sprintf('ms%.3impt%.3i_p.mat',nr1,nr2));
fig = @(thecase,what) fullfile(root.fig,sprintf('ms%.3impt%.3i_%s',thecase,what));
instfig = @(thecase,what,n) fullfile(root.fig,'plots',sprintf('ms%.3impt%.3i_%s_%.4i',nr1,nr2,what,n));
resdat = @(nr1,nr2,what) fullfile(root.fig,'datfiles',sprintf('ms%.3impt%.3i_%s.dat',nr1,nr2,what));
% resdat = @(thecase,what) fullfile(root.fig,'datfiles',sprintf('ms%.3impt%.3i_%s.dat',LB(thecase).ms,LB(thecase).mpt,what));

%%% parameters that are the same for all tested cases
param.fpiv=1000;      % acquisition rate PIV
param.c=0.15;       % chorch length in m    
param.cmm=15;       % chord length in mm 
param.s=0.6;        % span in m
param.c0=0.25;      % position of pitching axis in /c
param.nrowpx=1024;  % number of row of raw image in px
param.ncolpx=1024;  % number of col of raw image in px
param.mu=0.89e-3;   % dynamic viscosity in Pas
param.rho=1000;      % density of water in kg/m^3
%%% some of them can be determined after the measurements
param.U=0.50;    % free stream velocity in m/s (200 rpm) 
param.M=4.385;      % magnification factor in px/mm
%%% estimated after running findangle.m
param.x0=332;       % x coord of pitching axis wing in px 
param.y0=459;       % y coord of pitching axis wing in px
%%% mask parameters
param.maskmin = 0;
param.maskmax = 30;
param.maskres = 0.01;

%%% List of MS that should not be saved w/ correlated data. Use for calibration,
%%% static angle sweeps
param.nocorr = [2 24];

%%% Subdivision into groups of MS that are associated by calibration & Re
grp.ms = {1 3:10 12:23 25:28};
grp.mpt = {[1:4] [1:4] [1:4] [1:4]};
grp.mscal = [2 2 2 24];

%%% specific parameters for all testcases
LB = struct('comment' , {});

%%% Set group properties quickly
for i = 1:157
LB(i).U = 0.5;
LB(i).Re = param.rho*LB(i).U*param.c/param.mu;
end    


%% static measurements at 30° for ~ 86s -> PIV only
% 20190214

currentindex=1; 
LB(currentindex).ms=1; 
LB(currentindex).mpt=1; 
LB(currentindex).date=20190214; % date in this yyyymmdd format 
LB(currentindex).PIV=1;    % Was PIV done?
LB(currentindex).skipsave=1; % Were images skipped while saving?
LB(currentindex).f_acqu=1000; % acquisition rate of camera 
LB(currentindex).N=10750; % number of images (with skipp)
LB(currentindex).dt=2000; % time between images
LB(currentindex).comment=' 30°, 0.00';

currentindex=2; 
LB(currentindex).ms=1;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190214; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10750; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 0.00';

currentindex=3; 
LB(currentindex).ms=1;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190214; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10750; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 0.00';

currentindex=4; 
LB(currentindex).ms=1;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190214; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10750; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 0.00';

currentindex=5; 
LB(currentindex).ms=1;
LB(currentindex).mpt=5; 
LB(currentindex).date=20190214; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10750; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 0.00';

currentindex=6; 
LB(currentindex).ms=1;
LB(currentindex).mpt=6; 
LB(currentindex).date=20190214; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10750; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 0.00';

currentindex=7; 
LB(currentindex).ms=1;
LB(currentindex).mpt=7; 
LB(currentindex).date=20190214; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10750; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 0.00';

currentindex=8; 
LB(currentindex).ms=1;
LB(currentindex).mpt=8; 
LB(currentindex).date=20190214; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10750; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 0.00';
%% ramp up motion 0° - 30°, 20s of data

currentindex=9; 
LB(currentindex).ms=2;
LB(currentindex).mpt=1;
LB(currentindex).date=20190215;
LB(currentindex).comment=' 0° calibration';

% PIV(1st case) + loads

currentindex=10; 
LB(currentindex).ms=3;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190215; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=7500; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 15.00';

currentindex=11; 
LB(currentindex).ms=3;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190215; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=7500; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 15.00';

currentindex=12; 
LB(currentindex).ms=3;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190215; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=7500; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 15.00';

currentindex=13; 
LB(currentindex).ms=3;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190215; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=7500; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 15.00';

currentindex=14; 
LB(currentindex).ms=4;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190215; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10000; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 25.00';

currentindex=15; 
LB(currentindex).ms=4;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 25.00';

currentindex=16; 
LB(currentindex).ms=4;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 25.00';

currentindex=17; 
LB(currentindex).ms=4;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 25.00';

currentindex=18; 
LB(currentindex).ms=5;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190215; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10000; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 35.00';

currentindex=19; 
LB(currentindex).ms=5;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 35.00';

currentindex=20; 
LB(currentindex).ms=5;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 35.00';

currentindex=21; 
LB(currentindex).ms=5;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 35.00';


% loads only
currentindex=22; 
LB(currentindex).ms=6;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 10.00';

currentindex=23; 
LB(currentindex).ms=6;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 10.00';

currentindex=24; 
LB(currentindex).ms=6;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 10.00';

currentindex=25; 
LB(currentindex).ms=6;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 10.00';

currentindex=26; 
LB(currentindex).ms=7;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 20.00';

currentindex=27; 
LB(currentindex).ms=7;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 20.00';

currentindex=28; 
LB(currentindex).ms=7;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 20.00';

currentindex=29; 
LB(currentindex).ms=7;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 20.00';

currentindex=30; 
LB(currentindex).ms=8;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 30.00';

currentindex=31; 
LB(currentindex).ms=8;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 30.00';

currentindex=32; 
LB(currentindex).ms=8;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 30.00';

currentindex=33; 
LB(currentindex).ms=8;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 30.00';

currentindex=34; 
LB(currentindex).ms=9;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 40.00';

currentindex=35; 
LB(currentindex).ms=9;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 40.00';

currentindex=36; 
LB(currentindex).ms=9;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 40.00';

currentindex=37; 
LB(currentindex).ms=9;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 40.00';

currentindex=38; 
LB(currentindex).ms=10;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190215; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10000; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 5.00';

currentindex=39; 
LB(currentindex).ms=10;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 5.00';

currentindex=40; 
LB(currentindex).ms=10;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 5.00';

currentindex=41; 
LB(currentindex).ms=10;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190215;
LB(currentindex).comment=' 30°, 5.00';

%% 20190219
% data deleted due to error in recording

%% 20190220

currentindex=42; 
LB(currentindex).ms=12;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 2.50';

currentindex=43; 
LB(currentindex).ms=12;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 2.50';

currentindex=44; 
LB(currentindex).ms=12;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 2.50';

currentindex=45; 
LB(currentindex).ms=12;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 2.50';

currentindex=46; 
LB(currentindex).ms=13;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 7.50';

currentindex=47; 
LB(currentindex).ms=13;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 7.50';

currentindex=48; 
LB(currentindex).ms=13;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 7.50';

currentindex=49; 
LB(currentindex).ms=13;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 7.50';

currentindex=50; 
LB(currentindex).ms=14;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 12.50';

currentindex=51; 
LB(currentindex).ms=14;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 12.50';

currentindex=52; 
LB(currentindex).ms=14;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 12.50';

currentindex=53; 
LB(currentindex).ms=14;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 12.50';

currentindex=54; 
LB(currentindex).ms=15;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 17.50';

currentindex=55; 
LB(currentindex).ms=15;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 17.50';

currentindex=56; 
LB(currentindex).ms=15;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 17.50';

currentindex=57; 
LB(currentindex).ms=15;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 17.50';

currentindex=58; 
LB(currentindex).ms=16;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 22.50';

currentindex=59; 
LB(currentindex).ms=16;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 22.50';

currentindex=60; 
LB(currentindex).ms=16;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 22.50';

currentindex=61; 
LB(currentindex).ms=16;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 22.50';

currentindex=62; 
LB(currentindex).ms=17;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 27.50';

currentindex=63; 
LB(currentindex).ms=17;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 27.50';

currentindex=64; 
LB(currentindex).ms=17;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 27.50';

currentindex=65; 
LB(currentindex).ms=17;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 27.50';

currentindex=66; 
LB(currentindex).ms=18;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 32.50';

currentindex=67; 
LB(currentindex).ms=18;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 32.50';

currentindex=68; 
LB(currentindex).ms=18;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 32.50';

currentindex=69; 
LB(currentindex).ms=18;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 32.50';

currentindex=70; 
LB(currentindex).ms=19;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 37.50';

currentindex=71; 
LB(currentindex).ms=19;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 37.50';

currentindex=72; 
LB(currentindex).ms=19;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 37.50';

currentindex=73; 
LB(currentindex).ms=19;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 37.50';

currentindex=74; 
LB(currentindex).ms=20;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 42.50';

currentindex=75; 
LB(currentindex).ms=20;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 42.50';

currentindex=76; 
LB(currentindex).ms=20;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 42.50';

currentindex=77; 
LB(currentindex).ms=20;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 42.50';

currentindex=78; 
LB(currentindex).ms=21;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 45.00';

currentindex=79; 
LB(currentindex).ms=21;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 45.00';

currentindex=80; 
LB(currentindex).ms=21;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 45.00';

currentindex=81; 
LB(currentindex).ms=21;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 45.00';

currentindex=82; 
LB(currentindex).ms=22;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 47.50';

currentindex=83; 
LB(currentindex).ms=22;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 47.50';

currentindex=84; 
LB(currentindex).ms=22;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 47.50';

currentindex=85; 
LB(currentindex).ms=22;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 47.50';

currentindex=86; 
LB(currentindex).ms=23;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 50.00';

currentindex=87; 
LB(currentindex).ms=23;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 50.00';

currentindex=88; 
LB(currentindex).ms=23;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 50.00';

currentindex=89; 
LB(currentindex).ms=23;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190220;
LB(currentindex).comment=' 30°, 50.00';

%% New motion code
% 20190228

currentindex=90; 
LB(currentindex).ms=24;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190228;
LB(currentindex).comment=' calibration 0°';

currentindex=91; 
LB(currentindex).ms=24;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190228;
LB(currentindex).comment=' calibration 0°';

currentindex=92; 
LB(currentindex).ms=25;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190228; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10000; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 10.00';

currentindex=93; 
LB(currentindex).ms=25;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190228; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10000; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 10.00';

currentindex=94; 
LB(currentindex).ms=25;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190228; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10000; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 10.00';

currentindex=95; 
LB(currentindex).ms=25;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190228; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10000; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 10.00';

currentindex=96; 
LB(currentindex).ms=26;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190228; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10000; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 25.00';

currentindex=97; 
LB(currentindex).ms=26;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190228; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10000; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 25.00';

currentindex=98; 
LB(currentindex).ms=26;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190228; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10000; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 25.00';

currentindex=99; 
LB(currentindex).ms=26;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190228; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10000; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 25.00';

currentindex=100; 
LB(currentindex).ms=27;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190228; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10000; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 35.00';

currentindex=101; 
LB(currentindex).ms=27;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190228; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10000; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 35.00';

currentindex=102; 
LB(currentindex).ms=27;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190228; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10000; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 35.00';

currentindex=103; 
LB(currentindex).ms=27;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190228; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10000; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 35.00';

currentindex=104; 
LB(currentindex).ms=28;
LB(currentindex).mpt=1; 
LB(currentindex).date=20190228; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10000; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 45.00';

currentindex=105; 
LB(currentindex).ms=28;
LB(currentindex).mpt=2; 
LB(currentindex).date=20190228; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10000; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 45.00';

currentindex=106; 
LB(currentindex).ms=28;
LB(currentindex).mpt=3; 
LB(currentindex).date=20190228; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10000; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 45.00';

currentindex=107; 
LB(currentindex).ms=28;
LB(currentindex).mpt=4; 
LB(currentindex).date=20190228; 
LB(currentindex).PIV=1;
LB(currentindex).skipsave=1; 
LB(currentindex).f_acqu=1000; 
LB(currentindex).N=10000; 
LB(currentindex).dt=2000;
LB(currentindex).comment=' 30°, 45.00';