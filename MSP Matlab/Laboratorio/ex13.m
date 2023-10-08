% Exercise 13

% Given y(n) = -2 y(n-1) -  y(n-2) + x(n) + 2rho cos(theta)x(n-1) +
% rho^2 x(n-2)
% rho = 0.9, theta = pi/8
% The sequence is defined for n in [0, 1e3].
% Which is the expression of h(n)? Compute it with 'filter'.
% Which is the amplitude of H(f)? Compute it with 'freqz' using
% N samples, for omega = [0, 2pi) 
% Plot the amplitude of H(f) as a function of omega.
% Compute and plot the DFT of h(n) using the matrix product.
% Are the two results equal? Comment on the results.
% Compute DFT of h(n) using 'fft' and check if results are equal.

close all
clearvars
clc

%% parameters

rho = 0.9;
theta = pi/8;

%% define H(z)

% denominator coefficients (from a_0 to a_D)
A_z = [1, 2, 1];
% numerator coefficients (from b_0 to b_N)
B_z = [1, 2*rho*cos(theta), rho^2];

%% h(n)

N = 1e3;
n = 0:N-1;
delta = zeros(size(n));
delta(1) = 1;
h = filter(B_z, A_z, delta);

%% amplitude of H(f) DTFT

[H_f_2pi, omega_2pi] = freqz(B_z, A_z, N, 'whole');

figure, 
% in order to better see the behaviour,you can use 'semilogy' instead of
% 'plot'   ---> NOTA BENE!!!
semilogy(omega_2pi, abs(H_f_2pi), 'linewidth', 2)
xlabel('\omega');
ylabel('|H(\omega)|');
set(gca, 'fontsize', 16);
grid

%% compute the DFT of h using matrix product (define also W as a matrix product)

% just with one code line 
W = exp(-1i * 2 * pi /N *n'*n); 
% W = exp(-1i * 2 * pi /N *n'.*n); % also this solution is valid
H_k = W * h';

%% plot between 0 (included) and 2pi (not included)

hold on;
semilogy(omega_2pi, abs(H_k), '--', 'linewidth', 2)

%% compute H_k using fft

H_fft = fft(h);
hold on;
semilogy(2*pi*n/N, abs((H_fft)),  '--o');

%% what would happen if A_z = 1? Try by yourself --> A_z = 1;

