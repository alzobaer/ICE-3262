clear all;
close all;
clc;
%bits = input('prompt');
bits = [0 1 0 0 1 0 1 1];
bitrate = 1;
n = 1000;
T = length(bits)/bitrate;
N = n*length(bits);
dt = T/N;
t = 0:dt:T;
x = zeros(1,length(t));
%Encoding
for i=1:length(bits)
  if bits(i)==1
    x((i-1)*n+1:(i-1)*n+n/2) = 1;
  else x((i-1)*n+1:(i-1)*n+n/2) = -1;
  end
end
subplot(2, 1, 1);
plot(t, x, 'Linewidth', 3);
axis([0,length(bits),-2,2]);
title('Encoded signal (POLAR-RZ)');
xlabel('Time','fontweight','bold','fontsize',12);
ylabel('Amplitude','fontweight','bold','fontsize',12);
disp('NRZ-I Encoding:');
grid on;
disp(x);

%Decding

counter = 0;
for i = 1 : length(t)
  if t(i)> counter
    counter = counter + 1;
    if x(i) < 0
        result(counter) = 0;
    else
        result(counter) = 1;
    end
  end
end
t1 = 1 : bitrate : length(bits);
subplot(2, 1, 2);
stem(t1, result, 'Linewidth', 3);
axis([0,length(bits),-2,2]);
title('Decocoded Digital Data (POLAR-RZ)');
xlabel('Time','fontweight','bold','fontsize',12);
ylabel('Amplitude','fontweight','bold','fontsize',12);
grid on;

disp('NRZ-L Decoding:');
disp(result);