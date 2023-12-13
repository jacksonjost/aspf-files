clear; clc;
[originalSignal, Fs] = audioread('OG_BaseAudio.wav');

notchFreq = 500;
bandwidth = 100;
Wn = [(notchFreq - bandwidth/2)/(Fs/2), (notchFreq + bandwidth/2)/(Fs/2)]; % Normalize
[b, a] = butter(2, Wn, 'stop');
filteredSignal = filter(b, a, originalSignal);

% Time Plot
t = (0:length(originalSignal)-1)/Fs;
subplot(2,1,1);
plot(t, originalSignal);
title('Original Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');
subplot(2,1,2);
plot(t, filteredSignal);
title('Filtered Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');

% FFT Plot
N = length(originalSignal);
f = Fs*(0:(N/2))/N;
originalSignalFFT = abs(fft(originalSignal));
filteredSignalFFT = abs(fft(filteredSignal));
figure;
subplot(2,1,1);
plot(f, originalSignalFFT(1:N/2+1));
title('FFT of Original Signal');
xlabel('Frequency (Hz)');
ylabel('|Magnitude|');
subplot(2,1,2);
plot(f, filteredSignalFFT(1:N/2+1));
title('FFT of Filtered Signal');
xlabel('Frequency (Hz)');
ylabel('|Magnitude|');

% audiowrite('NotchFiltered_BaseAudio.wav', filteredSignal, fs);
