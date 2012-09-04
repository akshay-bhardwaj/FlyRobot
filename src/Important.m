%Stimulus = dI/dt
VarX = SigmaX^2;
VarY = SigmaY^2;
Xc = Xc0 + (R1*Theta1 + R2*Theta2)/2;
Yc = Yc0 + d*(R2*Theta2 - R1*Theta1)/(2*R);
Stimulus = I0 * exp(-(X-Xc)^2 + (Y-Yc)^2)*((((X-Xc)/(2*VarX))*...
(R1*Omega1+R2*Omega2)) - ((Y-Yc)*D*(R1*Omega1 - R2*Omega2))/(2*R*VarY));
% We calculate stimulus for X = -inf to inf or depends on gabor function.
% But we take Y = 0; So we get a stimulus which is same size as gabor
% function. 



