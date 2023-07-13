clear all;
close all;
clc;

bits = [1 0 1 1 0 1 0 0];
n = 1000;
% plot the digital signal
N = length(bits);
t = 0 : 1/n : N;
%digital signal
x = zeros(1,length(t));
for i = 1:length(bits)
  if bits(i) == 1
    x((i-1)*n+1 : i*n)  = 1;
 end
end
subplot(4,1,1);
plot(t, x, 'linewidth', 2);
axis([0, N, -1, 2]);
title('Digital signal')
xlabel('Time');
ylabel('Amplitude');
grid on;

a = 5;
%plot the first career signal
f1 = 1;
sig1 = a .* sin(2 * pi * f1 * t);
subplot(4, 1, 2);
plot(t, sig1);
axis([0, N, -a-1, a+1]);
title('First Career Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;

%plot the second career signal
f2 = 5;
sig2 = a .* sin(2 * pi * f2 * t);
subplot(4, 1, 3);
plot(t, sig2);
axis([0, N, -a-1, a+1]);
title('Second Career Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;

% generates modulated signal
modu_sig = zeros(1, length(t));
for i = 1 : N
    if bits(i) == 0
        modu_sig((i-1)*n+1 : i*n)  = sig1((i-1)*n+1 : i*n);
    else 
        modu_sig((i-1)*n+1 : i*n)  = sig2((i-1)*n+1 : i*n);
    end
end
subplot(4, 1, 4);
plot(t, modu_sig);
axis([0, N, -a-1, a+1]);
title('FSK: Modulated Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;

%demodulation
index = 0;
result = zeros(1, N);
for i = 1 : length(t)
    if(t(i) > index)
        index = index + 1;
        if modu_sig((index-1)*n+1 : index*n) == sig1((index-1)*n+1 : index*n)
            result(index)=1;
        end
    end
end

disp(result);



