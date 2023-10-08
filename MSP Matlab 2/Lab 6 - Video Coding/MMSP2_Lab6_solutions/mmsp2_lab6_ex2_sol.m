%% MMSP2 - Lab 6
%  Exercise 2 - ME and MC

clear
close all
clc

%% 1) Load the sequence 'table_tennis.mat' and spatially resize it at half the resolution (hint: use imresize())
load table_tennis.mat

table_tennis = imresize(table_tennis,0.5);

%% 2) Compute the displaced frame difference - use 8x8 blocks, full-search, W=16, save all motion vectors and visualize them (use quiver())

[h,w,nf] = size(table_tennis);
N = 8;
W = 16;
mv = zeros(h/N,w/N,2);
pred_frame = zeros(h,w);
% loop over all blocks
for r = 1:h/N
    for c = 1:w/N
        % select a block
        y0 = (r-1)*N+1;
        x0 = (c-1)*N+1;
        block = table_tennis(y0:y0+N-1,x0:x0+N-1,2);
        % build cost-function
        sad = zeros(2*W+1,2*W+1);
        for dy = -W:W
            for dx = -W:W
                y1 = y0+dy;
                x1 = x0+dx;
                
                if (y1 < 1 || x1 < 1 || y1+N-1 > h || x1+N-1 > w)
                    sad(dy+W+1,dx+W+1) = +inf;
                else
                    pred_block = table_tennis(y1:y1+N-1,x1:x1+N-1,1);
                    sad_block = sum(abs(pred_block(:)-block(:)));
                    sad(dy+W+1,dx+W+1) = sad_block;
                end
            end
        end
        % find minimum
        [~,min_idx] = min(sad(:));
        [y1_idx,x1_idx] = ind2sub(size(sad),min_idx);
        y_mv = y1_idx-W-1;
        x_mv = x1_idx-W-1;
        % save motion vectors
        mv(r,c,:) = [y_mv,x_mv];
        % store predicted block into predicted frame
        pred_frame(y0:y0+N-1,x0:x0+N-1) = table_tennis(y0+y_mv:y0+y_mv+N-1,x0+x_mv:x0+x_mv+N-1,1);
        
    end
end

figure();
subplot(311);
imagesc(table_tennis(:,:,1),[0 255]);
title('frame 1');
colormap gray;
axis image;

subplot(312);
imagesc(table_tennis(:,:,2),[0 255]);
title('frame 2');
colormap gray;
axis image;

subplot(313);
imagesc(pred_frame,[0 255]);
title('frame 2 predicted by mv');
colormap gray;
axis image;

%% compute DFD
dfd = table_tennis(:,:,2) - pred_frame;

% display motion vector superimposed to the frame

figure();
imagesc(dfd,[-255 255]); colormap gray;
hold on;
x = N/2+1:N:w;
y = N/2+1:N:h;
quiver(x,y,mv(:,:,2),mv(:,:,1), 'LineWidth', 2);

%% 3) Compute mean and variance of DFD and normal frame difference
fd = table_tennis(:,:,2) - table_tennis(:,:,1);

mean_dfd = mean(dfd(:));
var_dfd = var(dfd(:));

mean_fd = mean(fd(:));
var_fd = var(fd(:));

fprintf('DFD mean: %.2f - var:%.2f\n',mean_dfd,var_dfd);
fprintf('FD mean: %.2f - var:%.2f\n',mean_fd,var_fd);

%% 4) Display DFD and frame difference 

figure();
subplot(1,2,1);
imagesc(dfd,[-255 255]); colormap gray; axis image;
title('DFD');

subplot(1,2,2);
imagesc(fd,[-255 255]); colormap gray; axis image;
title('FD');