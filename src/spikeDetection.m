function [ Spikes ] = spikeDetection( BinaryWavelets, WaveletCoeffs )
%SPIKEDETECTION Summary of this function goes here
%   Detailed explanation goes here
%    WaveletLocation = getLocation(BinaryWavelets);
    NoOfWavelets = size(BinaryWavelets, 1);
    %ElePerWavelets = size(BinaryWavelets, 2);
    USpikeWavelet = [];
    WaveData = struct('Locations', [], 'BinaryWavelets', [], 'WaveletCoeffs', []);
    for i = 1:NoOfWavelets
        %disp(i);
        WaveData(i).Locations = getLocation(BinaryWavelets(i,:));
        WaveData(i).BinaryWavelets = BinaryWavelets(i,:);
        WaveData(i).WaveletCoeffs = WaveletCoeffs(i,:);
        USpikeWavelet = union(USpikeWavelet, WaveData(i).Locations);
    end
       %clear BinaryWavelets WaveletCoeffs;
       %Spikes = USpikeWavelet;
       % Working fine till here
       [CRegionList, Regions] = getContiguouRegion(USpikeWavelet);
       AverageTime = zeros(Regions, 1);
       T = zeros(NoOfWavelets, Regions);
       disp('Regions');
       disp(Regions);
       for i = 1:Regions
           BinaryCoeffsIndex = USpikeWavelet(find(CRegionList == i));
           Tsum = 0;
           count = 0;
           for k = 1:NoOfWavelets
               [MaxValue, MaxIndex] = max(WaveletCoeffs(k,BinaryCoeffsIndex));
               if (BinaryWavelets(k,BinaryCoeffsIndex(MaxIndex)) == 1)
                     T(k,i) = BinaryCoeffsIndex(MaxIndex);
                     Tsum = Tsum+BinaryCoeffsIndex(MaxIndex);
                     count= count+1;
               else
                     T(k,i) = 0;
               end
           end 
           %disp(i);
           AverageTime(i) = Tsum/count;
       end
       %disp(AverageTime);
       Spikes = AverageTime;
       Spikes  = unique(round(Spikes));
       % Calculate the Index;
       
end

