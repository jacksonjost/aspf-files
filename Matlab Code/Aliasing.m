clear; clc;
t = 0:0.001:1;

f_original = 5;
signal_original = sin(2 * pi * f_original * t);

fs1 = 20; % Higher than Nyquist rate
fs2 = 8;  % Just below Nyquist rate
fs3 = 4;  % Much lower than Nyquist rate

t1 = 0:1/fs1:1;
t2 = 0:1/fs2:1;
t3 = 0:1/fs3:1;

signal_sampled1 = sin(2 * pi * f_original * t1);
signal_sampled2 = sin(2 * pi * f_original * t2);
signal_sampled3 = sin(2 * pi * f_original * t3);

figure;
subplot(4,1,1);
plot(t, signal_original, 'black');
title('Original Continuous Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');

subplot(4,1,2);
stem(t1, signal_sampled1, 'black');
title(['Sampled Signal at ' num2str(fs1) ' Hz']);
xlabel('Time (seconds)');
ylabel('Amplitude');

subplot(4,1,3);
stem(t2, signal_sampled2, 'black');
title(['Sampled Signal at ' num2str(fs2) ' Hz']);
xlabel('Time (seconds)');
ylabel('Amplitude');

subplot(4,1,4);
stem(t3, signal_sampled3, 'black');
title(['Sampled Signal at ' num2str(fs3) ' Hz']);
xlabel('Time (seconds)');
ylabel('Amplitude');

sgtitle('Demonstration of Aliasing');
