function [ CRegionList, Count ] = getContiguouRegion( USpikeWavelet )
%GETCONTIGUOUREGION Summary of this function goes here
%   Detailed explanation goes here
    L = length(USpikeWavelet);
    CRegionList = zeros(1,L);
    Count = 1;
    CRegionList(1) = Count;
    for i = 2:L
        if USpikeWavelet(i) == (USpikeWavelet(i-1)+1)
            CRegionList(i) = Count;
        else
            Count = Count+1;
            CRegionList(i) = Count;
        end
    end

end

