clear all;
close all;
clc;
%bits = input('Enter bit sequence: ');
bits = [0 0 0 1 0 0 1 0 1 1 1 0 1 0];
bitrate = 1;
n = 1000;
T = length(bits)/bitrate;
N = n*length(bits);
dt = T/N;
t = 0:dt:T-dt;

last = -1;
current = 0;
%Encoding 
x = zeros(1,length(t));
for i=1:length(bits)
  if bits(i) == 0
      x((i-1)*n+1:i*(n)) = current;
  elseif (bits(i) == 1 && current ~= 0)
      x((i-1)*n+1:i*(n)) = 0;
      current = 0;
  else
      x((i-1)*n+1:i*(n)) = -last;
      last = -last;
      current = last;
  end
end
subplot(2, 1, 1);
plot(t, x, 'Linewidth', 3);
axis([0,length(bits),-2,2]);
title('Encoded signal (POLAR NRZ-L)');
xlabel('Time','fontweight','bold','fontsize',12);
ylabel('Amplitude','fontweight','bold','fontsize',12);
disp('NRZ-L Encoding:');
grid on;
disp(x);

%decoding
counter = 0;
previous_value = 0;
for i = 1 : length(t)
  if t(i) > counter
    counter = counter + 1;
    if (x(i) == previous_value)
        result(counter) = 0;
        previous_value = x(i);
    else
        result(counter) = 1;
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