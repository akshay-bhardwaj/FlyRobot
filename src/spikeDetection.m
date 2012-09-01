function [ Spikes ] = spikeDetection( BinaryWavelets )
%SPIKEDETECTION Summary of this function goes here
%   Detailed explanation goes here
    WaveletLocation = getLocation(BinaryWavelets);
    NoOfWavelets = size(WaveletLocation, 1);
    ElePerWavelets = size(WaveletLocation, 2);
    USpikeWavelet = [];
    for i = 1:NoOfWavelets
        USpikeWavelet = union(USpikeWavelet, WaveletLocation(i,:));
    end
       
end

