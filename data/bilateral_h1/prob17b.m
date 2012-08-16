%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Jiaqi (Joseph) Huang
% Imperial College London
% H1 neuron signal generator (for testing spiking detect algorithm)
% 2012-07-02
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;

%% Parameters
total_period = 10;  %...second
sampling_rate = 20000;  
t = 0 : 1/sampling_rate : total_period-1/sampling_rate;

noise_volt = 0.1;   %...volt
SNR = 4;
spike_volt = noise_volt * SNR;

spike_rate = 200;   %...Hz (max: 300)
spike_period = 1e-3; %...ms

DC_offset = 2.5;    %...volt

%% Function generation
noise = noise_volt*sin(2*pi*(1/spike_period)*t);

spike = spike_volt*sin(2*pi*(1/spike_period)*t);

spike_train(1,1:length(t))=0;
for i=1:length(t)
    if (mod(i,sampling_rate/spike_rate)==0)
        spike_train((i+1):(i+sampling_rate*spike_period+1))=1;
    end
end

data(1:length(t)) = noise(1:length(t)) + spike(1:length(t)) .* spike_train(1:length(t)) + DC_offset;

%% Plot

plot(data)
