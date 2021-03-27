[inp,Fs]=audioread('A2.wav');
%Window size is 30ms
window_sample_size = (Fs*30)/1000;
    
%Taking a voiced segment
voiced_seg = inp(98300:98300+window_sample_size);
    
%Finding LPC coefficients
a = lpc(voiced_seg,15);
lpc_coeff(1,1:length([1,a])) = [1,a];
    
%Finding estimated signal
est_voiced_seg = conv(voiced_seg,lpc_coeff,'same');
    
%LP residual
lp_residual = voiced_seg-est_voiced_seg;

%Computing GVV
gvv = cumtrapz(lp_residual);

subplot(311);
plot(voiced_seg);
title('Voiced segment');
    
subplot(312);
plot(lp_residual);
title('LP residual');

subplot(313);
plot(gvv);
title('GVV');
