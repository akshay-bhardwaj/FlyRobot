% Code starts here
% Load & Assign Data
load('Data_2Ch_2012-05-24_18-22-19.mat')
SubjectDataSide1 = vect{1,1};
SubjectDataSide2 = vect{2,1};

% Define Filter
% Will have to read to get best filter parameters
%h = fdesign.lowpass('N,F3dB', 12, 0.15);
h = fdesign.lowpass;
d1 = design(h, 'butter');
y1 = filtfilt(d1.sosMatrix, d1.ScaleValues, SubjectDataSide1);
y2 = filtfilt(d1.sosMatrix, d1.ScaleValues, SubjectDataSide2);




