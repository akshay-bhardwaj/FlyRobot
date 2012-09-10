Sigma = 10;
ImageSize = [256 256];
dd = 2/370;
xc = 1;
Theta1 = [0 0.1];
Theta2 = [0.11 0];
nof = 370;
%leng = log2(20*nof) + 1;
% for i = 1:(nof*10)
%    Theta1 = [Theta1 [0 0.1]];
% end
% for i = 1:(nof*20)
%    Theta2 = [Theta2 [0.1 0]];
% end

%h = fspecial('gaussian',ImageSize,Sigma);
%nof = 360*10; % nof = 370 * time;
nof = 40;
h = fspecial('gaussian',ImageSize,Sigma);
colormap(gray(256));
for j = 1:nof
   h = fspecial('gaussian',ImageSize,Sigma);
   imagesc(h);
   F(j) = getframe;
   Sigma = Sigma +(1);
   %h = h.*((xc-dd)*(Theta1(j)+Theta2(j))/(2*Sigma));
end
movie(F,100,370)


