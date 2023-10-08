%% L'esercizio è uguale al laboratorio 5, qui abbiamo provato a farlo seguendo i punti UGUALE A QUELLO PRIMA 26/07/2021
%% Forse però era meglio farlo più simile al laboratorio 5
%% Punto 1   
Yy=imread('mandrill512color.tiff');
figure();
imagesc(Yy);
%% Punto 2
Y=double(Yy(:,:,1));
figure();
imagesc(Y);
%% Punto 3
N=4;
[h,k]=size(Y);
num_block=h/N*k/N;
Y_blocks=zeros(N,N,num_block);
Y_rec=zeros(size(Y));

for r=1:size(Y,1)/4
    for c=1:size(Y,1)/4
        block_r_index=(r-1)*N+1:r*N;
        block_c_index=(c-1)*N+1:c*N;
        Y_blocks(:,:,num_block)=Y(block_r_index,block_c_index);
    end
end

%% Punto 4
Y_blocks_mod=zeros(N,N,num_block);
for ii=1:num_block
    Y_blocks_mod(:,:,ii)=dct2(Y_blocks(:,:,ii));
end

%% Punto 5

%% Punto 6

%% Punto 7    forse era meglio fare tutto nel for
Y_blocks_mod=zeros(N,N,num_block);
for ii=1:num_block
    Y_blocks_mod(:,:,ii)=idct2(     (:,:,ii));
end    
