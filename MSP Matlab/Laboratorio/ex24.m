% Exercise 24

% Given x as a cosine wave sampled at Fs = 8KHz, duration 1 second, 
% amplitude 1.5, frequency 1.1KHz, phase 45 deg.
% Compute y as x filtered with a low-pass filter 
% with normalized cut-off frequency of 0.4 and 64 samples
% Apply a Hanning window to select the first 512 samples of y
% Plot the magnitude of the DFT of the windowed y versus frequency in Hz.
% If you change the cut-off frequency to 0.05, 
% what do you expect to see in the spectrum of y?

close all
clearvars
clc

%% parameters

A = 1.25;
f0 = 1.1e3;
Fs = 8e3;
duration = 1;
time = 0:1/Fs:duration;
% convert the phase in radians
phase = 45*pi/180;
% signal
x = A*cos(2*pi*f0*time + phase);

%% Compute y as x filtered with a low-pass filter with normalized cut-off frequecy of 0.4 and 64 samples

N_filter = 64;
cutoff = 0.4;   
% NB: to obtain the cutoff of the filter for MATLAB, multiply by 2
cutoff_filter = cutoff * 2;

% create the FIR filter
h = fir1(N_filter -1, cutoff_filter);

% filtered signal
y = filter(h, 1, x);

%% frequency response of the filter vs normalized frequencies [-0.5, 0.5)

[H, omega] = freqz(h, 1, N_filter, 'whole');
figure, plot(omega/(2*pi) - 0.5, fftshift(abs(H)));
grid;
set(gca, 'fontsize', 18);

% % you can also define the frequency axis in this way:
% freq_axis = 0:1/N_filter: 1 - 1/N_filter;
% freq_axis = freq_axis - 0.5; 

%% apply a hanning window to select the first 512 samples of y

Nw = 512;
w = hann(Nw);
% or: window(@hann, Nw) 
% For details, see https://it.mathworks.com/help/signal/ref/window.html

y_w = y(1:Nw) .* w';

%% try analyzing the behaviour of different windows:

w1 = rectwin(64);
w2 = bartlett(64);
w3 = hamming(64);
w4 = blackman(64);

% open the window tool:
wvtool(w1, w2, w3, w4)
% notice that "close all" does not work in closing this figure

%% Plot the amplitude of the DFT of the windowed y vs Hz, from 0 (included) to Fs (not-included)

Yw = fft(y_w);

% define the frequency axis
freq_axis = 0:Fs/Nw:Fs - Fs/Nw;
freq_axis = freq_axis - Fs/2;
figure;
plot(freq_axis, fftshift(abs(Yw)));
grid;
set(gca, 'fontsize', 18);

%% try changing the cut-off to 0.05

