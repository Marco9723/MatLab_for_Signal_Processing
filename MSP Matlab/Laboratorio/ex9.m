% Exercise 9

% Given a LTI system with this transfer function: (see slides)
% Find its partial fract expansion: 
% Save in a vector r the residues
% Save in a vector p the poles
% Save in a vector c the coefficients of the remaining polynomial
% Find h(n) as the cascade of filters found with the partial fract 
% expansion.
% Find h(n) using filter

close all
clearvars
clc

%% define H(z)

% denominator coefficients (from a_0 to a_D)
A_z = [2, -1, -2, 1];
% numerator coefficients (from b_0 to b_N)
B_z = [9, 7, -8, -3, 1, 1];

%% find residues

[r, p, c] = residuez(B_z, A_z);    %RICORDA COMANDO --> residui, poli, coefficienti del polinomio finale
% NB: c is ordered from c_0 to c_(N-D).
% NB: each residue is associated to one pole.

%% find h(n) as the sum of elementary filters found with the partial fract exp.

n = 0:100;

h_partial = zeros(size(n)); 

% fill the first samples of the filter with the coefficients of vector c.
h_partial(1:length(c)) = c;

for r_i = 1:length(r)
    
    % elementary sequence associated with the residue
    h_el = r(r_i) * p(r_i).^n;
    
    % update h_partial
    h_partial = h_partial + h_el;   
    
end

figure,
stem(n, h_partial)


%% find h(n) using filter.

n = 0:100;

% h(n) is the IMPULSE response to the system --> x(n) must be a delta.
delta = zeros(1, length(n));
delta(1) = 1;
h = filter(B_z, A_z, delta);

hold on;
stem(n, h, '--');








