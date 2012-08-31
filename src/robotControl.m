function [ RCFlag ] = robotControl( LeftOmega, RightOmega )
import mbed.*;
%ROBOTCONTROL Used to control 3mpi robot
%   this uses mbed library provided online

% Set up mbed object
Mbed = mbedSerial('COM5', 9600);
PwmLeft = PwmOut(Mbed, p22); % Power controller for left wheel
PwmRight = PwmOut(Mbed, p23); % Power controller for right wheel



end

