function [ Spikes ] = spikeDetection( BinaryWavelets, WaveletCoeffs )
%SPIKEDETECTION Summary of this function goes here
%   Detailed explanation goes here
%    WaveletLocation = getLocation(BinaryWavelets);
    NoOfWavelets = size(BinaryWavelets, 1);
    ElePerWavelets = size(BinaryWavelets, 2);
    USpikeWavelet = [];
    WaveData = struct('Locations', [], 'BinaryWavelets', [], WaveletCoeffs, []);
    for i = 1:NoOfWavelets
        disp(i);
        WaveData(i).Locations = getLocation(BinaryWavelets(i,:));
        WaveData(i).BinaryWavelets = BinaryWavelets(i,:);
        WaveData(i).WaveletCoeffs = WaveletCoeffs(i,:);
        USpikeWavelet = union(USpikeWavelet, WaveData(i).Locations);
    end
       clear BinaryWavelets WaveletCoeffs;
       Spikes = USpikeWavelet;
       [CRegionList, Regions] = getContiguouRegion(USpikeWavelet);
       AverageTime = zeros(ElePerWavelets, 1);
       for i = 1:Regions
           BinaryCoeffsIndex = USpikeWavelet(:,find(CRegionList == i));
           for j = 1:length(BinaryCoeffsIndex)
              OneIndex = find(BinaryWavelets(:,j) == 1);
              [MaxValues, MaxIndex] = max(WaveletCoeffs(OneIndex,BinaryCoeffsIndex));
              
           end
       end
       
end

