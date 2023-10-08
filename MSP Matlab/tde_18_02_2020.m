%TDE 18/02/2020
ampl=1.3;
f0=50;
Ts=0.0005;
Fs=1/Ts;
dur=0.205;
time=0:Ts:dur;
%Define the period of the signal in time and number of samples
x=ampl*cos(2*pi*f0*time);
period_time=1/f0;
period_samples=period_time*Fs;
%select x multiplo del periodo
n_per=floor(length(x)/period_samples);
max_multiple=period_samples*n_per;
x_per=x(1:max_multiple);
%zero pad
x_pad=zeros(1,1500);
x_pad(1:length(x))=x;
%FFT
X_f=fft(x);
N_x=length(X_f);
freq_axis=0:Fs/N_x:Fs*(N_x-1)/N_x;
figure;
stem(freq_axis,abs(X_f));

X_f_per=fft(x_per);
N_x_per=length(X_f_per);
freq_axis=0:Fs/N_x_per:Fs*(N_x_per-1)/N_x_per;
figure;
stem(freq_axis,abs(X_f_per));

X_f_pad=fft(x_pad);
N_x_pad=length(X_f_pad);
freq_axis=0:Fs/N_x_pad:Fs*(N_x_pad-1)/N_x_pad;
figure;
stem(freq_axis,abs(X_f_pad));

%Crea anche questo segnale
f1_norm=0.3;
x1=ampl*cos(2*pi*f1_norm*Fs*time);
y=x+x1;
%downsampling
M=2;
y_down=y(1:M:end);
%decimation
lpf=fir1(64,1/M);
y_filtered=filter(lpf,1,y);
y_dec=y_filtered(1:M:end);
%FFT su 2048
N=2048;
Y_f=fft(y,N);
Y_f_down=fft(y_down,N);
Y_f_dec=fft(y_dec,N);

norm_freq_axis=0:1/N:(N-1)/N;

figure;
plot(norm_freq_axis,abs(Y_f))
hold on
plot(norm_freq_axis,abs(Y_f_down))
hold on
plot(norm_freq_axis,abs(Y_f_dec))






























