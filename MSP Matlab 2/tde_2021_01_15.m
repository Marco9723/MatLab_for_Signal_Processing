Y=imread('mandrill512color.tiff');
figure();
imagesc(Y);
%% Punto 2
R=double(Y(:,:,1));
G=double(Y(:,:,2));
B=double(Y(:,:,3));

R=R(:);
G=G(:);
B=B(:);

alphabet = 0:255;
d_R = hist(R, alphabet);
d_G = hist(G, alphabet);
d_B = hist(B, alphabet);
p_R = d_R/sum(d_R);
p_G = d_G/sum(d_G);
p_B = d_B/sum(d_B);

figure()
colors = {'red','green','blue'};
bar(alphabet,p_R,'red','FaceAlpha',0.7);
hold on;
bar(alphabet,p_G,'green','FaceAlpha',0.7);
bar(alphabet,p_B,'blue','FaceAlpha',0.7);
grid('on');

%%Compute the entropy of each channel

H_R = -sum(p_R(d_R > 0) .* log2(p_R(d_R > 0)));
H_G = -sum(p_G(d_G > 0) .* log2(p_G(d_G > 0)));
H_B = -sum(p_B(d_B > 0) .* log2(p_B(d_B > 0)));

disp(['H Red channel = ', num2str(H_R)]);
disp(['H Green channel = ', num2str(H_G)]);
disp(['H Blue channel = ', num2str(H_B)]);

%% punto 4
T=[0.299 0.587 0.114; -0.169 -0.331 0.5; 0.5 -0.419 -0.0813];
Y=zeros(length(R),1);
Cr=zeros(length(R),1);
Cb=zeros(length(R),1);
for ii=1:size(R);
RGB=[R(ii); G(ii); B(ii)];
YCrCb=T*RGB;
Y(ii)=YCrCb(1,1);
Cr(ii)=YCrCb(2,1);
Cb(ii)=YCrCb(3,1);
end
%% punto (e) vd lab 4, molto simile