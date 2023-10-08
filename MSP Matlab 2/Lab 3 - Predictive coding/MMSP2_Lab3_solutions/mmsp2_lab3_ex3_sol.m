clearvars
close all
clc

%% Load the audio file

[x, Fs] = audioread('ns.wav');


%% Quantize it using PCM with 1:8 bit, using floor, ceil and round in the quantizer.
%% Compute the SNR.
R = 1:8;

max_x = max(x);
min_x = min(x);

MSE_f = zeros(length(R),1);
MSE_c = zeros(length(R),1);
MSE_r = zeros(length(R),1);

for ii = 1:length(R)
    
    % Determine delta
    delta = (max_x-min_x)/(2^R(ii));
    
    % Quantize x
    x_f = delta * floor(x/delta) + delta/2;
    x_c = delta * ceil(x/delta) + delta/2;
    x_r = delta * round(x/delta) + delta/2;
    
    % Compute MSE_pcm
    MSE_f(ii) = mean((x-x_f).^2);
    MSE_c(ii) = mean((x-x_c).^2);
    MSE_r(ii) = mean((x-x_r).^2);
    
end
SNR_f = pow2db(var(x)./MSE_f);
SNR_c = pow2db(var(x)./MSE_c);
SNR_r = pow2db(var(x)./MSE_r);

%% Plot the SNR for the different method. What's wrong?
figure
plot(R,SNR_f, R, SNR_c, R, SNR_r, 'linewidth', 2);
legend('Floor','Ceil','Round');
grid on;
xlabel('Rate [bit/symbol]');
ylabel('SNR [dB]');
set(gca, 'fontsize', 18);