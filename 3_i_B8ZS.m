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
counter = 0;
lastbit = -1;

%Encoding
for i=1:length(bits)
  if bits(i)==0
    counter = counter + 1;
    if counter==8
      x((i-1-4)*n+1:(i-4)*n) = lastbit;
      x((i-1-3)*n+1:(i-3)*n) = -lastbit;
      lastbit = -lastbit;
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
subplot(2,1,1);
plot(t, x, 'Linewidth', 3);
axis([0, length(bits), -1.5, 1.5]);
title('Encoded Signal(Scrambling: B8ZS)');
xlabel('Time','fontweight','bold','fontsize',12);
ylabel('Amplitude','fontweight','bold','fontsize',12);
grid on;

%Decoding
counter = 0;
lastbit = -1;
for i = 1:length(t)
  if t(i)>counter
    counter = counter + 1;
    if x(i)==lastbit
      result(counter:counter+4) = 0;  % Decoded data
      counter = counter + 4;
    else
      if(x(i)==0)
        result(counter) = 0;   % Decoded data
      else
        result(counter) = 1;   % Decoded data
        lastbit = -lastbit;
      end
    end
  end
end
t1 = 0 : bitrate : length(bits)-1;
subplot(2,1,2);
stem(t1, result, 'Linewidth', 3);
axis([0, length(bits)-1, -1.5, 1.5]);
title('Decocoded Digital Data(Scrambling: B8ZS)');
xlabel('Time','fontweight','bold','fontsize',12);
ylabel('Amplitude','fontweight','bold','fontsize',12);
grid on;
disp('B8ZS Decoding:');
disp(result);