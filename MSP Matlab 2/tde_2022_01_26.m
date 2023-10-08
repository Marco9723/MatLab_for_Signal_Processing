%% Punto 1
rho=0.99;
N=1000;
d_std=2;
w=randn(N,1)*d_std;
xx=filter(1,[1 -rho],w);
figure()
plot(xx);
%% Punto 2
xx(xx<-15)=-15;
xx(xx>15)=15;
x=round(xx);
figure();
plot(x);
%% Punto 3  ENCODING
NN=2;
x_zm=x-mean(x);
X_zm=reshape(x_zm,NN,length(x_zm)/NN);
RR=zeros(N,N,size(X_zm,2));
for ii=1:size(X_zm)
   RR(:,:,ii)=X_zm(:,ii)*X_zm(:,ii)'; 
end
RR_mean=mean(RR,3);
[V,~] = eig(RR_mean);
T_klt=V';

%% Punto 4
coeff=T_klt*X_zm;

%% Punto 5
coeff_q=round(coeff);

%% Punto 6  DECODING
x_blocks_rec=T_klt'*coeff_q+mean(x);   %vd mean
x_rec=x_blocks_rec(:);

%% Punto 7
MSE=mean((x-x_rec).^2);

