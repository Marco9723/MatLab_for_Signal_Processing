% Exercise 4

close all 
clearvars
clc

% Generate the signal x(n) = (0.8)^n u(n), n = 1:20
% Generate the signal y1(n) = x(n-5),  n = 1:20
% Generate the signal y2(n) = x(n+5), n = 1:20

%% generate the signal x(n)

n = 1:20;
% NB: you have to put .^
x = (.8).^n;

%% shift the signal

% initialize the two signals   NOTA BENE, INIZIALIZZARE!!

y1 = zeros(size(x));
y2 = zeros(size(x));

% loop over the possible values of n

for i_n = 1:20
    
    if i_n >= 6
        y1(i_n) = x(i_n - 5);
    end
    
    if i_n <= 15
        y2(i_n) = x(i_n + 5);
    end    
    
end

%% you can use also 'circshift' but be careful to introduce zeros

% For details, see: https://it.mathworks.com/help/matlab/ref/circshift.html
y1_c = circshift(x, 5);   %IN PRATICA SPOSTO IL SEGNALE (+5, A DX) E METTO A ZERO QUELLO CHE NON SERVE
y1_c(1:5) = 0;            %A DIR LA VERITà LO SI FA X UN ERRORE CHE SI GENERA, VEDI APPUNTI

y2_c = circshift(x, -5);  %(-5 A DX)
y2_c(end-5:end) = 0;    %OVVIO

%% plot the signals

ll = {}; % used to define a legend
figure;
stem(x)
ll{1} = 'x(n)';
hold on, 
stem(y1)
ll{2} = 'x(n - 5)';
hold on, 
stem(y2)
ll{3} = 'x(n + 5)';
l = legend(ll, 'fontsize', 14);
grid

ll = {};
figure;
stem(x);
ll{1} = 'x(n)';
hold on,
stem(y1_c); 
ll{2} = 'x(n-5) with circshift';
hold on,
stem(y2_c); 
ll{3} = 'x(n+5) with circshift';
l = legend(ll, 'fontsize', 14);
grid




























