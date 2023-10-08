% Exercise 25

% Given x(n) defined as the sum of two sinusoidal signals, 
% sampled at Fs = 500 Hz with duration 3 seconds, one with frequency 50 Hz 
% and the other one with frequency 100Hz:
% Downsample x(n) with downsampling factor M = 4
% Decimate x(n) with decimation factor M = 4, using a FIR filter with order 64. 
% Plot the DFTs of x(n), of the downsampled and of the decimated signals 
% vs frequency [Hz] in the same figure and comment on the results.
% Try also M = 2 and see what happens

close all
clearvars
clc

%% parameters

Fs = 500;
f_0 = 50;
f_1 = 100;
duration = 3;
time = 0:1/Fs:3; 
x = cos(2*pi*f_0 * time) + cos(2*pi*f_1 * time);

%% downsample x with a factor M

M = 4;

x_downsampled = x(1:M:end);

%% decimate the signal with a factor M, using a FIR filter with order 64. 

% define the filter
% consider a filtering with cutoff = Fs/(2*M) 
% --> normalized cut-off frequency = 1/(2*M)
% --> cut-off frequency for the filter in MATLAB = 1/M
lpf = fir1(64, 1/M);

% filtered signal
x_f = filter(lpf, 1, x);

% downsample the signal
x_decimated = x_f(1:M:end);

%% DFT of x versus frequencies in Hz, from 0 (included) to Fs (not-included)

Xf = fft(x);
N = length(x);

% frequency axis
freq_axis = 0:Fs/N:Fs - Fs/N;

figure;
plot(freq_axis, abs(Xf));
leg{1} = 'Original signal';
grid

%% DFT of downsampled and decimated signals

N_down = length(x_downsampled);
N_dec = length(x_decimated); 

Xf_downsampled = fft(x_downsampled);
Xf_decimated = fft(x_decimated);

% downsampled signal
% frequency axis
freq_axis = 0:Fs/N_down : Fs -Fs/N_down;
hold on;
plot(freq_axis, abs(Xf_downsampled), '--x');
leg{2} = 'Downsampled signal';

% decimated signal
% frequency axis
freq_axis = 0:Fs/N_dec : Fs -Fs/N_dec;
plot(freq_axis, abs(Xf_decimated), '--o');
leg{3} = 'Decimated signal';
legend(leg);

