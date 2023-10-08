% Exercise 8

% 8.a
% Given a signal x(n) = [3, 2, 1, 0, 1], n in [-2, 2]
% Given a LTI system with h(n) = [1, 3, 2.5, 4, 2], n in [0, 4]
% Compute the output of the system using conv. Which is the support of y(n)?
% Exploiting the convolution theorem, compute Y(z) = X(z) H(z)
% Which is the order of polynomial H(z)?

close all
clearvars
clc

%% define signals

x = [3, 2, 1, 0, 1];
n_x = -2:2;

h = [1. 3. 2.5, 4, 2];
n_h = 0:4;

%% compute convolution using conv

y = conv(x, h); 

% support of y:
n_y = n_x(1) + n_h(1):n_x(end) + n_h(end);

%% expression of H(z)

H_z = h;   %I COEFFICIENTI DI h E DELLA SUA TRASFORMATA H SONO IDENTICI

%% Compute Y(z) exploiting the convolution theorem

% we can compute the convolution in time, then convert the expression in Z
% domain. The coefficients of Y(z) are the same as those of y(n)

%% order of the polynomial H(z)

order = n_h(end);   %n_h è la lunghezza del segnale h

%% roots of the filter

h_roots = roots(H_z);   %RICORDA QUESTO COMANDO --> secondo punto slide 13

%% compute y1 as the convolution of x(n) with the filter cascade.
% h(n)=h0*h1(n)*h2(n)*...*hk(n)   --->  uno dei 3 modi per calcolare h(n)
h_0 = h(n_h == 0);  %sarebbe H, ma h ha gli stessi 

% loop over the roots
for r = 1:length(h_roots)    %devo farlo per ogni radice + h_0
    
    % create the elementary sequence: its support is n = [0, 1]
    h_r = [1, -h_roots(r)];  %h_r è l'ultimo fattore che stiamo computando e ne rappresenta i suoi fattori: (1-z_n*z^-1)
                             %infatti ogni volta h_roots varia e si
                             %considera solo i coefficienti
    if r == 1
        h_cascade = h_r;        %h
        sup_cascade = [0, 1];   %supporto di h
    else
        % convolve by the cascade
        h_cascade = conv(h_r, h_cascade);   %convolve tutti quelli prima (h_cascade) con quello attuale h_r
        % new support of the cascade
        sup_cascade = sup_cascade(1) + 0:sup_cascade(end) + 1;
    end
       
end

% final cascade
h_cascade = h_0 * h_cascade;

y1 = conv(x, h_cascade);
sup_y = n_x(1) + sup_cascade(1):n_x(end) + sup_cascade(end);

%% plot the result

figure;
stem(n_y, y);
hold on
stem(sup_y, real(y1), '--');
grid



