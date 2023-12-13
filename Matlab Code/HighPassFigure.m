clear; clc;
[originalSignal, Fs] = audioread('OG_BaseAudio.wav');

cutoffFreq = 300;
order = 6;
[filterB, filterA] = butter(order, cutoffFreq/(Fs/2), 'high');

filteredSignal = filter(filterB, filterA, originalSignal);

startTime = 1;
endTime = 1.5;

startIndex = round(startTime * Fs);
endIndex = round(endTime * Fs);

figure;
set(gcf, 'Position', [100, 100, 1200, 400]);

subplot(1,2,1);
plot((startIndex:endIndex)/Fs, originalSignal(startIndex:endIndex));
title('Original Signal (Part)');
xlabel('Time (seconds)');
ylabel('Amplitude');

hold on;

plot((startIndex:endIndex)/Fs, filteredSignal(startIndex:endIndex));
title('Original and Filtered Signal (Part)');
xlabel('Time (seconds)');
ylabel('Amplitude');

hold off;

N = endIndex - startIndex + 1;
f = Fs*(0:(N/2))/N;
originalFFT = abs(fft(originalSignal(startIndex:endIndex)));
filteredFFT = abs(fft(filteredSignal(startIndex:endIndex)));

subplot(1,2,2);
plot(f, originalFFT(1:N/2+1));
title('FFT of Original Signal (Part)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

hold on;

plot(f, filteredFFT(1:N/2+1));
title('FFT of Original and Filtered Signal (Part)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

hold off;
