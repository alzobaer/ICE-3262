clear all;
close all;
clc;
%bits = input('Enter bit sequence: ');
bits = [0 1 0 0 1 1 1 0];
bitrate = 1;
n = 1000;
T = length(bits)/bitrate;
N = n*length(bits);
dt = T/N;
t = 0:dt:T-dt;
x = zeros(1,length(t));
lastbit = 1;

%Encoding
for i = 1 : length(bits)
  if bits(i) == 1
    x((i-1)*n+1:i*n) = -lastbit;
    lastbit = -lastbit;
  else x((i-1)*n+1:i*n) = lastbit;
  end
end
subplot(2, 1, 1);
plot(t, x, 'Linewidth', 3);
axis([0,length(bits),-2,2]);
title('Encoded signal (POLAR NRZ-I)');
xlabel('Time','fontweight','bold','fontsize',12);
ylabel('Amplitude','fontweight','bold','fontsize',12);
disp('NRZ-I Encoding:');
grid on;
disp(x);




%decoding
counter = 0;
previous_value = 1;
for i = 1 : length(t)
  if t(i) > counter
    counter = counter + 1;
    if (x(i) == previous_value)
        result(counter) = ~previous_value;
        previous_value = x(i);
    else
        result(counter) = previous_value;
        previous_value = x(i);
    end
  end
end
for i = 1 : length(bits)
   if result(i) == -1
        result(i) = 1;
   end
end
t1 = 0 : bitrate : length(bits)-1;
subplot(2, 1, 2);
stem(t1, result, 'Linewidth', 3);
axis([0,length(bits) - 1,-2,2]);
title('Decocoded Digital Data (POLAR NRZ-I)');
xlabel('Time','fontweight','bold','fontsize',12);
ylabel('Amplitude','fontweight','bold','fontsize',12);
grid on;

disp('NRZ-L Decoding:');
disp(result);