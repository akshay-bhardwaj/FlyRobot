% Sample Script for DAQ in MATLAB (analog in and analog out)
% Created for Cockroach teaching lab.
% IMPORTANT
%
% Every time you call this script, stimulus and response are overwritten.
% Save them after every run, or change the variable names before every run
% Set basic stimulation and recording parameters
Fs = 20000; % Sampling rate / Hz
duration = 10; % Stimulus duration / s <-----
stimulus = ones(duration*Fs,1); % Stimulus waveform / V <-----

% Set up NI USB-6211
ai = analoginput('nidaq','Dev1'); % Create analog input object
addchannel(ai,1); % Add recording channel
ao = analogoutput('nidaq','Dev1'); % Create analog output object
addchannel(ao,0); % Add stimulation channels

% Make sure that channel wiring (input type) is set correctly and that
% both objects can be triggered quasi-simultaneously. Also set recording
% length and sample rates.
set(ai,'InputType','Differential');
set([ai ao],'TriggerType','Manual')
set(ai,'ManualTriggerHwOn','Trigger')
set(ai,'SamplesPerTrigger',Fs*duration)
ai.SampleRate = Fs;
ao.SampleRate = Fs;
putdata(ao,stimulus) % Put stimulus in output data buffer
start([ai ao]) % Start DAQ device
trigger([ai ao]) % Trigger both
wait([ai, ao], duration+1); % Block command line while DAQ running
response = getdata(ai); % Acquire response.
stop([ai ao]); % stop and delete DAQ object
delete([ai ao]);
