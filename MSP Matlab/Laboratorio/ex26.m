% Exercise 26

% Given the downsampled signal defined in Ex25 with M = 4, 
% Create the signal x1 by upsampling the signal with a factor L = 4
% Given the decimated signal defined in Ex25 with M = 4,
% Create the signal x2 by interpolating the signal with a factor L = 4, 
% using a FIR filter with order 64.
% Open a figure and create three subplots:
% In first subplot, plot the stem of the original signal x(n) until N = 120 
% time samples, x-axis in seconds.
% In second subplot, plot the stem of the downsampled and decimated signals 
% with the same temporal duration as above
% In third subplot, plot the stem of x1 and x2 with the same temporal duration

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

%% x1: upsample the signal x_downsampled by a factor L = 4

L = 4;
x1 = zeros(1, length(x_downsampled) * L);
x1(1:L:end) = x_downsampled;

%% decimate the signal with a factor M 

lpf = fir1(64, 1/M);
% filtered signal
x_f = filter(lpf, 1, x);
% downsample the signal
x_decimated = x_f(1:M:end);

%% x2: interpolate the signal x_decimated by a factor L using a FIR filter with order 64.

x2 = zeros(1, length(x_decimated) * L);
x2(1:L:end) = x_decimated;

lpf = fir1(64, 1/L);
% remember to put the gain L in interpolation
x2 = L*filter(lpf, 1, x2);

%% plot the signals versus time

N = 200;

figure;
leg = {};

% original signal x(n)
subplot(3, 1, 1); % three rows, 1 column, subplot idx
stem(time(1:N), x(1:N));
leg{1} = 'Original signal';
legend(leg);
grid;

% downsampled and decimated signals
subplot(3, 1, 2);
leg = {};
% define the new time axis, considering that Fs is decreased by M
Fs_down = Fs/M;
% time axis goes from 0 until time(N)
time_down = 0:1/Fs_down:time(N);
% plot the signals
stem(time_down, x_downsampled(1:length(time_down)));
leg{1} = 'Downsampled signal';
hold on;
grid;
% decimated signal
stem(time_down, x_decimated(1:length(time_down)), '--*');
leg{2} = 'Decimated signal';
legend(leg);

% upsampled and interpolated signals
subplot(3, 1, 3)
leg = {};
% upsampled signal x1
stem(time(1:N), x1(1:N));
leg{1} = 'Upsampling the downsampled signal';
hold on,
grid;
% interpolated signal x2
stem(time(1:N), x2(1:N), '--*');
leg{2} = 'Interpolating the decimated signal';

xlabel('time');
legend(leg);

%% why is the signal delayed in time? which is the delay?

% by interpolating the decimated signal, we can exactly reconstruct 
% the sinusoid with frequency < min(pi/M, pi/L)
% NB: in the reconstruction, there is a delay introduced by the filter
% which cannot be centered in 0, as the filter must be causal. 
% the total delay results from the convolution between the FIR filter used
% in the decimation and the FIR filter used in the interpolation.
% conv(lpf, lpf) has a maximum in the 65-th sample.
% --> the signal delay is about 65 time samples
% to find the delay with MATLAB, use the function max.
% the second output of this function finds the index corresponding to the maximum value of
% the array.

figure(2); 
stem(conv(lpf, lpf));

[max_filter, filter_delay] = max(conv(lpf, lpf));
figure(1);
hold on; 
actual_signal = cos(2*pi*f_0 * (time(1:N) - time(filter_delay)));
stem(time(1:N), actual_signal);
leg{3} = 'Band-limited signal, f = f_0, delayed by 65 samples';
legend(leg);


%% Let us check the DFT of the signals

figure;
leg = {};

% original signal
% three rows, 1 column, subplot idx
subplot(3, 1, 1);
freq_axis = 0:1/N:(N-1)/N;
plot(freq_axis, abs(fft(x(1:N))));
leg{1} = 'Original signal';
legend(leg);
grid;

% downsampled and decimated signals
subplot(3, 1, 2);
leg = {};
% downsampled signal
freq_axis = 0:1/length(x_downsampled):1 - 1/length(x_downsampled);
plot(freq_axis, abs(fft(x_downsampled)));
leg{1} = 'Downsampled signal';
hold on;
% decimated signal
freq_axis = 0:1/length(x_decimated):1 - 1/length(x_decimated);
plot(freq_axis, abs(fft(x_decimated)), '--*');
leg{2} = 'Decimated signal';
legend(leg);
grid;

% upsampled and interpolated signals
subplot(3, 1, 3)
leg = {};
% upsampled signal x1
freq_axis = 0:1/N:(N-1)/N;
plot(freq_axis, abs(fft(x1(1:N))));
leg{1} = 'Upsampling the downsampled signal';
hold on,
% interpolated signal x2
freq_axis = 0:1/N:(N-1)/N;
plot(freq_axis, abs(fft(x2(1:N))), '--*');
leg{2} = 'Interpolating the decimated signal';
legend(leg);
grid;



