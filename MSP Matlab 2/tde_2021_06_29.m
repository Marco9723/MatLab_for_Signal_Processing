Y=imread('mandrill512color.tiff');
figure();
imagesc(Y);
%% Punto 2
R=double(Y(:,:,1));
G=double(Y(:,:,2));
B=double(Y(:,:,3));
YY=-0.0813*B;
figure();
imagesc(YY);
%% Punto 3
B=[2,3,4,5,6,7,8];
YY=YY(:);
MSE=zeros(length(B));
PSNR=zeros(length(B));
H=zeros(length(B));
for ii=1:length(B)
    M=2^B(ii);
    delta=(max(YY)-min(YY))/M;
    Y_q=floor(YY/delta)*delta;
    MSE(ii)=mean((YY-Yq).^2);
    PSNR=pow2deb(var(YY)./MSE(ii));
    alphabet=unique(Y_q);
    d=hist(YY,alphabet);
    p=d/sum(d);
    H(ii)=-sum(p(d>0).*log2(p(d>0)));
end

    