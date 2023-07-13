clear all;
close all;
clc;

%bits = input('prompt');
bits = [0 1 0 0 1 1 0 1];
bitrate = 1;
n = 1000;
T = length(bits)/bitrate;
N = n*length(bits);
dt = T/N;
t = 0:dt:T-dt;
x = zeros(1,length(t));

%encoding
for i=1:length(bits)
  if bits(i)==1
    x((i-1)*n+1:(i-1)*n+n/2) = -1;
    x((i-1)*n+n/2:i*n) = 1;
  else
    x((i-1)*n+1:(i-1)*n+n/2) = 1;
    x((i-1)*n+n/2:i*n) = -1;
  end
end
subplot(2, 1, 1);
plot(t, x, 'Linewidth', 3);
axis([0, length(bits), -2, 2]);
title('Encoded signal (Polar-Biphase: Manchester)');
xlabel('Time','fontweight','bold','fontsize',12);
ylabel('Amplitude','fontweight','bold','fontsize',12);
grid on;

%Decoding
counter = 0;
for i = 1:length(t)
  if t(i)>counter
    counter = counter + 1;
    if x(i)>0
        result(counter) = 0;
    else
        result(counter) = 1;
    end
  end
end
subplot(2, 1, 2);
t1 = 0 : bitrate : length(bits) - 1;
stem(t1, result, 'linewidth', 3);
axis([0, length(bits)-1, -2, 2]);
title('Decoded Digital Data (Polar-Biphase: Manchester)');
xlabel('Time','fontweight','bold','fontsize',12);
ylabel('Amplitude','fontweight','bold','fontsize',12);
grid on;
disp('Manchester Decoding:');
disp(result);