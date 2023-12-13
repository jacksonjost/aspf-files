clear; clc;
[signal, fs] = audioread('OG_BaseAudio.wav');

lowFreq = 500; 
highFreq = 3000;
filterOrder = 4;
[filterB, filterA] = butter(filterOrder, [lowFreq, highFreq]/(fs/2), 'bandpass');
filteredSignal = filter(filterB, filterA, signal);

% Time signals
t = (0:length(signal)-1)/fs;
subplot(2,1,1);
plot(t, signal);
title('Original Signal - Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot(t, filteredSignal);
title('Filtered Signal - Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');

% Plot FFT
n = length(signal);
f = fs*(0:(n/2))/n;

FFT_original = abs(fft(signal)/n);
FFT_filtered = abs(fft(filteredSignal)/n);

figure;
subplot(2,1,1);
plot(f, FFT_original(1:n/2+1));
title('Original Signal - Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('|Magnitude|');

subplot(2,1,2);
plot(f, FFT_filtered(1:n/2+1));
title('Filtered Signal - Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('|Magnitude|');

% audiowrite('BandPassFiltered_BaseAudio.wav', filteredSignal, fs);
