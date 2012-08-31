function [Flag] = coreSystem(ResponseLeft, ResponseRight, Fs, Duration)
% coreSystem This function coordinates entire process
%   coreSystem controls both spike sorting and path prediction. For spike
%   sorting wavelet transform has been implemented and for path prediction
%   kalman filter has been implemented.

    WaveletsLeft = waveletDecomposition(ResponseLeft);
    WaveletsRight = waveletDecomposition(ResponseRight);
    SpikesLeft = spikeDetection(WaveletsLeft);
    SpikesRight = spikeDetection(WaveletsRight);
    SpikeRateLeft = spikeRate(SpikesLeft);
    SpikeRateRight = spikeRate(SpikesRight);
    % LeftOmega and RightOmega are Left and Right axel angular velocity
    [LeftOmega, RightOmega] = extendedKalmanFilter(SpikeRateLeft, SpikeRateRight);
    RCFlag = robotControl(LeftOmega, RightOmega, Fs, Duration);
    Flag = RCFlag;        
end

