clear; clc;
[signal, fs] = audioread('OG_BaseAudio.wav');

cutoffFreq = 5000; 
order = 4; 
Wn = cutoffFreq / (fs / 2);

[filterB, filterA] = butter(order, Wn, 'low');
filteredSignal = filter(filterB, filterA, signal);

startTime = 1;
endTime = 1.5;

startIndex = round(startTime * fs);
endIndex = round(endTime * fs);

figure;
set(gcf, 'Position', [100, 100, 1200, 400]);

subplot(1,2,1);
plot((startIndex:endIndex)/fs, signal(startIndex:endIndex));
title('Original Signal (Part)');
xlabel('Time (seconds)');
ylabel('Amplitude');

hold on;

plot((startIndex:endIndex)/fs, filteredSignal(startIndex:endIndex));
title('Original and Filtered Signal (Part)');
xlabel('Time (seconds)');
ylabel('Amplitude');

hold off;

N = endIndex - startIndex + 1;
f = fs*(0:(N/2))/N;
originalFFT = abs(fft(signal(startIndex:endIndex)));
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
