wname1 = 'bior1.3';
wname2 = 'bior1.5';

[rf1, df1] = biorwavf(wname1);
[rf2, df2] = biorwavf(wname2);
[Lo_D,Hi_D,Lo_R,Hi_R] = biorfilt(df1,rf1); 

subplot(221); stem(Lo_D); 
title('Dec. low-pass filter bior1.3'); 
subplot(222); stem(Hi_D); 
title('Dec. high-pass filter bior1.3'); 
subplot(223); stem(Lo_R); 
title('Rec. low-pass filter bior1.3'); 
subplot(224); stem(Hi_R); 
title('Rec. high-pass filter bior1.3');

