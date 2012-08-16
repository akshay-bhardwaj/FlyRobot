%     Extended Kalman Filter code in project Fly Robot Interface
%     Copyright (C) 2012  Akshay Bhardwaj (akshay.bhardwaj11@imperial.ac.uk)
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.



%   Parameters Definition
%   n:  Number of states
%   q:  Standered deveiation of process
%   r:  Standered deviation of measurement
%   Q:  Covariance of process
%   R:  Covariance of measurement

n = 3; 
q = 0.1;
r = 0.1;
Q = q*eye(n);
R = r^2;

f = @(x)[x(2); x(3); 0.05*x(1)*(x(2)+x(3))];
h = @(x)x(1);
s = [0;0;1];
x = s+q*randn(3,1); %initial state
P = eye(n); %initial state covariance
N =20;  %total dynamic steps
xV = zeros(n,N);    %estimate   % allocate memory
sV = zeros(n,N);    %actual;
zV = zeros(1,N);
for k = 1:N
        z = h(s) + r*randn; % measurements
        sV(:,k) = s;    % save actual state
        zV(k) = z;  %save measurment;
        [x, P] = ekf(f,x,P,h,z,Q,R);
        xV(:, k) = x;
        s = f(s) + q*randn(3,1);
end;

for k = 1:3
        subplot(3,1,k);
        plot(1:N, sV(k,:), '-', 1:N, xV(k,:), '--');
end;

        

        




