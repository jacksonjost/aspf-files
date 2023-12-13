clear; clc;
[noisySignal, Fs] = audioread('OG_GarageDoorVoice.wav');
[baseSignal, ~] = audioread('OG_BaseAudio.wav');

minLength = min(length(noisySignal), length(baseSignal));
noisySignal = noisySignal(1:minLength);
baseSignal = baseSignal(1:minLength);

N = length(noisySignal);
fftNoisy = fft(noisySignal, N);
fftBase = fft(baseSignal, N);

fftNoise = fftNoisy - fftBase;

noiseSignal = real(ifft(fftNoise));

noiseReducedSignal = noisySignal - noiseSignal;

% Plots
t = (0:N-1)/Fs;

figure;
subplot(3,1,1);
plot(t, noisySignal);
title('Noisy Signal');

subplot(3,1,2);
plot(t, noiseSignal);
title('Extracted Noise');

subplot(3,1,3);
plot(t, noiseReducedSignal);
title('Noise Reduced Signal');

% FFT Plots
f = Fs*(0:(N/2))/N;

figure;
subplot(3,1,1);
plot(f, abs(fftNoisy(1:N/2+1)));
title('FFT of Noisy Signal');

subplot(3,1,2);
plot(f, abs(fftNoise(1:N/2+1)));
title('FFT of Extracted Noise');

subplot(3,1,3);
fftNoiseReduced = fft(noiseReducedSignal, N);
plot(f, abs(fftNoiseReduced(1:N/2+1)));
title('FFT of Noise Reduced Signal');

% MSE
mseValue = immse(noiseReducedSignal, baseSignal);
disp(['MSE between base and noise-reduced signals: ', num2str(mseValue)]);

% SNR
signalPower = bandpower(baseSignal);
noisePower = bandpower(noiseSignal);
snrValue = 10 * log10(signalPower / noisePower);
disp(['SNR of the noise-reduced signal: ', num2str(snrValue), ' dB']);
noiseReducedSignalPower = bandpower(noiseReducedSignal);
improvementSNR = 10 * log10(noiseReducedSignalPower / noisePower) - snrValue;
disp(['Improvement in SNR: ', num2str(improvementSNR), ' dB']);

%audiowrite('FSSFiltered_GarageDoorVoice.wav', noiseReducedSignal, Fs);