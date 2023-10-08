close all
clearvars
clc
%punto 2
a=[1, 0.8];
z_0=-4;
b=[1, -z_0];
[b_ap,a_ap]=find_allpass(b,a); %data, trasforma il filtro in all pass
zeroes=roots(b_ap);
poles=roots(a_ap);
zplane(b_ap,a_ap); %ricorda, si passano b e a
%punto 3
T=25;
f0=1/T;
N=120;
n=1:120; %samples in time
s=cos(2*pi*f0*n);
figure();
stem(n,s);
%punto 4
linear_conv=conv(s(1:period),b_ap);     %per la lineare puoi usare conv
linear_conv=linear_conv(1:period);    %ne prendi un periodo come richiesto

S=fft(s(1:period));          %per la circolare posso moltiplicare i segnali in freq se hanno lo stesso periodo
B_ap=fft(b_ap,period);
cyclic_conv=ifft(S.*B_ap);

figure;
stem(linear_conv)
hold on
stem(cyclic_conv)

%punto 5
s_f=filter(b_ap,a_ap,s);
S=fft(s);
S_f=fft(s_f);
freq_axis=0:1/N:(N-1)/N;
figure;
plot(freq_axis,abs(S));
hold on;
plotplot(freq_axis,abs(S_f)); 














