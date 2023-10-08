% Exercise 16

% Given a sinusoidal signal with frequency = 2Hz defined 
% over N = 50 samples, sampled with Fs = 50 Hz
% Add this signal to a second sinusoid with frequency 2.2Hz 
% and the same durantion and sampling rate.
% Plot the global signal vs time.
% Compute the FFT. Can you see the two peaks?
% How to see the correct Fourier spectrum?

close all
clearvars
clc

%% parameters

f0 = 2;
f1 = 2.2;
Fs = 50;
N = 50;
time = 0:1/Fs: 1/Fs*(N-1);

%% define signals

s0 = cos(2*pi*f0*time);
s1 = cos(2*pi*f1*time);
s = s0 + s1;

%% plot the signal

figure;
plot(time, s);

%% FFT of s

S_f = fft(s);
freq = 0:1/N*Fs:Fs - 1/N*Fs;

figure;
stem(freq - Fs/2, fftshift(abs(S_f)));

%% zero padding?

N_tot = 10000;
num_pad = N_tot - N;
s_pad = padarray(s, [0, num_pad], 'post');
S_pad = fft(s_pad);

freq_pad = 0:1/N_tot * Fs: Fs - 1/N_tot * Fs;

figure; 
stem(freq_pad - Fs/2, fftshift(abs(S_pad)));

% we can increase the density in Fourier domain, but we will not see the
% two peaks because the resolution is fixed by the time window!
% zero-padding does not modify the size of the rectangular window (N = 50
% samples)


%% increase the number of measurements

% increasing measurements modifies the size of the rectangular
% window --> frequency resolution enhances.
% In order to see the 2 exact peaks: 
% 1) you should have enough resolution (the length of the signal should be
% enough in order to visualize the 0.2 Hz difference in the frequency
% domain)
% 2) the number of samples must be a multiple of the two periods
% period in sample = Fs / f
% period_0 = 25
% period_1 = 250 / 11
% --> the minimum possible value is 250.

N = 250; 
time = 0:1/Fs:1/Fs*(N-1);

s0 = cos(2*pi*f0*time);
s1 = cos(2*pi*f1*time);
s = s0 + s1;

S_f = fft(s);
freq = 0:1/N*Fs:Fs - 1/N*Fs;

figure;
stem(freq - Fs/2, fftshift(abs(S_f)));