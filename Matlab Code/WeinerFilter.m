clear; clc;
[noisySignal, fs] = audioread('OG_GarageDoorVoice.wav');
[cleanSignal, ~] = audioread('OG_BaseAudio.wav');

minLength = min(length(noisySignal), length(cleanSignal));
noisySignal = noisySignal(1:minLength);
cleanSignal = cleanSignal(1:minLength);

filteredSignal = wiener2(noisySignal, [5 5]);

fftNoisy = fft(noisySignal);
fftFiltered = fft(filteredSignal);
fftClean = fft(cleanSignal);
f = fs*(0:(length(noisySignal)/2))/length(noisySignal);

% Plot signals
figure;
subplot(3,1,1);
plot(noisySignal);
title('Noisy Signal');
subplot(3,1,2);
plot(filteredSignal);
title('Filtered Signal');
subplot(3,1,3);
plot(cleanSignal);
title('Original Clean Signal');

% Plot FFT
figure;
subplot(3,1,1);
plot(f, abs(fftNoisy(1:length(noisySignal)/2+1)));
title('Noisy Signal');
subplot(3,1,2);
plot(f, abs(fftFiltered(1:length(filteredSignal)/2+1)));
title('Filtered Signal');
subplot(3,1,3);
plot(f, abs(fftClean(1:length(cleanSignal)/2+1)));
title('Original Clean Signal');

% MSE
mse = immse(filteredSignal, cleanSignal);
fprintf('MSE: %f\n', mse);

% SNR
snr_before = snr(cleanSignal, noisySignal - cleanSignal);
snr_after = snr(cleanSignal, filteredSignal - cleanSignal);
fprintf('SNR Before Filtering: %f\n', snr_before);
fprintf('SNR After Filtering: %f\n', snr_after);
%audiowrite('WeinerFiltered_GarageDoorVoice.wav', filteredSignal, fs);