clc;
close all;
clear all;

t = 0:0.001:1;
N = length(t);

% modulating signal
fm = 2;   %modulating signal frequency
am = 2;   % amplidude of modulating signal
msg = am * sin(2 * pi * fm * t);   % it can be a composite signal
subplot(4,1,1);
plot(t, msg);
axis([0, 1, -am-1, am+1]);
title('Message Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;

%generates Career Signals
fc = 100;
ac = 5;
carrier = ac * sin(2 * pi * fc * t);
subplot(4,1,2);
plot(t, carrier);
axis([0, 1, -ac-1, ac+1]);
title('Carrier Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;

%modulated Signal
modulated_signal = (ac + msg) .* carrier; % ensure that the modulating signal is positive
subplot(4,1,3);
plot(t, modulated_signal);
%axis([0, 1, -(ac*am), ac*am]);
title('Modulated Signal');
hold on;
xlabel('Time');
ylabel('Amplitude');
grid on;

% generates demodulating signal
demodulated_signal = (modulated_signal ./ carrier) - ac;
subplot(4,1,4);
plot(t, demodulated_signal);
title('Demodulated Signal');
axis([0, 1, -am-1, am+1]);
xlabel('Time');
ylabel('Amplitude');
grid on

