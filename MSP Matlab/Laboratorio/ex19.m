% Exercise 19

% overlap and add and overlap and save methods. 
% Given x(n) = n + 1, n in [0, 20]
% h(n) is a FIR filter, h(n) = [1, 0, -1], n in [0, 2]
% Compute the linear convolution between x and h
% Compute the same result with the overlap and add method, using L = 6.
% Compute the same result with the overlap and save method, using L = 6.

close all
clearvars
clc

%% define signals

n_x = 0:20;
x = n_x + 1;
h = [1, 0, -1];
n_h = 0:2;

%% linear convolution

y = conv(x, h);
n_y = n_x(1) + n_h(1) : n_x(end) + n_h(end);

figure, stem(n_y, y);

%% overlap and add method

L = 6;
Lconv = L + length(h) - 1;

% fft of the filter over Lconv samples
filter_f = fft(h, Lconv);

% auxiliary variable
x_aux = x;

% index for the blocks
b = 1;

while true
    
    % select the signal block
    x_block = x_aux(1:L);    
    
    % fft of the signal block over Lconv samples
    X_block = fft(x_block, Lconv);
    
    % result of the cyclic conv over Lconv samples
    y_block = ifft(X_block .* filter_f);
    
    if b == 1
        y_oa = y_block;
    else
        % if the block is not the first one, add L zeros at the end of
        % the signal y_oa to contain the new samples related to the block
        y_oa = padarray(y_oa, [0, L], 'post');
        
        % put the result in the right position
        y_oa(1 + (b-1)*L:end) = y_oa(1 + (b-1)*L:end) + y_block;
    end
    
    % update blocks
    b = b + 1;
    
    % delete the already processed block
    x_aux = x_aux(L+1:end);
    
    % if the number of remaining samples is less than the block size, stop
    if length(x_aux) < L
        break
    end
    
end

% consider the last block of the signal (operations to be done are the same
% as in the while loop)
x_block = x_aux;
X_block = fft(x_block, Lconv);
y_block = ifft(X_block .* filter_f);
y_oa = padarray(y_oa, [0, L], 'post');
y_oa(1 + (b-1)*L:end) = y_oa(1 + (b-1)*L:end) + y_block; 

% delete the final zeroes
y_oa = y_oa(1:length(x) + length(h) -1);

hold on;
stem(n_y, y_oa, '--');

%% overlap and save method.

L = 6;
% number of wrong samples due to the cyclic conv = overlap size. 
overlap = length(h) - 1;

% initialize the output signal (this will be the concatenation of the
% results related to each block, without overlap)
y_os = [];

% fft of the filter over L samples
filter_f = fft(h, L);

% auxiliary variable
x_aux = x;

% add P - 1 zeros at the beginning
x_aux = padarray(x_aux, [0, overlap], 'pre');

% index for the blocks
b = 1;

while true
    
    % select the signal block
    x_block = x_aux(1:L);    
    
    % fft of the signal block over L samples
    X_block = fft(x_block, L);
    
    % result of the cyclic conv over L samples
    y_block = ifft(X_block .* filter_f);
    
    % delete the first P - 1 samples
    y_block = y_block(overlap + 1:end);
    
    % concatenate the result
    y_os = [y_os, y_block];
    
    % update blocks
    b = b + 1;
    
    % delete the already processed block, but take the next one with an
    % overlap = P - 1 samples
    x_aux = x_aux(L + 1 - overlap:end);
    
    % if the number of remaining samples is less than the block size, stop
    if length(x_aux) < L
        break
    end    
    
end

% consider the last block of the signal (operations to be done are the same
% as in the while loop)
x_block = x_aux;
X_block = fft(x_block, L);
y_block = ifft(X_block .* filter_f);
y_block = y_block(overlap + 1:end);
y_os = [y_os, y_block];

% delete the final zeroes
y_os = y_os(1:length(x) + length(h) -1);

hold on, 
stem(n_y, y_os, '-.o')

