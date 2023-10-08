% Exercise 7 

% Given x(n) = [3, 11, 7, 0, -1, 4, 2] , n in [-3, 3]
% Create y(n) = x(n - 5), n in [0, 10], without using circshift or for loops.
% Create y(n)= 1/3 sum[m = 0, 1, 2] x(n-m)
% Hint: y(n) has the form of a convolution...

close all
clearvars
clc

%% define x(n)

x = [3, 11, 7, 0, -1, 4, 2]; 
n_x = [-3:3];

%% y(n) = x(n-5)

% define the signal delta_5 which is delta(n-5) --> it is 1 only in n = 5
% and 0 everywhere
n_h = 0:10;    %la lunghezza sembra essere scelta a caso? basta che y sia definita come da consegna tra 0 e 10
delta_5 = zeros(size(n_h));
delta_5(6) = 1;

% support of the convolution:
n_conv = n_x(1) + n_h(1) : n_x(end) + n_h(end);   %sommo e trovo i supporti

y = conv(delta_5, x);   %perchè è la convoluzione del segnale con il delta, sposta il segnale di 5

% we wanted y defined only for n = 0:10 
y = y(n_conv>=0 & n_conv <= 10);

figure;
stem(n_x, x);
hold on;
stem(0:10, y);
legend('x(n)', 'x(n-5)');
set(gca, 'fontsize', 18);
grid;

%% y(n) = sum...

% define the filter, which is 1/3 (delta(n) + delta(n-1) + delta(n-2))   DI
% FATTO E' UNA MOVING AVERAGE
n_h = 0:10;
h = zeros(size(n_h));
h(1:3) = 1/3; 

% support of the convolution:
n_conv = n_x(1) + n_h(1): n_x(end) + n_h(end);

y = conv(x, h);

% we wanted y defined only for n = 0:10 
y = y(n_conv>=0 & n_conv <= 10);

figure;
ll = {};
stem(n_x, x);
ll{1} = 'x(n)';
hold on;
stem(0:10, y);
ll{2} = 'Moving-average filtered signal';
legend(ll, 'fontsize', 14);
grid;
