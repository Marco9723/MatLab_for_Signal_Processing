clear all
clc
clear vars
%% Punto 1
img=imread('mandrill512color.tiff');
figure();
imagesc(img);
%% Punto 2
R=double(img(:,:,1));
figure();
imagesc(R);    %sono passato al 2020/09/03 perch� uguale, anzi pi� completo