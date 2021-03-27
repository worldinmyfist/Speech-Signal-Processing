function h = A3Q3()
     [inp,Fs] = audioread('A2.wav');
     
     %Defining all window sizes
     window_sample_size1 = (Fs*10)/1000;
     window_sample_size2 = (Fs*20)/1000;
     window_sample_size3 = (Fs*50)/1000;
     
     %Defining all points for DFT
     N1 = 256;
     f1 = (N1/2)*linspace(-1,1,N1);
     N2 = 512;
     f2 = (N2/2)*linspace(-1,1,N2);
     N3 = 1024;
     f3 = (N3/2)*linspace(-1,1,N3);
     N4 = 4096;
     f4 = (N4/2)*linspace(-1,1,N4);
     
     %Defining all window types
     W1 = rectwin(window_sample_size2+1);
     W2 = hamming(window_sample_size2+1);
     W3 = hann(window_sample_size2+1);
 
     % Voiced segment in given audio
     voiced_seg = inp(100000:100000+window_sample_size2);
     
     % Unvoiced segment in given audio
     unvoiced_seg = inp(126500:126500+window_sample_size2);
     
     %PART (a) : Varying N and plotting results
     figure();
     voiced_hw =  voiced_seg.*W2;
     unvoiced_hw = unvoiced_seg.*W2;
     
     %Plotting Voiced and Unvoiced segments 
     subplot(421);
     plot(voiced_seg);
     title("Voiced segment");
     subplot(422);
     plot(unvoiced_seg);
     title("Unvoiced segment");
     
     %N = 256
     voiced_N1_a = abs(fftshift(fft(voiced_hw,N1)));
     unvoiced_N1_a = abs(fftshift(fft(unvoiced_hw,N1)));
     subplot(423);
     plot(f1,voiced_N1_a);
     title("FFT for Voiced segment(256 pt)");
     subplot(424);
     plot(f1,unvoiced_N1_a);
     title("FFT for Unvoiced segment(256 pt)");
     
     %N = 512
     voiced_N2_a = abs(fftshift(fft(voiced_hw,N2)));
     unvoiced_N2_a = abs(fftshift(fft(unvoiced_hw,N2)));
     subplot(425);
     plot(f2,voiced_N2_a);
     title("FFT for Voiced segment(512 pt)");
     subplot(426);
     plot(f2,unvoiced_N2_a);
     title("FFT for Unvoiced segment(512 pt)");
     
     %N = 1024
     voiced_N3_a = abs(fftshift(fft(voiced_hw,N3)));
     unvoiced_N3_a = abs(fftshift(fft(unvoiced_hw,N3)));
     subplot(427);
     plot(f3,voiced_N3_a);
     title("FFT for Voiced segment(1024 pt)");
     subplot(428);
     plot(f3,unvoiced_N3_a);
     title("FFT for Unvoiced segment(1024 pt)");
     
     %PART (b) : Varying size of window and plotting results (N = 2048)
     figure();
     
     %Defining different sized windows
     hw_10 = hamming(window_sample_size1+1);
     hw_20 = hamming(window_sample_size2+1);
     hw_50 = hamming(window_sample_size3+1);
     
     %Defining different subframes within main frame for voiced
     v1 = inp(100000:100000+window_sample_size1);
     v2 = inp(100000:100000+window_sample_size2);
     v3 = inp(100000:100000+window_sample_size3);
     
     %Defining different subframes within main frame for unvoiced
     uv1 = inp(126500:126500+window_sample_size1);
     uv2 = inp(126500:126500+window_sample_size2);
     uv3 = inp(126500:126500+window_sample_size3);
     
     %Defining Voiced and Unvoiced windowed signals
     voiced_hw_10 = v1.*hw_10;
     voiced_hw_20 = v2.*hw_20;
     voiced_hw_50 = v3.*hw_50;
     unvoiced_hw_10 = uv1.*hw_10;
     unvoiced_hw_20 = uv2.*hw_20;
     unvoiced_hw_50 = uv3.*hw_50;
     
     %Length = 10ms
     subplot(3,4,1);
     plot(v1);
     title("Voiced segment for 10ms");
     subplot(3,4,2);
     plot(uv1);
     title("Unvoiced segment for 10ms");
     voiced_10_b = abs(fftshift(fft(voiced_hw_10,N4)));
     unvoiced_10_b = abs(fftshift(fft(unvoiced_hw_10,N4)));
     subplot(3,4,3);
     plot(f4,voiced_10_b);
     title("FFT - 10ms Voiced segment");
     subplot(3,4,4);
     plot(f4,unvoiced_10_b);
     title("FFT - 10ms Unvoiced segment");
     
     %Length = 20ms
     subplot(3,4,5);
     plot(v2);
     title("Voiced segment for 20ms");
     subplot(3,4,6);
     plot(uv2);
     title("Unvoiced segment for 20ms");
     voiced_20_b = abs(fftshift(fft(voiced_hw_20,N4)));
     unvoiced_20_b = abs(fftshift(fft(unvoiced_hw_20,N4)));
     subplot(3,4,7);
     plot(f4,voiced_20_b);
     title("FFT - 20ms Voiced segment");
     subplot(3,4,8);
     plot(f4,unvoiced_20_b);
     title("FFT - 20ms Unvoiced segment");
     
     %Length = 30ms
     subplot(3,4,9);
     plot(v3);
     title("Voiced segment for 50ms");
     subplot(3,4,10);
     plot(uv3);
     title("Unvoiced segment for 50ms");
     voiced_50_b = abs(fftshift(fft(voiced_hw_50,N4)));
     unvoiced_50_b = abs(fftshift(fft(unvoiced_hw_50,N4)));
     subplot(3,4,11);
     plot(f4,voiced_50_b);
     title("FFT - 50ms Voiced segment");
     subplot(3,4,12);
     plot(f4,unvoiced_50_b);
     title("FFT - 50ms Unvoiced segment");
     
     %PART (c) : Varying type of window and plotting results (N = 1024)
     figure();
     subplot(421);
     plot(voiced_seg);
     title("Voiced segment for 20ms frame (N = 1024)");
     subplot(422);
     plot(unvoiced_seg);
     title("Unvoiced segment for 20ms frame (N = 1024)");
     
     %Rectangular Window
     voiced_rec = voiced_seg.*W1;
     unvoiced_rec = unvoiced_seg.*W1;
     voiced_rec_c = abs(fftshift(fft(voiced_rec,N3)));
     vrc1 = 10*log(voiced_rec_c);
     unvoiced_rec_c = abs(fftshift(fft(unvoiced_rec,N3)));
     uvrc1 = 10*log(unvoiced_rec_c);
     subplot(423);
     plot(f3,vrc1);
     title("Log of spectrum for voiced segment using Rectangular Window");
     subplot(424);
     plot(f3,uvrc1);
     title("Log of spectrum for unvoiced segment using Rectangular Window");
     
     %Hamming Window
     voiced_ham = voiced_seg.*W2;
     unvoiced_ham = unvoiced_seg.*W2;
     voiced_ham_c = abs(fftshift(fft(voiced_ham,N3)));
     vhc2 = 10*log(voiced_ham_c);
     unvoiced_ham_c = abs(fftshift(fft(unvoiced_ham,N3)));
     uvhc2 = 10*log(unvoiced_ham_c);
     subplot(425);
     plot(f3,vhc2);
     title("Log of spectrum for voiced segment using Hamming Window");
     subplot(426);
     plot(f3,uvhc2);
     title("Log of spectrum for unvoiced segment using Hamming Window");
     
     %Hanning Window
     voiced_han = voiced_seg.*W3;
     unvoiced_han = unvoiced_seg.*W3;
     voiced_han_c = abs(fftshift(fft(voiced_han,N3)));
     vhc3 = 10*log(voiced_han_c);
     unvoiced_han_c = abs(fftshift(fft(unvoiced_han,N3)));
     uvhc3 = 10*log(unvoiced_han_c);
     subplot(427);
     plot(f3,vhc3);
     title("Log of spectrum for voiced segment using Hanning Window");
     subplot(428);
     plot(f3,uvhc3);
     title("Log of spectrum for unvoiced segment using Hanning Window");
     
     figure();
     subplot(311);
     plot(W1);
     title('Rectangular');
     subplot(312);
     plot(W2);
     title('Hamming');
     subplot(313);
     plot(W3);
     title('Hanning');
    
end