% Exercise 18

% Given x(n) = rectangular pulse of width 6, n in [0, 5]
% Given y(n) = x(n)
% Compute z(n) as the linear convolution between x and y.
% Compute the cyclic convolution between x and y
% Compute the product X(k)Y(k)
% Check that the IDFT of X(k)Y(k) and the cyclic convolution give the same result.
% Find the value of N such that cyclic convolution returns the same result 
% as linear convolution.
% Compute the cyclic convolution over N samples.
% Find the same result using DFT.

close all
clearvars
clc

%% define signals

L = 6;
x = ones(1, L);
n_x = 0:L-1;
y = x;
n_y = 0:L-1;

%% convolve them linearly

z = conv(x, y);
n_z = 0:n_x(end) + n_y(end);

figure, stem(n_z, z)

%% cyclic convolution

z_c = cconv(x, y, L);

figure;
stem(0:L-1, z_c, '--')

%% fft

X = fft(x);
Y = fft(y);

Z = X.*Y;  %conviene perchè non vale l'uguaglianza con la convoluzione

z = ifft(Z);

hold on,
stem(0:L-1, z, '--')

%% compute the cyclic convolution as a linear convolution.

N = L + L -1;

z_pad = cconv(x, y, N); % you can call cconv also without making the padding
n_pad = 0:N-1;

figure, stem(n_pad, z_pad);

%% with DFT

% you can call fft over N also without making the padding before
% MATLAB automatically pad the signal with zeros until reaching N samples
X_pad = fft(x, N); 
Y_pad = fft(y, N);
Z_pad = X_pad.*Y_pad;

z_pad_ifft = ifft(Z_pad);

hold on, stem(0:N-1, z_pad_ifft, '--');