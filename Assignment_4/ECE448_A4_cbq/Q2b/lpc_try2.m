function y = lpc_try2(file)
    
[sig, Fs] = audioread(file);

Horizon = 30;  %30ms - window length
OrderLPC = 24;   %order of LPC

Horizon = Horizon*Fs/1000;
Win = hanning(Horizon);  % analysis window

voiced = sig(36100:36100+(Horizon-1));
unvoiced = sig(33400:33400+(Horizon-1));

sigLPC = Win.*voiced;
r =   xcorr(sigLPC);% correlation
[a,g] =  lpc(sigLPC,OrderLPC);% LPC coef.
G = sqrt(g);  % gain
ex =  filter([0 -a(2:end)],1,sigLPC);


figure;
subplot(2,2,1);
plot(sigLPC);
title("Voiced segment");
subplot(2,2,3);
[h,w] = freqz(ex);
ff = abs(fft(sigLPC,1024));
plot(abs(h));
hold on
plot(ff(1:512));
hold off
title('FFT vs freqz for order 24 for voiced');

sigLPC = Win.*unvoiced;
r =   xcorr(sigLPC);% correlation
[a,g] =   lpc(sigLPC,OrderLPC);% LPC coef.
G = sqrt(g);  % gain
ex =  filter([0 -a(2:end)],1,sigLPC);

subplot(2,2,2);
plot(sigLPC);
title("Unvoiced segment");
subplot(2,2,4);
[h,w] = freqz(ex);
ff = abs(fft(sigLPC,1024));
plot(abs(h));
hold on
plot(ff(1:512));
hold off
title('FFT vs freqz for order 24 for unvoiced');
end