% Exercise 5

close all
clearvars
clc

% Generate the signal x(n) = u(n-5) - u(n-10), 
% considering n = 1:15.
% Generate the periodic signal xp(n) with period N = 15, 
% considering n = 1:200.
% Hint: Consider using repmat instead of for loops.

%% define one period of the signal

N = 15; % period
n = 1:N;
x = zeros(1, N);
x(n>= 5 & n <10) = 1;  %NB

%% create the periodic signal

n_max = 200;

% how many signal periods until n_max?
% N_p is the nearest integer less than or equal to n_max/N
N_p = floor(n_max / N); 

% initialize the periodic signal until n_max samples:
x_p = zeros(1, n_max);

% create the periodic signal until N_p periods
% repmat(x, #repetitions on rows, #repetitions on columns)
% for details, see: https://it.mathworks.com/help/matlab/ref/repmat.html

x_p(1:N_p * N) = repmat(x, 1, N_p);   %COMANDO REPMAT DA RICORDARE!! ricorda bene questa riga in generale!!

% how many samples are remaining?
remaining_samples = n_max - N_p * N;

% fill x_p with the last remaining samples
x_p(N_p*N +1:end) = x(1:remaining_samples);

%% plot the signal considering only 8 periods

figure;
stem(x);
ll{1} = 'x(n)';
hold on;
stem(x_p(1: N*8), '--');
ll{2} = 'x_p(n)';
legend(ll, 'fontsize', 14);
