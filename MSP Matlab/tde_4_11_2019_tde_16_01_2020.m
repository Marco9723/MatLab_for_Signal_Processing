close all
clear
clc

%PUNTO 2  %L'ESERCIZIO E' MOLTO SIMILE AL 16/01/2020    (X2)
%Define B and A
B=[2, -2*sqrt(2), 2];
A=[1, -sqrt(2)/2, 0.25];

%Find h(0) --> è sempre B(1)/A(1)
h_0=B(1)/A(1);
zeroes=roots(B);
poles=roots(A);

%plot
figure;
zplane(B,A);

%stability
%stability=is_stable(B,A);

%PUNTO 3
ampl=1.5;
Fs=1600;
f0=200;
dur=1.3;
time=1:1/Fs:dur;
x=ampl*cos(2*pi*f0*time);
y=filter(B,A,x);
Yf=fft(y);
N_samples=length(y);
norm_freq_axis=0:1/N_samples:(N_samples-1)/N_samples;

figure()
plot(norm_freq_axis,abs(Yf))











