clear; clc;
fs = 1000;
duration = 1;
f = 5;
phases = [0, pi/4, pi/2];

t = 0:1/fs:duration;

figure;
hold on;

for i = 1:length(phases)
    signal = sin(2*pi*f*t + phases(i));
    
    plot(t, signal, 'DisplayName', ['Phase = ' num2str(phases(i)) ' rad']);
end

title('Different Phases');
xlabel('Time (seconds)');
ylabel('Amplitude');
grid on;
legend;
hold off;
print('HighResPlot', '-dpng', '-r300');
