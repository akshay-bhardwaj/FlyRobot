function [ RCFlag ] = robotControl( LeftOmega, RightOmega, Fs, Duration )
import mbed.*;
%ROBOTCONTROL Used to control 3mpi robot
%   this uses mbed library provided online

% Set up mbed object
Mbed = mbedSerial('COM5', 9600);
PwmLeft = PwmOut(Mbed, p22); % Power controller for left wheel
PwmRight = PwmOut(Mbed, p23); % Power controller for right wheel
Vmin = 0;
Vmax = 1;
OmegaMin = 0;
OmegaMax = 0.2;
LeftVoltage = Vmin+((Vmax*Vmin)/(OmegaMax-OmegaMin)).*(LeftOmega-OmegaMin);
RightVoltage = Vmin+((Vmax*Vmin)/(OmegaMax-OmegaMin)).*(RightOmega-OmegaMin);
LengthVoltage = Fs*Duration;
PausePeriod = 1/Fs; %Used to delay between two power steps.
for i = 1:LengthVoltage
    PwmLeft.write(LeftVoltage);
    PwmRight.write(RightVoltage);
    PwmLeft.period(PausePeriod);
    PwmRight.period(PausePeriod);
end

RCFlag =0;
end
