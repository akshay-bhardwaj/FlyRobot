%Clean Environment
close all;
clear all;

%Load Data
load('../data/two_neuron/Data_2Ch_2012-07-18_15-48-18_[bih1_rec].mat');
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
Gamma = 0.5; %Dummy value. have to check literature for it! Gamma depends 
% on acceptable false alarms and ommision. These are calculated using
% LambdaFA and LambdaOM. and the prior probabilites of the two hypothesis,
% denoted by P(H0) and P(H1).
Theta = 0.2; % Dummy Value. This variable decides the threshold for 
% hypothesis testing.

% To determine Sample Mean independent of noise we use the threshold
% defined as Threshold = sd*sqrt(2*log(N)) and then calculate set of
% elements which lie below the threshold.
SizeCoeffs = size(Coefs);
N = SizeCoeffs(2);
NumCoeffs = SizeCoeffs(1);

sd = std(coefs,0,2);
Threshold = sd.*sqrt(2*log(N));
FilteredSampleMean = zeros(NumCoeffs);
SizeOfFilterdSet = zeros(NumCoeffs);
% Calculating sample mean of the data filtered out using simple
% thresholding operation. Threshold calculated using formula:
% Threshold = sd.*sqrt(2*log(N)) 

for i = 1:NumCoeffs;    
    CoeffFiltered = Coefs(Coefs >= Threshold);
    FilteredSampleMean(i) = mean(CoeffFiltered);
    SizeOfFilterdSet = size(CoeffFiltered,2); %Check for dimension
end;

% For evaluation of Gamma we need LambdaFA & LambdaOM 
% In this section both of these variables are defined: 
% (Currently with dummy values)
LambdaFA = 0.1;
LambdaOM = 0.2;

% Rather then using LambdaFA and LambdaOM, we will be using L and LM. Where
% LM is fixed to 36.738 and L is element of [-0.188, 0.188]
LM = 36.738;
L = 0.1; % Currently just selected a dummy value.

% Determining RationProbabilityOfHypothesis
RationProbabilityOfHypothesis = (N - SizeOfFilterdSet)./SizeOfFilterdSet;

LogGamma = L*LM + log(RationProbabilityOfHypothesis);
Theta = FilteredSampleMean./2 + ((SigmaCoeff.^2)./FilteredSampleMean).*LogGamma;






		 



