%% MMSP2 - Lab 2
%  Exercise 1 - Basic scalar Quantization

clc
clearvars
close all

%% Generate 1000 samples with gaussian distribution and variance=3
rng(21);

x_var=3;
x=randn(1000,1)*sqrt(x_var);


%% Quantize with a scalar mid-rise quantizer with fixed quantization step delta=2
delta=2;
y1=floor(x/delta)*delta;
figure();
plot(x,y1,'.','markersize',12);
xlabel('in')
ylabel('out')
title('mid-rise')

%% Quantize with a scalar mid-tread quantizer with fixed quantization step delta=2
delta=2;
y2=delta*floor((x+delta/2)/delta);
figure();
plot(x,y2,'.','markersize',12);
xlabel('in')
ylabel('out')
title('mid-tread')

%% Quantize with a scalar mid-tread quantizer with M=4 output levels
M=4;
delta=(max(x)-min(x))/M;
y3=delta*floor((x+delta/2)/delta);

y3_values=unique(y3);
y3(y3==y3_values(end))=y3_values(end-1);

figure();
plot(x,y3,'.','markersize',12);
xlabel('in')
ylabel('out')
title('punto 3')


%% Quantize using cb = [-5,-3,-1,0,1,3,5] as reproduction levels
% and th = [-4,-2,-0.5,0.5,2,4] as thresholds
cb = [-5,-3,-1,0,1,3,5];
th = [-4,-2,-0.5,0.5,2,4];
th=[-inf, th, inf];
y4=zeroes(length(x));
for level=1:length(cb)
    mask=x >=th(level) & x<th(level+1);
    y4(mask)=cb(level);
end
figure();
plot(x,y4);
xlabel('in')
ylabel('out')

%% Power and var
e=y1-x;
Px=mean(x.^2);
Pe=mean(e.^2);
sig2x=var(x);
sig2e=var(e);

snr_p=Px/Pe;
snr_s=sig2x/sig2e;
%% Compute distortion using MSE for each one of the above quantizers   POI LEGGI



%% Compute SNR for each one of the above quantizers



