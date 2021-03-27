[inp,Fs] = audioread('A2.wav');

%Vowel region
vowel_reg = inp(1.69*Fs:1.89*Fs);
t = (1.69:1/Fs:1.89);

subplot(411);
plot(t,vowel_reg);
title('Vowel region');

%Duration
vowel_reg_duration = length(vowel_reg);
fprintf("Duration : %d\n",(vowel_reg_duration/Fs));

%Energy
vowel_reg_energy = vowel_reg.*vowel_reg;

subplot(412);
plot(t,vowel_reg_energy);
title('Intensity/Energy');

subplot(413);
plot(t,20*log10(vowel_reg_energy));
title('Log of energy');

%Intonation
f0 = pitch(vowel_reg,Fs);
average_pitch = mean(f0);

subplot(414);
plot(f0);
title('Pitch contour (Intonation)');

fprintf("Average Pitch : %d\n",average_pitch);