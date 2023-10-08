%% MMSP2 - Lab 3
%  Exercise 1 - Predictive coding

clear
close all
clc


%% 1) Generate 10000 samples of the random process
%%    x(n) = rho*x(n-1) + z(n), where rho=0.95 and z(n)~N(0,0.1)
rng(21);

N = 10000;
rho = 0.95;
z_var = 0.1;
z = randn(N,1) * sqrt(z_var);
x = filter(1,[1 -rho], z);


%% 2) Build a PCM codec. Quantize the signal with a uniform quantizer and
%%    R bits. Compute the R-D curve for R=1,2,...,8 bits (in terms of SNR)
R=1:8;
max_x=max(x);
min_x=min(x);
MSE_pcm=zeros(length(R),1);
for ii=1:length(R)
    delta=(max_x-min_x)/(2^R(ii));
    x_q=delta*floor(x/delta)+delta/2;
    %x_q_val=unique(x_q);
    %x_q(x_q==x_q_val(end))=x_q_val(end-1);
    MSE_pcm(ii)=mean((x-x_q).^2);
end
SNR=pow2db(var(x)./MSE_pcm);

%% 3) Build a predictive codec in open loop. Use the optimal MMSE predictor.
%%    Use PCM to initialize the codec
d=[NaN,z(2:N)];
max_d=max(d);
min_d=min(d);
MSE_olpc=zeros(length(R,1);
for ii=1:length(R)
    x_tilde=zeros(N,1);
    %PCM
    delta_pcm=(max_x-min_x)/(2^R(ii));
    x_tilde(1)=delta_pcm*floor(x(1)/delta_pcm)+delta_pcm/2
    %OLPC
    delta_olpc=(max_d-min_d)/(2^R(ii));
    d_tilde=delta_olpc*floor(d/delta_olpc)+delta_olpc/2;
    for nn=2:N
    x_tilde(nn)=d_tilde(nn)+rho*x_tilde(nn-1);
    end
    MSE_olpc(ii)=mean((x-x_tilde).^2);
end
SNR_olpc=pow2db(var(x)./MSE_olpc);

%% 4) Build a DPCM codec. Use the optimal MMSE predictor.
%%    Use PCM to initialize the codec.
R=1:8;
max_x=max(x);
min_x=min(x);
MSE_dpcm=zeros(length(R),1);
for ii=1:length(R)
    x_tilde=zeros(N,1);
    %PCM
    delta_pcm=(max_x-min_x)/(2^R(ii));
    x_tilde(1)=delta_pcm*floor(x(1)/delta_pcm)+delta_pcm/2
    %DPCM
    delta_dpcm=(max_d-min_d)/(2^R(ii));
    for nn=2:n
        x_hat = rho*x_tilde(nn-1);
        d = x(nn) - x_hat;
        d_tilde = delta_dpcm * floor(d/delta_dpcm) + delta_dpcm/2;
        x_tilde(nn) = d_tilde + x_hat;
    end
    
    MSE_dpcm(ii)=mean(().^2)
end
SNR_dpcm=pow2db(var(x)./MSE_dpcm);



















