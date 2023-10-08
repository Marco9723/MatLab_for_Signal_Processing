% Exercise 14

% Given a FIR filter h(n) = 1, n in [0, 19].
% Evaluate the DFT of the filter
% Visualize the DFT versus normalized frequency [0.5, 0.5).
% Pad the array with zeros until reaching 100 samples.
% Evaluate the DFT of the padded h(n) and visualize it.
% Are the two DFTs equal? Comment on the results.

close all
clearvars
clc

%% define signals

N = 20;
n_h = 0:N-1;
h = ones(size(n_h));

%% fft result

H_k = fft(h);

% how to define the frequency axis? 
% Frequency samples start from 0 to N-1. 
% If we divide by N samples, we
% obtain the normalized frequency axis, from 0 to 1 - 1/N. 
% if we want the normalized frequency axis from -0.5 (included) to 0.5 (NOT
% included), we have to subtract 0.5

% we use fftshift as we want to see the spectrum centered in frequency = 0
freq_axis = 0:N-1;   %creo
freq_axis = freq_axis./N;   %normalizzo
freq_axis = freq_axis - 0.5;   %shifto

figure, stem(freq_axis, fftshift(abs(H_k)))

%% padding with zeros

% padding with zeros ~= convolve in frequency domain by a periodic sinc...
% We are interpolating samples --> we are increasing the density of Fourier spectrum

num_zeros = 10000 - N;   %sarebbe 100 da testo
h_pad = padarray(h, [0, num_zeros], 'post');  %0 rows, num_zeros columns, in fondo all'array
N_pad = length(h_pad);

H_pad = fft((h_pad));

figure, stem([0:(N_pad - 1)]./(N_pad) - .5, fftshift(abs(H_pad)));


