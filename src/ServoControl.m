import mbed.*
% Define Servo motor variables
MaxRange = 80;
MaxServoAngle = 150;
READINGS = 81;
Angles = zeros((READING+1), 1);
Range = zeros((READINGS+1), 1);
plotPoints = zeros((READING+1), 2);
n =1;
p =1;

% Set up communication to mbed
MyMbed = SerialRPC('COM7', 9600);
MyMbed.reset();
pause (0.5);
ThetaServo = PwmOut(MyMbed, p21); % Check for the correct port
PhiServo = PwmOut(MyMbed, p22); % Check for the correct port
StopButton = DigitalIn(MyMbed, p5); % Check for the correct port
srf08 = RPCFunction(MyMbed, 'RangeFinder');

% Set up the servos
ThetaServo.period(0.020);
PhiServo.period(0.020);
ThetaServo.pulsewidth(0.002);
PhiServo.pulsewidth(1.2/1000);

for t = 1:(1/READINGS):2
    ThetaServo.pulsewidth((3-t)/1000);
    % Give servo time to get into position
    pause(0.001);
    
    %Read the distance into the Range matrix - add 3 cm to account for
    %distance of range finder from pivot.
    Range(n) = str2double(srf08.run(' ')) + 3;
    if Range(n) < 4
        Range(n) = 0;
    end
    
    if Range(n) > MaxRange
        Range(n) = 0;
    end
    
    % Calculate the angle
    Angles(n) = (MaxServoAngle/2) * ((t-1.5) * 2);
    % Add the points which are valid to the matrix
    
    if Range(n) > 0
        plotPoints(p,1) = pi .* angles(n) ./ 180 + pi/2;
        plotPoints( p, 2) = Range(n);
        p = p+1;
    end;
    n = n +1;
    % plot th hits
    polar(plotPoints(;,1), plotPoints(:, 2), ' r-;);
    if StopButton.read() == 0;
        display('Stop button pressed');
        break;
    end
end

display('Completed RangeFinder demo');
mymbed.delete;
clear;



