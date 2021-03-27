function u = A3Q4()
    [inp,Fs] = audioread('A2.wav');
    win_len = round((Fs*20)/1000);
    overlap_win_len = round((Fs*10)/1000);
    
    %Finding MFCC coefficients for 20ms frames
    m = mfcc(inp,Fs,'WindowLength',win_len,'NumCoeffs',13,'OverlapLength',overlap_win_len);
    
    %Reshaping x_axis, y_axis, z_axis to plot them  
    n = length(m);   
    x_axis = [1:n];
    y_axis = [1:13];
    z_axis = m(x_axis,y_axis);

    %Plotting final surface 
    hsurf = pcolor(x_axis.',y_axis.',z_axis.'); 
    hsurf.EdgeAlpha = 0.05;
    xlabel('Frame Index');
    ylabel('MFCC Coefficents vector');
    title('MFCC Coefficients');
    
    %Finding log of magnitude of spectrum
    log_fft = [];
    for i = 1 : overlap_win_len : (length(inp) - win_len)
        log_fft = [log_fft, [log(abs(fft(inp(i:(i+win_len)),1024)))]];
    end
    
    %Reshaping x,y,z axes
    y_log_fft = [1:1024]; 
    x_log_fft = [1:271];
    figure;
    
    %Plotting final surface
    hsurf = pcolor(x_log_fft.',y_log_fft.',log_fft);
    hsurf.EdgeAlpha = 0.05;
    xlabel('Frame Index');
    ylabel('FFT vector');
    title('Log of magnitude of FFT spectrum');
end