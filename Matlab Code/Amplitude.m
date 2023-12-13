clear; clc;
fs = 1000;
duration = 1;
f = 5;
amplitudes = [1, 2, 3];

t = 0:1/fs:duration;

figure;
hold on;

for i = 1:length(amplitudes)
    signal = amplitudes(i) * sin(2*pi*f*t);
    
    plot(t, signal, 'DisplayName', ['Amplitude = ' num2str(amplitudes(i))]);
end

title('Different Amplitudes');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;
legend;
hold off;
print('HighResPlot', '-dpng', '-r300');