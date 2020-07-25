function tilt=rando_change(I)
I=edge(I);%figure,imshow(I);
% I = zeros(100,100);
% I(25:75, 25:75) = 1;
theta = 1:180;
[R,xp] = radon(I,theta);
%figure,imagesc(theta,xp,R);colormap(hot);%title('R_{\theta} (X\prime)')
[I,J] = find(R>=max(max(R)));
tilt=90-J;

% xlabel('\theta (degrees)');ylabel('X\prime');
% % colormap(hot)%     colorbar  IMAGE(C) displays matrix C as an image.
% title('R_{\theta} (X\prime)');
% colorbar;