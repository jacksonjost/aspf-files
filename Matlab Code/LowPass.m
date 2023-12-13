clear; clc;
[signal, fs] = audioread('OG_BaseAudio.wav');

cutoffFreq = 5000; 
order = 4; 
Wn = cutoffFreq / (fs / 2);

[filterB, filterA] = butter(order, Wn, 'low');
filteredSignal = filter(filterB, filterA, signal);

% Time plots
t = (0:length(signal)-1) / fs;

figure;
subplot(2, 1, 1);
plot(t, signal);
title('Original Signal - Time Domain');
xlabel('Time (seconds)');
ylabel('Amplitude');

subplot(2, 1, 2);
plot(t, filteredSignal);
title('Filtered Signal - Time Domain');
xlabel('Time (seconds)');
ylabel('Amplitude');

% FFT Plots
N = length(signal);

% Compute FFT
fft_original = fft(signal, N);
fft_filtered = fft(filteredSignal, N);

f = fs * (0:(N/2)) / N;

P1_original = abs(fft_original / N);
P1_filtered = abs(fft_filtered / N);

figure;
subplot(2, 1, 1);
plot(f, P1_original(1:N/2+1));
title('FFT of Original Signal');
xlabel('Frequency (Hz)');
ylabel('|P1(f)|');

subplot(2, 1, 2);
plot(f, P1_filtered(1:N/2+1));
title('FFT of Filtered Signal');
xlabel('Frequency (Hz)');
ylabel('|P1(f)|');

% audiowrite('LowPassFiltered_BaseAudio.wav', filteredSignal, fs);
