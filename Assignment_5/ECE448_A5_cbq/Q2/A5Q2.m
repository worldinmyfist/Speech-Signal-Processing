[y,fs] = audioread('A5.wav');

% Voiced region
voiced = y(round(fs*0.720) : round(fs*0.820));

% Differenced signal to remove low frequency bias
difference_voiced = zeros(length(voiced),1);
difference_voiced(1) = voiced(1);
for i = 2:length(voiced)
    difference_voiced(i) = voiced(i) - voiced(i-1);
end

% Passing differenced signal through Ideal Resonator
ak = [-2 1];
resonator1 = zeros(length(voiced),1);
resonator1(1) = difference_voiced(1);
resonator1(2) = -ak(1)*resonator1(1) + difference_voiced(2);
for i = 3:length(voiced)
    resonator1(i) = difference_voiced(i) - ak(1)*resonator1(i-1) - ak(2)*resonator1(i-2);
end

% Passing the output of first Resonator through second Resonator
resonator2 = zeros(length(voiced),1);
resonator2(1) = resonator1(1);
resonator2(2) = -ak(1)*resonator2(1) + resonator1(2);
for i = 3:length(voiced)
    resonator2(i) = resonator1(i) - ak(1)*resonator2(i-1) - ak(2)*resonator2(i-2);  
end

% Subtracting mean
N = round((fs*0.010 - 2)/2);
fin_sig = zeros(length(resonator2),1);
for i = 1:length(resonator2)
    start = max(1,i-N);
    en = min(i+N,length(resonator2));
    fin_sig(i) = resonator2(i) - mean(resonator2(start:en));
end

subplot(311);
plot(voiced);
title('Voiced segment');

subplot(312);
plot(difference_voiced);
title('Differenced signal');

subplot(313);
plot(resonator2);
title('Output of Cascaded Resonators');

figure;
subplot(211);
plot(voiced(1:1500));
title('Voiced segment');
subplot(212)
plot(fin_sig(1:1500));
title('ZFF signal (Compared with Voiced segment)');