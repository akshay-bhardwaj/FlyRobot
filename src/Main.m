Fs = 20000; % Sampling rate in Hz
Duration = 10; % Stimulus duration in s;

AnalogInputLeft = analoginput('nidaq', 'Dev1'); % Analog input object
AnalogInputRight = analoginput('nidaq', 'Dev2'); % Analog input object

addchannel(AnalogInput, 1);

set(AnalogInput, 'InputType', 'Differential')
set(AnalogInput, 'TriggerType', 'Maual')
set(AnalogInput, 'ManualTriggerHwOn', 'Trigger')
set(AnalogInput, 'SamplesPerTrigger', Fs*duration)

AnalogInput.SampleRate = Fs;
start(AnalogInput); % Data acquistion device started
Iterations = 0;
while 1
    trigger(AnalogInput);
    wait(AnalogInput, duration+1);
    ResponseLeft = getdata(AnalogInputLeft); 
    ResponseRight = getdata(AnalogInputRight); 
    Flag = coreSystem(ResponseLeft, ResponseRight, Fs, Duration);
    if Flag == 0
        disp('Target reached and process completed successfully');
        break;
    elseif Flag == 1
        disp('Error in coreSystem');
    end
    Iterations = Iterations + 1;
    
end

stop(AnalogInput);
delete(AnalogInput);
disp('Process completed');
disp(Iterations);
