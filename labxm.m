clear all;
close all;
clc;

%bits = input('prompt');
bits = [1 0 0 0 0 0 0 0 0 1];
bitrate = 1;
n = 1000;
T = length(bits)/bitrate;
N = n*length(bits);
dt = T/N;
t = 0:dt:T-dt;
x = zeros(1,length(t));

%Encoding for Bipolar: AMI
lastbit = -1;
for i=1:length(bits)
  if bits(i)==1
    x((i-1)*n+1:i*n) = -lastbit;
    lastbit = -lastbit;
  end
end
subplot(2,1,1);
plot(t, x, 'Linewidth', 3);
axis([0, length(bits), -1.5, 1.5]);
title('Encoded signal (Bipolar: AMI)');
xlabel('Time','fontweight','bold','fontsize',12);
ylabel('Amplitude','fontweight','bold','fontsize',12);
grid on;




%Encoding for Scrambling: B8ZS
counter = 0;
lastbit = -1;
for i=1:length(bits)
  if bits(i)==0
    counter = counter + 1;
    if counter==8
      x((i-1-7)*n+1:(i-7)*n) = 0;
      x((i-1-6)*n+1:(i-6)*n) = 0;
      x((i-1-5)*n+1:(i-5)*n) = 0;
      x((i-1-4)*n+1:(i-4)*n) = lastbit;
      x((i-1-3)*n+1:(i-3)*n) = -lastbit;
      lastbit = -lastbit;
      x((i-1-2)*n+1:(i-2)*n) = 0;
      x((i-1-1)*n+1:(i-1)*n) = lastbit;
      x((i-1)*n+1:i*n) = -lastbit;
      lastbit = -lastbit;
      counter = 0;
    end
  else
    counter = 0;
    x((i-1)*n+1:i*n) = -lastbit;
    lastbit = -lastbit;
  end
end
subplot(2,1,2);
plot(t, x, 'Linewidth', 3);
axis([0, length(bits), -1.5, 1.5]);
title('Encoded Signal (Scrambling: B8ZS)');
xlabel('Time','fontweight','bold','fontsize',12);
ylabel('Amplitude','fontweight','bold','fontsize',12);
grid on;
