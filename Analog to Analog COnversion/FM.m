clc;
close all;
clear all;

%modulating signal
fm = 4;
am = 7;
t = 0 : 0.001 : 3;
msg = am .* sin (2 * pi * fm * t);
subplot(4,1,1);
plot(t, msg);
title('Message Signal');
axis([0, 3, -am-1, am+1]);
title('Modulating signal');
xlabel('Time');
ylabel('Amplitude');
grid on;

%career signal
fc = 30;
ac = 10;
carrier = ac .* sin (2 * pi * fc * t);
subplot(4, 1, 2);
plot(t, carrier);
title('Carrier Signal');
axis([0, 3, -ac-1, ac+1]);
title('Modulating signal');
xlabel('Time');
ylabel('Amplitude');
grid on;

%modulated signal
modulated_signal = ac * sin (2 * pi * fc * t + msg); %Frequency changing w.r.t Message
subplot(4,1,3);
plot(t, modulated_signal);
axis([0, 3, -ac-1, ac+1]);
title('Modulated Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;

%demodulated signal (Butterworth Filter)
x = abs(diff(modulated_signal));
filterOrder = 10;  
cutoffFrequency = 0.025; % Cutoff frequency (normalized)
[a, b] = butter(filterOrder, cutoffFrequency);
demodulated_signal = filter(a, b, x);
subplot(4, 1, 4);
plot(demodulated_signal);
title('Demodulated Signal');
xlabel('Time');
ylabel('Amplitude');
ylim([-1,3]);
grid on;

