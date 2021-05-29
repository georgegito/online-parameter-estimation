addpath("../lib/sim");
addpath("../lib/msd");
clear;
close all;
format longG;

%% simulation 1
close all;

% parameters
r = 102;
am = 10.3;

% sim_1
sim_1( r, am );
pause();

%% simulation 2a
close all;

% parameters
r1 = 10;
r2 = 10;
n0 = 0.15;
f = 20;

% sim_2a
sim_2a( r1, r2, n0, f );
pause();

%% simulation 2b
close all;

% parameters
r1 = 10;
r2 = 10;
theta_m = 4;
n0 = 0.15;
f = 20;

% sim_2b
sim_2b( r1, r2, theta_m, n0, f );
pause();

%% simulation 3
close all;

% parameters
r1 = 0.9;
r2 = 0.5;

% sim_3
sim_3( r1, r2 );
pause();

close all;