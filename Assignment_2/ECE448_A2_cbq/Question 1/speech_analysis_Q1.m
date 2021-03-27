function z = speech_analysis_Q1()
    % We take a 20ms window
    [x,Fs] = audioread('A2.wav');
    window_sample_size = (Fs*20)/1000;
   
    % Voiced segment in given audio
    voiced_seg = x(85000:85000+window_sample_size);
    
    % Unvoiced segment in given audio
    unvoiced_seg = x(80000:80000+window_sample_size);
    
    n = length(voiced_seg);
    energy_voiced = 0;
    energy_unvoiced = 0;
    
    % Calculating energy
    for i = 1:n
        energy_voiced = energy_voiced + voiced_seg(i)*voiced_seg(i);
        energy_unvoiced = energy_unvoiced + unvoiced_seg(i)*unvoiced_seg(i);
    end
    
    zc = dsp.ZeroCrossingDetector;
    release(zc);
    
    % Zero Crossings and Autocorrelation of Voiced Part 
    zero_crossings_voiced = zc(voiced_seg);
    [autocorrelation_voiced,lags_voiced] = xcorr(voiced_seg,Fs,'coeff');
    
    % Zero Crossings and Autocorrelation of Unvoiced Part
    zero_crossings_unvoiced = zc(unvoiced_seg);
    [autocorrelation_unvoiced,lags_unvoiced] = xcorr(unvoiced_seg,Fs,'coeff');
    
    subplot(511);
    plot(x);
    title('Input Signal');
    
    subplot(512);
    plot(voiced_seg);
    title('Voiced segment');
    
    subplot(513);
    plot(unvoiced_seg);
    title('Unvoiced segment');
    
    subplot(514);
    plot(lags_voiced/Fs,autocorrelation_voiced);
    title('Autocorrelation plot for Voiced segment');
    axis([-0.1 0.1 -2 2]);
    
    subplot(515);
    plot(lags_unvoiced/Fs,autocorrelation_unvoiced);
    title('Autocorrelation plot for Unvoiced segment');
    axis([-0.025 0.025 -2 2]);
     
    disp(sprintf('Zero Crossings in Voiced Segment is %d',zero_crossings_voiced));
    disp(sprintf('Zero Crossings in Unvoiced Segment is %d',zero_crossings_unvoiced));
    disp(sprintf('Energy of Voiced Segment is %d',energy_voiced));
    disp(sprintf('Energy of Unvoiced Segment is %d',energy_unvoiced));

    
end