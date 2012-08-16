%Clean Environment
close all;
clear all;

%Load Data
load('Data_2Ch_2012-05-24_18-23-45.mat');
DC_Offset = 2.3;
Threshold = 0.3;
Neuron1Data = vect{1} - DC_Offset;
Neuron2Data = vect{2} - DC_Offset;


%Invert
Neuron1Data = -1.*Neuron1Data;
Neuron2Data = -1.*Neuron2Data;

%Absolute
Neuron1Data = abs(Neuron1Data);
Neuron2Data = abs(Neuron2Data);

%Plot Data
hold on;
figure;
plot(Neuron1Data,'b');
plot(Neuron2Data,'r');
hold off;

Neuron1Spike = (Neuron1Data > Threshold);
Neuron2Spike = (Neuron2Data > Threshold);

%Plot Spikes
hold on;
figure
plot(Neuron1Spike,'b');
plot(Neuron2Spike,'r');
hold off;

