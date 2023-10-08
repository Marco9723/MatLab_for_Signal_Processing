% Exercise 6

% Given x(n) = [3, 11, 7, 0, -1, 4, 2] , n in [-3, 3]
% Given h(n) = [2, 3, 0, -5, 2, 1], n in [-1, 4]
% Compute y(n) as x(n) convolved with h(n), n in  [-7, 7]. 

close all
clearvars
clc

%% signals

% let us define the signals in the same n-domain. --> put zeros where
% signals are not defined.
% ALLA FINE STA SCRIVENDO I DATI DEL TESTO
n_x = -3:3;
n_h = -1:4;
x = [0, 0, 0, 0, 3, 11, 7, 0, -1, 4, 2, 0, 0, 0, 0];
h = [0, 0, 0, 0, 0, 0, 2, 3, 0, -5, 2, 1, 0, 0, 0];
n = -7:7;

%% convolution

% fold h --> h(k) --> h(-k) (with respect to 0)
% For details, see: https://it.mathworks.com/help/matlab/ref/fliplr.html
h_fold = fliplr(h);  %PER FLIPPARE IL SEGNALE COME DA CONVOLUZIONE h(-k)

% initialize the final signal y
y = zeros(size(n));

% loop over all possible n-values
cnt = 1; % this counter is useful to fill the output vector y
for n_aux = n
    
    
    % shift h_fold by n_aux

    h_shifted = circshift(h_fold, n_aux);
    if n_aux > 0
        h_shifted(1:n_aux) = 0;
    else
        h_shifted(end + n_aux :end) = 0;    
    end  
    
    % scalar product between x and h_shifted
    y(cnt) = x*h_shifted';
    
    % increase the bin counter for y
    cnt = cnt + 1;
    
end

figure;
stem(n, y)
title('y(n) without using conv');
grid;

%% use the matlab function 'conv'    ALLA FINE NELLA PRATICA SI USA IL COMANDO CONV E SI CALCOLA IL SUPPORTO PER PLOTTARE

% default:'full' convolution, with length = length(x) + length(h) - 1 
y1 = conv(x, h);
supp_full = n(1) + n(1):n(end) + n(end);

figure;
stem(supp_full, y1);
title('y(n) using full conv');
grid;

%% which is the actual support of y1?

% we should check the actual supports of
% the signals x(n) and h(n)

supp_true = n_x(1) + n_h(1):n_x(end) + n_h(end);

% if we define the signals without the zeroes (i.e., in their real supports)

x_reduced = [3, 11, 7, 0, -1, 4, 2];     %PERCHE' PER CONSEGNA ABBIAMO FATTO DA -7 A 7
h_reduced = [2, 3, 0, -5, 2, 1];         %MA I SEGNALI SONO PIU' BREVI, INFATTI VA DA -4 A 7 COME CI ASPETTAVAMO SOMMANDO GLI ESTREMI

y_reduced = conv(x_reduced, h_reduced);

figure; 
stem(supp_true, y_reduced)
title('y(n) inside the true support');
grid;
