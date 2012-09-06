% close all;
% [t, SpikeTime] = coreSystem(vect);
% inp = vect{2};
% comb = t.*inp;
% [up,down] = envelope(1:200000,comb,'linear');
% subplot(2,1,1);
% plot(inp);
% ylabel('Voltage(Volts)');
% subplot(2,1,2);
% plot(up);
% ylabel('Spike Triggered Average Analysis');
SpikeTime = spiketimes;
BinBank = zeros(2000,1);
BtBank = zeros(length(SpikeTime), 2000);
%SpikeTime = sptime;
SpikeTime = spiketimes;
for i = 1:length(SpikeTime)
   Time = SpikeTime(i);
   BtBank(i,:) = inp(Time+1-1000 : Time+1000);
   BinBank = BinBank + inp(Time+1-1000 : Time+1000);
end
lnt = length(SpikeTime);
stanew = BinBank./length(SpikeTime);
NCBtBank = (cov(BtBank)./(lnt-1)) - ((lnt/(lnt-1)).*cov(stanew));