clear; clc;
%% NOT WORKING, FIX
[noisySignal, Fs] = audioread('OG_GarageDoorVoice.wav');
[baseSignal, ~] = audioread('OG_BaseAudio.wav');

% Voice Activity Detection (Basic Energy Threshold)
energyThreshold = 0.02;
frameLength = 256;
numFrames = floor(length(noisySignal)/frameLength);
noiseEstimate = zeros(size(noisySignal));

for k = 1:numFrames
    frameStart = (k-1)*frameLength + 1;
    frameEnd = k*frameLength;
    frame = noisySignal(frameStart:frameEnd);
    
    if mean(frame.^2) < energyThreshold
        noiseEstimate(frameStart:frameEnd) = frame;
    end
end

% Average the noise estimate
estimatedNoise = mean(noiseEstimate, 2);

% Noise Reduction - Match Lengths
if length(estimatedNoise) > length(noisySignal)
    estimatedNoise = estimatedNoise(1:length(noisySignal));
elseif length(estimatedNoise) < length(noisySignal)
    paddingLength = length(noisySignal) - length(estimatedNoise);
    estimatedNoise = [estimatedNoise; zeros(paddingLength, 1)];
end

N = length(noisySignal);
noiseReducedSignal = noisySignal - estimatedNoise;

% Plots
t = (0:N-1)/Fs;

figure;
subplot(3,1,1);
plot(t, noisySignal);
title('Noisy Signal');

subplot(3,1,2);
plot(t, estimatedNoise);
title('Extracted Noise');

subplot(3,1,3);
plot(t, noiseReducedSignal);
title('Noise Reduced Signal');

% FFT Plots
f = Fs*(0:(N/2))/N;
fftNoisy = fft(noisySignal, N);
fftNoise = fft(estimatedNoise, N);

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
disp(['Mean Squared Error (MSE) between base and noise-reduced signals: ', num2str(mseValue)]);

% SNR
signalPower = bandpower(baseSignal);
noisePower = bandpower(estimatedNoise);
snrValue = 10 * log10(signalPower / noisePower);
disp(['Signal to Noise Ratio (SNR) of the noise-reduced signal: ', num2str(snrValue), ' dB']);
noiseReducedSignalPower = bandpower(noiseReducedSignal);
improvementSNR = 10 * log10(noiseReducedSignalPower / noisePower) - snrValue;
disp(['Improvement in SNR: ', num2str(improvementSNR), ' dB']);
