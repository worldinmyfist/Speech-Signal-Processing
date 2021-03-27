function g = stft_Q1()
    [inp,Fs] = audioread('A2.wav');
    
    %Plotting input signal
    subplot(311);
    plot(inp);
    
    %Plotting 2D Spectrogram
    subplot(312);
    spectrogram(inp,hamming(961),300,1024,Fs,'yaxis');
    
    %PLotting 3D spectrogram
    subplot(313);
    spectrogram(inp,961,300,1024,Fs,'yaxis');
    view(-45,35);
    zlabel('Z','Fontweight','bold');
    colormap winter;
    
end

