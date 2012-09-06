function [ SpikeRate, SpikeTime ] = spikeRate( SpikeTime, TotalTime )
%SPIKERATE Summary of this function goes here
%   Detailed explanation goes here

SpikeRate = zeros(TotalTime,1);
SpikeTrain = zeros(TotalTime,1);
disp(size(SpikeTrain));
for i = 1:length(SpikeTime)
    SpikeTrain(SpikeTime(i)) = 1;
end

N = 1000; %number of elements  in gussian windows
GWin = gausswin(N);
for j = 1+N:(length(SpikeTrain)-N)
    SpikeRate(j) = GWin'*SpikeTrain((j+1-N/2):(j+N/2));
end

end