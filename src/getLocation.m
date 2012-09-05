function [ Location ] = getLocation( BinaryWavelets )
%GETLOCATION Summary of this function goes here
%   Detailed explanation goes here
    %MatSize = size(BinaryWavelets == 1);
    %Location = zeros(MatSize);
    Location = find(BinaryWavelets==1);

end

