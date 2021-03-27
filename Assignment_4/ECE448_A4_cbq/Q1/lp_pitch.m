function y = lp_pitch()
    [inp,Fs]=audioread('A2.wav');
    %Window size is 20ms
    window_sample_size = (Fs*30)/1000;
    
    %Taking a voiced segment
    voiced_seg = inp(100000:100000+window_sample_size);
    
    %Finding LPC coefficients
    a = lpc(voiced_seg,15);
    lpc_coeff(1,1:length([1,a])) = [1,a];
    
    %Finding estimated signal
    est_voiced_seg = conv(voiced_seg,lpc_coeff,'same');
    
    %LP residual
    lp_residual = voiced_seg-est_voiced_seg;
   
    %Finding autocorrelation of LP residual 
    [acs,lags] = xcorr(lp_residual,'coeff');    
    
    subplot(311);
    plot(voiced_seg);
    title('Voiced segment');
    
    subplot(312);
    plot(lp_residual);
    title('LP residual');
    
    subplot(313);
    plot(lags,acs);
    hold on;
    %We can see from the plot the next peak is at x = 403
    plot(403,acs(1844),'*','MarkerSize',12);
    hold off;
    title('Autocorrelation of LP residual');
    
    %Finding pitch
    fprintf('The pitch is %d\n',(Fs/403));
end