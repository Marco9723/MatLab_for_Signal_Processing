% Exercise 21

% Write a MATLAB function allpass.m which has the form:
% [z_out, p_out, b_out, a_out] = allpass(b,a)
% Input: b, a = numerator and denominator of H(z)
% Output: z_out, p_out, b_out, a_out = zeros, poles, numerator, 
% denominator of the allpass transfer function related to H(z)
% Use the function allpass.m to compute the allpass transfer function related to the causal filter
% Plot the magnitude response of the filter vs normalized frequencies using N = 512 samples
% Is the filter stable? How do you expect the phase to behave?

close all
clearvars
clc

%% define filter

B1 = [1, 3];
A1 = [1, -.5];

%% allpass related filter

[z_ap, p_ap, B_ap, A_ap] = allpass(B1, A1);

%% Plot the amplitude of Hap(f) vs normalized frequencies using N = 512 samples

N = 512;
[Hap, omega] = freqz(B_ap, A_ap, N, 'whole');

figure;
plot(omega./(2*pi), abs(Hap));

%% stability check

% the system is stable if all the poles are inside the unitary circle:

% one way is to use the function 'all', in order to check that all the
% poles of the system are inside the unit circle. If the answer is true (=1),
% the system is stable

stability_check = all(abs(p_ap) < 1); 

% second way is to use the function 'any', in order to check if there is at
% least one pole which is outside the unit circle. If the answer is true (=1),
% we known there's one pole outside and the system is unstable. In order to
% check the stability, we can take the logical complement of this answer,
% so that stability check will return true if the function 'any' has
% returned false (=0). In MATLAB, logical complement is indicated by ~

% stability_check = ~any(abs(p_ap) > 1); 

%% phase behaviour

figure;
plot(omega./(2*pi), angle(Hap));
grid;

% a causal stable allpass system has always maximum phase
% zeros (they are the reciprocal complex conjugate of the poles)
% therefore the phase has jumps = 2*pi