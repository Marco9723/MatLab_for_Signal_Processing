% Exercise 11

% Given y(n) = 0.5 x(n) - 2x(n-1) + x(n-2) -2 rho cos (theta) y(n-1) - rho^2 y(n-2) 
% rho = 0.9, theta = pi/8
%    
% Which is the expression of H(z)?
% h(0)?
% h(n)?
% Compute its zeros and poles.
% Plot its zeros and poles.

close all
clearvars
clc

%% parameters

rho = 0.9;
theta = pi/8;

%% define H(z)

% denominator coefficients (from a_0 to a_D)
A_z = [1, 2*rho*cos(theta), rho^2];
% numerator coefficients (from b_0 to b_N)
B_z = [0.5, -2, 1];

%% h(0)

h_0 = B_z(1);

%% h(n)

n = 0:200;
delta = zeros(size(n));
delta(1) = 1;
h_filter = filter(B_z, A_z, delta);

%% zeros and poles

zeroes = roots(B_z);
poles = roots(A_z);

%% plot zeros and poles

figure; 
zplane(B_z, A_z);
grid



