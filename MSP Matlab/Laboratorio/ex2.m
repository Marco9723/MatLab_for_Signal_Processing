% Exercise 2

close all % close figures
clearvars % clear workspace
clc % clear command window

%%

% Build a signal x(n) as the sum of three different sinusoids 
% at the normalized angular frequencies omega_1=pi/5, 
% omega_2=pi/8, omega_3=pi/4. 
% The sampling period is T = 0.3 seconds, and 
% the signal is defined for 
% t in [0, 100] seconds. 

%% create the signal x(n)

T = .3;
end_duration = 100;
time = 0:T:end_duration;

% normalized omegas
omega_1_n = pi/5; 
omega_2_n = pi/8;
omega_3_n = pi/4;

% omegas        omega_n = omega * T , dove T è il Ts sampling time  PER
% DEFINIZIONE
%         anche f_n = f*T  alla fine omega è f * 2pi, una costante!!
omega_1 = omega_1_n / T;
omega_2 = omega_2_n / T;
omega_3 = omega_3_n / T;

x = cos(omega_1 * time) + cos(omega_2 * time) + cos(omega_3 * time); %STAI SOMMANDO IN OGNI SAMPLE

% you can work also with loops and matrices

Omega_n = [omega_1_n, omega_2_n, omega_3_n];

% S = zeros(length(Omega_n), length(time));
% for cnt_o = 1:length(Omega_n)
%     
% %     for cnt_t = 1:length(time)
% %         
% %         S(cnt_o, cnt_t) = cos(Omega_n(cnt_o)*time(cnt_t) /T);
% %         
% %     end
%         
%      S(cnt_o,:) = cos(Omega(cnt_o) * time / T);
%        
% end
% 
% x = sum(S, 1);

% Loop can be also totally avoided (transpose Omega and multiply by time)
% NB: only in this particular situation, element-wise product (.*) returns the
% same result as the matrix product (*) !!!

%S = cos(Omega_n'.*time./T);  VIENE UNA MATRICE, NON UNO SCALARE, CON LE
%VERE OMEGA
S = cos(Omega_n'*time./T);
x1 = sum(S, 1);  %vettore 1xN dove sommi i valori di ogni colonna (dove hai già fatto il coseno)

%% plot the signal as a function of time

figure;
plot(time, x);
xlabel('Seconds');
title('x(t=n*T)');
grid
set(gca, 'fontsize', 16)

%% compute the period of the sinusoids (seconds)

P_1 = 2*pi*T/omega_1_n;  %T/omega_n sarebbe 1/omega=1/(2*pi*f) VD CONVENZIONE SOPRA, 2*pi va via e rimane 1/f, il periodo
P_2 = 2*pi*T/omega_2_n;
P_3 = 2*pi*T/omega_3_n;

% If you work with matrices: NB: here you have to put ./ otherwise MATLAB reports an error.
% P = 2*pi*T ./ Omega_n;

%% compute the period of the sinusoids ((time?)samples)
%PER FARE IL MINIMO COMUNE MULTIPLO DEVI LAVORARE IN SAMPLES
P_1_samples = P_1 /T; % 10     %DEVI FAR SPARIRE L'UNITA' DI MISURA, E' UN NUMERO PURO
P_2_samples = P_2 /T; % 16
P_3_samples = P_3 /T; % 8

%% period of x = lcm among (10, 16, 8) = 2^4 * 5

P_x_samples = 2^4*5;
P_x = P_x_samples * T;




