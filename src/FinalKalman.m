% x = [angle; velocity, accleration] all angular

%F = [1 1 0.5; 0 1 1; (pi*0.6)^2 0 0];
SampleRate = 20000;
F = [1 1 0.5; 0 1 1; -1/(SampleRate^2) 0 0];
%G = [; 1];
H = [1 1 1];
%Uk = 1;
% Xkgk = [3.9039;0.171;-3.9039*(pi*0.6)^2];

Xkgk = [3.9039;-0.171/SampleRate;0.3/(SampleRate^2)];
Qk = 0;
Pkgk = [1 1 1;1 1 1;1 1 1];
t = [1 2 1; 2 3 2; 1 2 1];
%Z = [100 99.5 98.0 95.5 92.0 88.5];
%Z = sr; %spike rate
temp_input = inp(110265: 120000);
temp_fire = sr(110265:120000);
Z = temp_fire;
Rk1 = 1;
predict_input = zeros(3, length(Z));
tempvar = [];
for t = 1: length(Z)
Zk1 = Z(t);
% State Prediction
%Xk1gk = F*Xkgk + G*Uk;

Xk1gk = F*Xkgk;
%disp(size(Xk1gk));

%Measurement Prediction
if Xkgk(2) > 0
    H = [0 3/Xkgk(2) 0];
else
    H = [0 -3/Xkgk(2) 0];
end
    
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

predict_input(:,t) = Xk1gk1;
Xkgk = Xk1gk1;
Pkgk = Pk1gk1;
disp(size(Pkgk));
end;