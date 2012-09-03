F = [1 1; 0 1];
G = [0.5; 1];
H = [1 0];
Uk = 1;
Xkgk = [100;0];
Qk = 0;
Pkgk = [10 0;0 1];
t = 0;
Z = [100 99.5 98.0 95.5 92.0 88.5];
Rk1 = 1;
X= zeros(2,6);
while (t<=5)
Zk1 = Z(t+1);
% State Prediction
Xk1gk = F*Xkgk + G*Uk;
%Measurement Prediction
Zk1gk = H*Xk1gk;
%Measurement Residual
Vk1 = Zk1 - Zk1gk;

%%%Cov
%State prediction covariance
Pk1gk = F*Pkgk*F' + Qk;
%Measurement prediction covariance
Sk1 = H*Pk1gk*H' + Rk1;
%Filter Gain
Wk1 = Pk1gk*H'/Sk1;
Pk1gk1 = Pk1gk - Wk1*Sk1*Wk1';

%%%Cov

Xk1gk1 = Xk1gk + Wk1*Vk1;

X(:,t+1) = Xk1gk1;
Xkgk = Xk1gk1;
Pkgk = Pk1gk1;
t=t+1;

end;
