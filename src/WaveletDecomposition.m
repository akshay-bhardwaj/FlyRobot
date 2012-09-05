function [ BinaryCoeffs ] = waveletDecomposition( Response )
%WAVELETDECOMPOSITION This function decomposes signals to wavelets
%   Uses continuous wavelet decomposition to decompose neural response to
%   wavelets that are further used for

DC_Offset = 2.3;
% Threshold = 0.3;
NeuronData = Response - DC_Offset;



% Invert
% Neuron1Data = -1.*Neuron1Data;
% Neuron2Data = -1.*Neuron2Data;

% Absolute
% Neuron1Data = abs(Neuron1Data);
% Neuron2Data = abs(Neuron2Data);

% WaveletDecomposedData = wpdec(Neuron1Data, 3, 'bior1.3');
% plot(wpt);

% Continuous wavelet decomposition properties
Scale = 1:8;
WaveName = 'bior1.3';

% Calculate wavelet coefficients
Coefs = cwt(NeuronData, Scale, WaveName);
SizeCoeffs = size(Coefs);
N = SizeCoeffs(2);
NumCoeffs = SizeCoeffs(1);


% Calculate threshold. Using formula Threshold = sd*sqrt(2*log(N))
% This is a primitive method. Need to focus on a better algorithm, that uses thesis testing.

% For main method:
% Calculate Sigma for each translated coefficient.
disp(size(Coefs));
SampleMeanCoeff = mean(Coefs,2)';
DiffCoeff = zeros(SizeCoeffs);
for i = 1:NumCoeffs
    DiffCoeff(:,i) = abs(Coefs(:,i) - SampleMeanCoeff(i));
end
%SigmaCoeff = median((Coefs-SampleMeanCoeff), 2) ./ 0.6745;
SigmaCoeff = median(DiffCoeff, 2) ./ 0.6745;
disp(size(SigmaCoeff));
MuCoeff = mean(abs(Coefs'))';
Gamma = 0.5; %Dummy value. have to check literature for it! Gamma depends 
% on acceptable false alarms and ommision. These are calculated using
% LambdaFA and LambdaOM. and the prior probabilites of the two hypothesis,
% denoted by P(H0) and P(H1).
Theta = 0.2; % Dummy Value. This variable decides the threshold for 
% hypothesis testing.

% To determine Sample Mean independent of noise we use the threshold
% defined as Threshold = sd*sqrt(2*log(N)) and then calculate set of
% elements which lie below the threshold.

sd = std(Coefs,0,2);
disp(size(sd));
Threshold = sd.*sqrt(2*log(N));
FilteredSampleMean = zeros(NumCoeffs,1);
SizeOfFilterdSet = zeros(NumCoeffs,1);
% Calculating sample mean of the data filtered out using simple
% thresholding operation. Threshold calculated using formula:
% Threshold = sd.*sqrt(2*log(N)) 

for i = 1:NumCoeffs;    
    CoeffFiltered = Coefs(Coefs(i,:) >= Threshold(i));
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
disp('Next part');
disp(size(FilteredSampleMean));
disp(size(SigmaCoeff));
disp(size(LogGamma));
Theta = FilteredSampleMean./2 + ((SigmaCoeff.^2)./FilteredSampleMean).*LogGamma;
disp(size(Theta));
BinaryCoeffs = zeros(SizeCoeffs);
Theta
for i = 1:NumCoeffs
   BinaryCoeffs(i, :) =  (Coefs(i,:) > Theta(i)); % There is mistake in research paper regarding it!
end


% Here implement a way to select whether H0/H1 is true. For this purpose
% just use a conditional test or z test. But before applying that one must
% know whether the data fits normal distribution or not. Will have to
% revisit this section once again.

end

