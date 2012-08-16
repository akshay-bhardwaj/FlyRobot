%Clean Environment
close all;
clear all;

%Load Data
load('Data_2Ch_2012-05-24_18-23-45.mat');
DC_Offset = 2.3;
Threshold = 0.3;
Neuron1Data = vect{1} - DC_Offset;
Neuron2Data = vect{2} - DC_Offset;


% Invert
% Neuron1Data = -1.*Neuron1Data;
% Neuron2Data = -1.*Neuron2Data;

% Absolute
% Neuron1Data = abs(Neuron1Data);
% Neuron2Data = abs(Neuron2Data);

% WaveletDecomposedData = wpdec(Neuron1Data, 3, 'bior1.3');
% plot(wpt);

% Continuous wavelet decomposition properties
Scale = 1:32;
WaveName = 'bior1.3';

% Calculate wavelet coefficients
Coefs = cwt(Neuron1Data, Scale, WaveName);

% Calculate threshold. Using formula Threshold = sd*sqrt(2*log(N))
% This is a primitive method. Need to focus on a better algorithm, that uses thesis testing.

% For main method:
% Calculate Sigma for each translated coefficient.

SampleMeanCoeff = mean(Coefs,2)';
SigmaCoeff = median((coefs-SampleMeanCoeff), 2) ./ 0.6745;
MuCoeff = mean(abs(coefs'))';

		 



