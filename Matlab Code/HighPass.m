clear; clc;
[originalSignal, Fs] = audioread('OG_BaseAudio.wav');

cutoffFreq = 300;
order = 6;
[filterB, filterA] = butter(order, cutoffFreq/(Fs/2), 'high');

filteredSignal = filter(filterB, filterA, originalSignal);

% Time plots
figure;
subplot(2,1,1);
plot((1:length(originalSignal))/Fs, originalSignal);
title('Original Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');

subplot(2,1,2);
plot((1:length(filteredSignal))/Fs, filteredSignal);
title('Filtered Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');

% FFT plots
N = length(originalSignal);
f = Fs*(0:(N/2))/N;
originalFFT = abs(fft(originalSignal));
filteredFFT = abs(fft(filteredSignal));

figure;
subplot(2,1,1);
plot(f, originalFFT(1:N/2+1));
title('FFT of Original Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(2,1,2);
plot(f, filteredFFT(1:N/2+1));
title('FFT of Filtered Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

% audiowrite('HighPassFiltered_OG_BaseAudio.wav', filteredSignal, Fs, 'BitsPerSample', 16);
