clc; clear all; close all;
t0 = 0 : 0.001 : 1;
A1 = 10;
A2 = 20;
A3 = 40;

f1 = 4;
f2 = 8;
f3 = 16; % fm = 16 Hz
%Original signal
y0 = A1 * sin(2 * pi * f1 * t0);
subplot(3,2,1);
plot(t0, y0);
xlabel('time');
ylabel('y');
title('Composite Signal (fm = 16Hz)');

%After sampling of the original signal at nyquist rate
fs = 16; %nyquist rate fs = 2*fm (here fm = 16)
ts = 1/fs; %nyquist interval 1 / fs
t1 = 0:ts:1;
y1 = A1 * sin(2 * pi * f1 * t1);
subplot(3,2,2);
hold on;
plot(t0, y0, t1, y1);
xlabel('t');
ylabel('y');
title('sampling at nyquist rate (fs = 32 Hz)')
