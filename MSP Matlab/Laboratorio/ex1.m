% Exercise 1

% double comment (%%) are used to divide your script
% into blocks. You can execute a block at a time by using
% "Run Section" (ctrl/cmd + enter)

% Begin always with these three lines:
close all % close figures
clearvars % clear workspace
clc % clear command window

%%

% Given the signal x(t) = Acos(2pift)
% 1. Write the script ex1.m to create the signal x(n) as x(t)
% from 0 to 0.5 seconds, sampled at Fs (sampling rate) =
% 1000Hz; A = 0.8, f = 50Hz, phase 30 deg.

A = 0.8;
f = 50;
Fs = 1000;
t = 0:1/Fs:0.5;  %Ts sampling time, Tf temporal duration
phi = 30; % deg

% conversion
% phi_deg:phi_rad = 180: pi     %si usa phi in radianti, uso la proporzione
phi_rad = phi*pi/180;

x = A*cos(2*pi*f*t + phi_rad);  % t = n*Ts per discretizzare, ma lo è già (moltiplico l'intervall per gli n numeri di intervalli e trovo la lunghezza temporale)

%% function sinusoid.m

% Write the function sinusoid.m which takes as input the
% time-axis, the amplitude, the frequency, the phase of a
% discrete sinusoid and return the signal.

%% Generate the same signal as 1. with sinusoid.m

x1 = sinusoid(t, A, f, phi_rad);

%% Plot the signals as a function of time and as a function of samples

figure(1);
plot(t, x);
hold on;
plot(t, x1, '--');
title('Signals as a function of time');

figure(2);
plot(1:length(x), x);
hold on;
plot(1:length(x1), x1, '--');
title('Signals as a function of samples');

