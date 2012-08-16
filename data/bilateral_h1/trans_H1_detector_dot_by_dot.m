%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Jiaqi (Joseph) Huang
% Imperial College London
% Spike sorting of bi-lateral H1 recording
% 2012-06-20
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 
close all;

%% Data loading
dir = 'H:\[DAQ_DATA]\';
% filename = 'Data_2Ch_2012-05-24_18-26-00';
filename = 'Data_2Ch_2012-06-29_15-14-22_[]'

raw_data = load(strcat(dir,filename,'.mat'), 'vect'); 

data(1,:) = raw_data.vect{1};
data(2,:) = raw_data.vect{2};

%% Parameter loading

SamplingRate = 20000;
TotalPeriod = 10;
t=[0:1/SamplingRate:TotalPeriod-1/SamplingRate];

% threshold = 2.3;

method = 2;
    

%% Data derivative 
if (method == 1)
    data(3,1)=0;
    for i=2:length(data)
        data(3,i) = data(1,i)-data(1,i-1); 
    end
    data(4,1)=0;
    for i=2:length(data)
        data(4,i) = data(2,i)-data(2,i-1); 
    end

% data(5,1)=0;
% for i=2:length(data)
%     data(5,i) = data(3,i)-data(3,i-1); 
% end
% data(6,1)=0;
% for i=2:length(data)
%     data(6,i) = data(4,i)-data(4,i-1); 
% end

end

%% Mutual Convolution (method 1)
if (method == 1)
    
%     win = 5;
%     wavelet = [0.2 0.5 1 0.5 0.2];
%     conv_res(1,1:win)=0;
%     conv_res(2,1:win)=0;
%     for i=win+1:length(data)
%         conv_res(1,i) = sum(conv(data(3,((i-win):i)),wavelet));
%     end
%     for i=win+1:length(data)
%         conv_res(2,i) = sum(conv(data(4,((i-win):i)),wavelet));
%     end
    
    win=5;
    conv_res(3,1:win)=0;
    for i=win+1:length(data)
        conv_res(3,i) = sum(conv(data(3,((i-win):i)),data(4,((i-win):i))));
    end    
    
end


%% Data analysis

threshold = 2.2;

iCros(1:2) = 0;
iPeak(1:2) = 0;
iInit(1:2) = 0;
iTerm(1:2) = 0;

% spike_shape(1:4,1:2) = 0;
spike_train(1:3,1:SamplingRate*TotalPeriod) = 0;

i=3;

% CurrPeak(2) = 0;
% CurrVale(2) = 0;
% PrevPeak(2) = 0;
% PrevVale(2) = 0;

range = 20;


while(SamplingRate*TotalPeriod +1 - i )
   
%     spike_train(1,i) = 0;
%     spike_train(2,i) = 0;
    
    
    %...spike_train 1
    if ((data(1,i)>=threshold) && (data(1,i-1)<=threshold)) %... rising edge
        iCros(1) = i;
%         spike_train(1,iCros(1))=0.8;

        k_min = (iCros(1)-range);
        if(k_min<=1)
            k_min = 1;
        end       
        for k=iCros(1):-1:k_min
            if( (data(1,k)>data(1,k+1)) && (data(1,k+1)<data(1,k+2)) )
                iPeak(1) = k+1;
%                 spike_shape(3,iPeak)=1;
                spike_train(1,iPeak(1))=1;
                break;
            end
        end      
        
        
        p_min = (iPeak(1)-range);
        if(p_min<=1)
            p_min = 1;
        end   
        for p=iPeak(1):-1:p_min
            if( (data(1,p)<data(1,p+1)) && (data(1,p+1)>data(1,p+2)) )
                iInit(1) = p+1;
%                 spike_shape(5,iInit)=1;
                spike_train(1,iInit(1))=0.4;
                break;
            end
        end
        
        
        z_max = (iCros(1)+range);
        if(z_max>SamplingRate*TotalPeriod)
            z_max = SamplingRate*TotalPeriod;
        end
        for z=iCros(1):1:z_max
            if( (data(1,z-2)<data(1,z-1)) && (data(1,z-1)>data(1,z)) )
                iTerm(1) = z-1;
%                 spike_shape(3,iPeak)=1;
                spike_train(1,iTerm(1))=0.6;
%                 spike_train(2,iTerm(1))=-0.6;
                break;
            end
        end      
        
        

    end
    
    
    
    
    
    %...spike_train 2
    if ((data(2,i)>=threshold) && (data(2,i-1)<=threshold)) %... rising edge
        iCros(2) = i;
%         spike_train(2,iCros(2))=-0.8;
        
        k_min = (iCros(2)-range);
        if(k_min<=1)
            k_min = 1;
        end       
        for k=iCros(2):-1:k_min
            if( (data(2,k)>data(2,k+1)) && (data(2,k+1)<data(2,k+2)) )
                iPeak(2) = k+1;
                spike_train(2,iPeak(2))=-1;
                break;
            end
        end    
        
        
        
        p_min = (iPeak(2)-range);
        if(p_min<=1)
            p_min = 1;
        end   
        for p=iPeak(2):-1:p_min
            if( (data(2,p)<data(2,p+1)) && (data(2,p+1)>data(2,p+2)) )
                iInit(2) = p+1;
%                 spike_shape(5,iInit)=1;
                spike_train(2,iInit(2))=-0.4;
                break;
            end
        end
        
        
        z_max = (iCros(2)+range);
        if(z_max>SamplingRate*TotalPeriod)
            z_max = SamplingRate*TotalPeriod;
        end
        for z=iCros(2):1:z_max
            if( (data(2,z-2)<data(2,z-1)) && (data(2,z-1)>data(2,z)) )
                iTerm(2) = z-1;
%                 spike_shape(3,iPeak)=1;
                spike_train(2,iTerm(2))=-0.6;
%                 spike_train(2,iTerm(1))=-0.6;
                break;
            end
        end      
        
        
        
        if(iPeak(1)>iInit(2) && iPeak(1)<iTerm(2) && iPeak(2)>iInit(1) && iPeak(2)<iTerm(1))
            spike_train(3,iPeak(2)) = 1;
        end
        
        
    end    
    
    
    
%     if ((spike_train(1,i)==spike_train(2,i)) && (spike_train(1,i)~=0) && (spike_train(2,i)~=0 ))
%         spike_train(3,i)=0.2*(spike_train(1,i) & spike_train(2,i));
%     end
    
    
    i=i+1;
end

% spike_train(3,:) = spike_train(1,:) & spike_train(2,:);
% spike_train(3,:)=0.2*(spike_train(1,:) & spike_train(2,:));





%% Data Drawing

plot_row = 3;
plot_col = 1;



figure(1)

h(1) = subplot(plot_row,plot_col,1);
plot(t,data(1,:),'b',t,data(2,:),'r');
% line([0 length(data)], [threshold threshold],'Color','k');

% xlabel('Time(per 50us)')
ylabel('Potential(V)')
% title('\it{Spike sorting}')

h(2) = subplot(plot_row,plot_col,2);
stem(t,spike_train(1,:),'b','Marker','none')
hold on
stem(t,spike_train(2,:),'r','Marker','none')
hold off

% xlabel('Time(per 50us)')
ylabel('Spike charactor')
% title('\it{Spike sorting}')

% plot(t,conv_res(3,:),'k')

h(3) = subplot(plot_row,plot_col,3);
stem(t,spike_train(3,:),'k','Marker','none')
% plot(t,spike_train(1,:),'b',t,spike_train(2,:),'r')

xlabel('Time(sec)')
ylabel('Spike train')
% title('\it{Spike sorting}')

linkaxes(h,'x');


%%

figure(2)
win = 1:30;
win_left=1;
win_right=length(win);
plot(win,zeros(length(win)));
axis([min(win) max(win) 1.7 2.7]) 
for i=1:SamplingRate*TotalPeriod
    if (spike_train(3,i)==1)
        
        win_left = i-length(win)/2+1;
        win_right = i+length(win)/2;
        
        if (win_left<1) 
%             win_left = 1;
            continue;
        end
        if (win_right >SamplingRate*TotalPeriod)
%             win_right=SamplingRate*TotalPeriod;
            continue;
        end
        
        hold on
        plot(win,data(1,win_left:win_right),'b',win,data(2,win_left:win_right),'r');
%         plot(win,data(2,win_left:win_right),'r'); 
%         plot(win,data(1,win_left:win_right),'b');
        hold off
    end
end

xlabel('Time(per 50us)')%,'FontSize',16
ylabel('Potential(V)')%,'FontSize',16
title('\it{Spike sorting}')%,'FontSize',16
