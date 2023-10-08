% Exercise 12

% Given H(z) = 1 - 0.8 z^-1
% Compute its frequency response using N = 100 points and plot
% one period (omega in [-pi, pi))
% Which are the zeros and poles?
% How does the phase behave?
% Try also H(z) = 1 - z^-1, H(z) = 1 + z^-1, H(z) = 1 - 3z^-1
% In which cases are zeros minimum-phase?
% When are zeros maximum-phase?
% Write a function to state if a zero is minimum or maximum
% phase.

close all
clearvars
clc

%% define H(z)

% denominator coefficients (from a_0 to a_D)
A_z = 1;
% numerator coefficients (from b_0 to b_N)
B_z = [1, -3];

%% H(f)

N = 100;

[H_omega_2pi, omega_2pi] = freqz(B_z,A_z, N, 'whole');

figure,
% shift the x-axis by pi, in order to visualize the fft spectrum from [-pi,
% pi)
% shift also the fft spectrum around omega = 0, by using the function
% fftshift. For details, see: https://www.mathworks.com/help/matlab/ref/fftshift.html
plot(omega_2pi - pi, fftshift(abs(H_omega_2pi)));
xlabel('\omega');
title('amplitude');
grid
set(gca, 'fontsize', 18);

figure,
plot(omega_2pi - pi, fftshift(angle(H_omega_2pi)));
xlabel('\omega');
title('Phase');
grid
set(gca, 'fontsize', 18);

%% plot zeros and poles

figure;
% Be careful! If you first try computing the poles just giving 
% A_z to function 'roots', you will be wrong! There is one pole in z = 0
zplane(B_z, A_z);

%% function minmax phase

zero_Bz = roots(B_z);
is_minmax_phase(zero_Bz);

function [] = is_minmax_phase(zero)

if zero >= 1
    disp('Maximum phase');
elseif zero >0 && zero < 1
    disp('Minimum phase');
else
    disp('The zero is negative');
end
    
end























