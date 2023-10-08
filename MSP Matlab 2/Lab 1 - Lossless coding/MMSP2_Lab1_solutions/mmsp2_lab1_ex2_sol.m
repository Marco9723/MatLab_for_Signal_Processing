%% MMSP2 - Lab 1
%  Exercise 2 - Image signal encoding

clearvars
close all
clc

%% 1) Load the image 'lena512color.tiff' and display the normalized histogram 
%%    for all (R,G,B) components
%%    hint: 'lena512color.tiff' is an 8-bit RGB image, better to convert into double
%%    hint: express the RGB components as vectors

im = imread('lena512color.tiff');
disp(['size(im): ' mat2str(size(im))]);

R = double(im(:,:,1));
G = double(im(:,:,2));
B = double(im(:,:,3));

R = R(:);
G = G(:);
B = B(:);

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

%% 2) Compute the entropy of each channel

H_R = -sum(p_R(d_R > 0) .* log2(p_R(d_R > 0)));
H_G = -sum(p_G(d_G > 0) .* log2(p_G(d_G > 0)));
H_B = -sum(p_B(d_B > 0) .* log2(p_B(d_B > 0)));

disp(['H Red channel = ', num2str(H_R)]);
disp(['H Green channel = ', num2str(H_G)]);
disp(['H Blue channel = ', num2str(H_B)]);

%% 3) Let X represent the source of the red channel and Y the source of the
%%    green channel. Compute and show p(X,Y).
%%    hint: use the function imagesc() to show p(X,Y)

d_joint = hist3([R G], {alphabet, alphabet});
disp(['size(d_joint): ' mat2str(size(d_joint))]);

p_joint = d_joint/sum(d_joint(:));

figure();
imagesc(db(p_joint)), axis xy;
title('p(X,Y)');
ylabel('X symbols');
xlabel('Y symbols');

%% 4) Compute and display the joint entropy H(X,Y) and verify that H(X,Y) ≤ H(X) + H(Y). 

H_joint = -sum(sum(p_joint(d_joint > 0) .* log2(p_joint(d_joint > 0))));
fprintf('joint entropy: %.3f bit/2 pixel <= %.3f bit/2 pixel\n',H_joint, H_R + H_G);


%% 5) Suppose to encode Y with H(Y) bits and transmit source N = aX+b-Y instead of X
%%    Compute the entropy of N and the conditional entropy H(X|Y)
% Compute coefficients a and b with LS

X = R;
Y = G;

coeff = [X ones(size(X,1),1)]\Y;
disp(['size(coeff): ' mat2str(size(coeff))]);

a = coeff(1);
b = coeff(2);

N = round(a*X+b-Y);

% Compute H(N)
alphabet = unique(N);
d_N = hist(N(:),alphabet);
p_N = d_N/sum(d_N);
H_N = -sum(p_N(d_N > 0) .* log2(p_N(d_N > 0)));
fprintf('entropy N: %.3f bit/pixel\n',H_N);

% Conditional entropy H(X|Y) = H(X,Y) - H(Y)
H_cond_X = H_joint - H_G;
fprintf('cond entropy X|Y: %.3f bit/pixel\n',H_cond_X);