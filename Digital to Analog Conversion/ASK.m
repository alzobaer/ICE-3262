clc;
clear all;
close all;

bits=[1 0 1 1 0 1 1 0];
n = 1000;

N = length(bits);
t = 0 : 1/n : N;
x=zeros(1,length(t));
for i = 1 : N
  if bits(i) == 1
    x((i-1)*n+1 : i*n)  = 1;
 end
end
subplot(3,1,1);
plot(t, x, 'linewidth', 3);
axis([0, length(bits), -1, 2]);
title('Digital Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;

a = 4;
f = 1;

sig = a .* sin ( 2 * pi * f * t);
subplot(3, 1, 2);
plot(t, sig, 'linewidth', 2);
axis([0, length(bits),  -a-1, a+1]);
title('Career Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;
grid on;

% Modulation
m = x .* sig;  %modulated analog signal
subplot(3, 1, 3);
plot(t, m, 'linewidth', 2);
axis([0, length(bits), -a-1, a+1]);
title('ASK: Modulated Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;

index=0;
res = zeros(1, N);
for i=1:length(t)
    if t(i)>index
        index=index+1;
        if m(i)~=0
            res(index)=1;
        end
    end
end
disp('modulated bits');
disp(res);