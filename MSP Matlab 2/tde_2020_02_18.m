N=1000;
x_u=100*rand(1,N);
x_g=50+100*randn(1,N);
%% Punto 1   ricontrolla
alphabet_u=unique(x_u);
alphabet_g=unique(x_g);
%alphabet_u=0:255;
%alphabet_g=0:255;
d_u=hist(x_u(:),alphabet_u);
d_g=hist(x_g(:),alphabet_g);
p_u=d_u/(sum(d_u));
p_g=d_g/(sum(d_g));
figure();
bar(alphabet_u,p_u);
figure();
bar(alphabet_g,p_g)
%% Punto 2
min_u=min(x_u)
min_g=min(x_g)
max_u=max(x_u)
max_g=max(x_g)
%% Punto 3
delta=[2,4,6,8,10];
mse_u=zeros(length(delta),1);
mse_g=zeros(length(delta),1);
H_u=zeros(length(delta),1);
H_g=zeros(length(delta),1);
for ii=1:length(delta);
    x_u_q=floor(x_u/delta)*delta;
    x_g_q=floor(x_g/delta)*delta;
    mse_u(ii)=((x_u-x_u_q).^2);
    mse_g(ii)=((x_g-x_g_q).^2);
    
    alphabet_u_q=unique(x_u_q);
    alphabet_g_q=unique(x_g_q);
    d_u_q=hist(x_u_q(:),alphabet_u_q);
    d_g_q=hist(x_g_q(:),alphabet_g_q);
    p_u_q=d_u_q/(sum(d_u_q));
    p_g_q=d_g_q/(sum(d_g_q));
    
    H_u(ii)=-sum( p_u_q(d_u_q>0).*log2(p_u_q(d_u_q>0)));
    H_g(ii)=-sum( p_g_q(d_g_q>0).*log2(p_g_q(d_g_q>0)));
   
end
    
