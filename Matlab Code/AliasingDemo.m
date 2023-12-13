clear; clc;
[originalSignal, Fs] = audioread('OG_BaseAudio.wav');

if size(originalSignal, 2) == 2
    originalSignal = mean(originalSignal, 2);
end

% Downsample the signal to introduce aliasing
downsampleFactor = 2;
aliasedSignal = downsample(originalSignal, downsampleFactor);

L_original = length(originalSignal);
Y_original = fft(originalSignal);
P2_original = abs(Y_original/L_original);
P1_original = P2_original(1:L_original/2+1);
P1_original(2:end-1) = 2*P1_original(2:end-1);
f_original = Fs*(0:(L_original/2))/L_original;

L_aliased = length(aliasedSignal);
Y_aliased = fft(aliasedSignal);
P2_aliased = abs(Y_aliased/L_aliased);
P1_aliased = P2_aliased(1:L_aliased/2+1);
P1_aliased(2:end-1) = 2*P1_aliased(2:end-1);
f_aliased = (Fs/downsampleFactor)*(0:(L_aliased/2))/L_aliased;

figure;
subplot(2,1,1);
plot(f_original, P1_original);
title('Original Signal FFT');
xlabel('Frequency (Hz)');
ylabel('|P1(f)|');

subplot(2,1,2);
plot(f_aliased, P1_aliased);
title('Aliased Signal FFT');
xlabel('Frequency (Hz)');
ylabel('|P1(f)|');

% Error
%interpolatedAliasedSignal = interp1(1:length(aliasedSignal), aliasedSignal, linspace(1, length(aliasedSignal), length(originalSignal)));
%aliasingError = norm(originalSignal - interpolatedAliasedSignal) / norm(originalSignal);
%disp(['Aliasing Error: ', num2str(aliasingError)]);

