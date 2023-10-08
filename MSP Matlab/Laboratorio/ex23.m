% Exercise 23

% Given the filter with 
% B(z)=[1, -1.98, 1.77, -0.17, 0.21, 0.34], 
% A(z)=[1, 0.08, 0.40 ,0.27]
% Compute the allpass-minimum phase decomposition of H(z)
% Check the results using 'zplane'
% Plot the magnitude of Hap(omega) using N = 1024 samples
% Plot the first 50 samples of h_min(n)

close all
clearvars
clc

%% define filter

B = [1, -1.98, 1.77, -0.17, 0.21, 0.34];
A = [1, 0.08, 0.40 ,0.27];

%% all-pass minimum phase decomposition

% compute the zeroes and the poles
zeroes = roots(B);
poles = roots(A);

% The minimum phase system contains zeroes and poles inside the unit circle
% plus the conj reciprocal of zeros outside the unit circle
z_min = zeroes(abs(zeroes) <= 1);
p_min = poles(abs(poles) <=1);

% check if there are zeros outside the unit circle
if any(abs(zeroes) > 1)

    % allpass decomposition
    z_ap = zeroes(abs(zeroes) > 1);
    p_ap = 1./conj(z_ap);
    
    % include other zeros = p_ap in the minimum phase filter
    z_min = [z_min; p_ap];
    
    % define the polynomials related to the all pass filter
    B_ap = poly(z_ap);
    A_ap = poly(p_ap);
    
else
    
    % there are no zeros outside the unit circle
    % --> all pass filter will be just = 1
    B_ap = 1;
    A_ap = 1;
    
end

% define the polynomials related to the minimum phase filter
B_min = poly(z_min);
A_min = poly(p_min);

% multiply by c_0 if you want the amplitude of Hap(f) to be = 1
c_0 = sum(A_ap) / sum(B_ap);
B_ap = c_0 * B_ap;

% divide Hmin by c_0 
B_min = B_min /c_0;

%% check on zplane

figure;
zplane(B_min, A_min);

figure;
zplane(B_ap, A_ap);

%% amplitude of Hap vs normalized omega

N = 1024;
[Hap, omega] = freqz(B_ap, A_ap, N, 'whole');
figure, plot(omega, abs(Hap));

%% Plot the first 50 samples of h_min(n)

N = 50;
delta = zeros(1, N);
delta(1) = 1;
hmin = filter(B_min, A_min, delta);
figure, stem(hmin)

% minimum phase systems have always the energy concentrated in the first
% temporal samples
















     


