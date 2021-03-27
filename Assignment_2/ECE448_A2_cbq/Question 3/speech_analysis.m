function y = speech_analysis()
    % We take a 20ms window
    [x,Fs] = audioread('H_MKB.wav');
    window_sample_size = (Fs*20)/1000;
    
    % Voiced segment in given audio
    voiced_seg = x(300000:300000+window_sample_size);
    
    % Unvoiced segment in given audio
    unvoiced_seg = x(149000:149000++window_sample_size);
    
    % Calculating Pitch for Voiced segment
    [f0_init,idx_init] = pitch(x,Fs);
    f0 = [];
    idx = [];
    for i = 1:length(f0_init)
        if idx_init(i)>=300000 && idx_init(i)<=300000+window_sample_size
            temp = [f0,f0_init(i)];
            f0 = temp;
            temp2 = [idx,idx_init(i)];
            idx = temp2;
        end
    end
    f0_len = length(f0);
    f0_sum = 0;
    max_f0 = f0(1);
    min_f0 = f0(1);
    max_f0_location = [];
    min_f0_location = [];
    
    % Calculating average, maximum and minimum pitch
    for i = 1:f0_len
      f0_sum = f0_sum + f0(i);
      
      if f0(i) > max_f0
          max_f0 = f0(i);
      end
      
      if f0(i) < min_f0
          min_f0 = f0(i);
      end
      
    end
    
    for i = 1:length(idx)
        if f0(i) == max_f0
            temp = [max_f0_location,idx(i)];
            max_f0_location = temp;
        end
        
        if f0(i) == min_f0
           temp = [min_f0_location,idx(i)];
           min_f0_location = temp;
        end
    end
    avg_f0 = f0_sum/f0_len;
    
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
    
    subplot(611);
    plot(x);
    title('Input Signal');
    
    subplot(612);
    plot(voiced_seg);
    title('Voiced segment');
    
    subplot(613);
    plot(unvoiced_seg);
    title('Unvoiced segment');
    
    subplot(614);
    plot(lags_voiced/Fs,autocorrelation_voiced);
    title('Autocorrelation plot for Voiced segment');
    axis([-0.1 0.1 -2 2]);
    
    subplot(615);
    plot(lags_unvoiced/Fs,autocorrelation_unvoiced);
    title('Autocorrelation plot for Unvoiced segment');
    axis([-0.025 0.025 -2 2]);
    
    subplot(616);
    plot(idx,f0);
    title('Pitch for selected Voiced segment');
    hold on
    plot(max_f0_location,max_f0,'-*','MarkerFaceColor','red','MarkerSize',15);
    plot(min_f0_location,min_f0,'o','MarkerFaceColor','red','MarkerSize',5);
    hold off   
    
     
    disp(sprintf('Zero Crossings in Voiced Segment is %d',zero_crossings_voiced));
    disp(sprintf('Zero Crossings in Unvoiced Segment is %d',zero_crossings_unvoiced));
    disp(sprintf('Energy of Voiced Segment is %d',energy_voiced));
    disp(sprintf('Energy of Unvoiced Segment is %d',energy_unvoiced));
    disp(sprintf('Average Pitch of Voiced Segment is %d',avg_f0));
    disp(sprintf('Maximum Pitch of Voiced Segment is %d',max_f0));
    disp(sprintf('Minimum Pitch of Voiced Segment is %d',min_f0));
   
   
    
end
