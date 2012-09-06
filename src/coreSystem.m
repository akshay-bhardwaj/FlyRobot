function [SpikeRateLeft, SpikeTime] = coreSystem(Response)
% function [SpikeRateLeft] = coreSystem(Response, Fs, Duration)
% coreSystem This function coordinates entire process
%   coreSystem controls both spike sorting and path prediction. For spike
%   sorting wavelet transform has been implemented and for path prediction
%   kalman filter has been implemented.

    ResponseLeft = Response{1};
    %ResponseRight = Response{2};
    [BWaveletsLeft, WaveletsLeft] = waveletDecomposition(ResponseLeft);
    %WaveletsRight = waveletDecomposition(ResponseRight);
    SpikesLeft = spikeDetection(BWaveletsLeft, WaveletsLeft);
    %SpikesRight = spikeDetection(WaveletsRight);
    [SpikeRateLeft,SpikeTime] = spikeRate(SpikesLeft,200000);
    plot(SpikeRateLeft);
    %SpikeRateRight = spikeRate(SpikesRight);
    % LeftOmega and RightOmega are Left and Right axel angular velocity
    %[LeftOmega, RightOmega] = extendedKalmanFilter(SpikeRateLeft, SpikeRateRight);
    %RCFlag = robotControl(LeftOmega, RightOmega, Fs, Duration);
    %Flag = RCFlag;        
end

