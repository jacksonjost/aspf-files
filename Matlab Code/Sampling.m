clear; clc;
f = 5;
fs = 30;
duration = 1;
t = 0:0.001:duration;
ts = 0:1/fs:duration;

A = 1;
continuous_signal = A * sin(2 * pi * f * t);

sampled_signal = A * sin(2 * pi * f * ts);

plot(t, continuous_signal, 'black-');
hold on;
plot(ts, sampled_signal, 'ro');
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Continuous vs. Sampled');
legend('Continuous Signal', 'Sampled Signal Points');
grid on;
