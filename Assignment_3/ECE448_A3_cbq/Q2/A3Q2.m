function j = A3Q2()    
 [inp,Fs]=audioread('A2.wav');
 %Window size is 20ms
 window_sample_size = (Fs*20)/1000;
 
 %Normalizing whole input signal
 inp = inp./abs(max(inp));
 
 %Taking hamming window
 hw =  hamming(window_sample_size+1);
 
 %Taking a voiced segment
 voiced_seg = inp(100000:100000+window_sample_size);
 
 %Plotting voiced segment
 subplot(511);
 plot(voiced_seg);
 title('Input');
  
 %Applying Windowing
 voiced_seg_windowed = voiced_seg.*hw;
 
 %Plotting windowed voiced segment 
 subplot(512);
 plot(voiced_seg_windowed);
 title('Voiced Windowed Segment');
 
 %Taking log of Spectrum 
 temp1 = log10((abs(fft(voiced_seg_windowed))));
 
 %Cepstrum
 temp2 = ifft(temp1);
 
 %Plotting Cepstrum
 subplot(513);
 plot(temp2);
 title('Cepstrum');
 
 %Due to repetition half coefficients are removed
 temp3 = temp2(1:ceil(length(temp2)/2));
 
 %Plotting reduced cepstrum
 subplot(514);
 plot(temp3);
 title('Halved Cepstrum');
 
 %Liftering with cutoff Frequency as 20
 L = zeros(length(temp3),1);
 L(21:length(L)) = 1;
 
 %High Time Liftering
 temp4 = real(temp3.*L);
 
 %Finding peak in High-Time Liftered signal
 max_loc = 1;
 max_val = temp4(1);
 for i = 2:length(temp4)
     if temp4(i) > max_val
         max_loc = i;
         max_val = temp4(i);
     end
 end
 
 %Plotting Liftered Cepstrum
 subplot(515);
 plot(temp4);
 title('High-Time Liftered Cepstrum');
 hold on
 plot(max_loc,max_val,'-*','MarkerFaceColor','red','MarkerSize',15);
 hold off
    
 %The location of peak is Pitch period in terms of samples.
 pitch_freq = Fs/max_loc;
 fprintf("Pitch frequency is %d\n",pitch_freq);
      
end