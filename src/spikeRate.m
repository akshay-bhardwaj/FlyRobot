function [ SpikeTrain ] = spikeRate( SpikeTime, TotalTime )
%SPIKERATE Summary of this function goes here
%   Detailed explanation goes here

SpikeRate = zeros(TotalTime,1);
SpikeTrain = zeros(TotalTime,1);
disp(size(SpikeTrain));
for i = 1:length(SpikeTime)
    SpikeTrain(SpikeTime(i)) = 1;
end

% %SpikeTrainSize = size(SpikeTrain);
% Xvec = 1:TotalTime;
% Sigma =10;
% %Sigma = 25;
% %FiringRate = zeros(SpikeTrainSize);
%         
%     for i = 1:TotalTime
%        GussianData = normpdf(Xvec, i, Sigma);
%        SpikeRate(i) = sum(SpikeTrain.*GussianData');
%        
%     end
end