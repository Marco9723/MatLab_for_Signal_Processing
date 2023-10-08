%% MMSP2 - Lab 2
%  Exercise 2 - Uniform and optimal quantizer

clearvars

close all
clc

%% 1) Generate a 10000-sample realization of s_g(n)~N(0,2) and s_u(n)~U with variance 2 and mean 0
%%    hint: use the functions randn() and rand()
var_s_g = 2;
var_s_u = 2;

s_g = randn(10000,1) * sqrt(var_s_g);    % Normal distribution

delta_u=sqrt(var_s_u*12);
s_u=rand(10000,1)*delta_u-delta_u/2

%% 2) Quantize s_g(n) and s_u(n) with M=[4,8,16,32,64,128] levels and uniform
%%    quantizer. Plot R-D curve for each number of levels. Compare with the
%%    theoretical distortion for a uniform scalar quantizer considering a uniform
%%    distributed signal
%%    hint: use MSE as distortion metric and plot the SNR
M=[4,8,16,32,64,128];

max_s_g=max(s_g);
min_s_g=min(s_g);

max_s_u=max(s_u);
min_s_u=min(s_u);

mse_u=zeros(length(M),1);
mse_g=zeros(length(M),1);

for m=1:length(M)
    delta_g = (max_s_g-min_s_g) / M(m);
    delta_u = (max_s_u-min_s_u) / M(m);
    
    y_u=floor(s_u/delta_u)*delta_u+delta_u/2;
    y_g = floor(s_g/delta_g)*delta_g + delta_g/2
    
    y_g_vals = unique(y_g);
    y_g(y_g == y_g_vals(end)) = y_g_vals(end-1);
    y_u_vals = unique(y_u);
    y_u(y_u == y_u_vals(end)) = y_u_vals(end-1);
    
    e_g=y_g-s_g;
    e_u=y_u-s_u;
    
    mse_g(m)=mean(e_g.^2);
    mse_u(m)=mean(e_u.^2)  
end
R=log2(M);
snr_g=pow2db(var(s_g)./mse_g);
snr_u=pow2db(var(s_u)./mse_u);

%% 3) Design an optimum uniform quantizer and a Lloyd-Max quantizer for s_g(n)
%%    with the same levels defined in the previous step. 
%%    Compare the R-D curves obtained with those quantizers
%%    with those obtained with uniform quantizer
mse_g_uo=zeros(length(M),1);
mse_g_lm=zeros(length(M),1);
for m=1:length(M)
%Optimum
delta_uo=(max(s_g)-min(s_g))/M(m);
th_uo = [ -inf ...
        delta_uo * ((1:(M(m)-1)) - floor(M(m)/2)) ...   
        inf];
    
       s_g_uo = zeros(size(s_g));
    for level = 1:M(m)
        mask = s_g >= th_uo(level) &  s_g < th_uo(level+1);
        s_g_uo(mask) = mean(s_g(mask));
    end
    e_g_uo = s_g_uo-s_g;
    mse_g_uo(m) = mean(e_g_uo.^2);

%Lloyd_Max



end



