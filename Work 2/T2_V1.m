%% Beginning
close all
clear all
clc

%% Start
NMec = 79970;
N = 10000;
TMax = 1;

f1 = 5000;
A1 = 1;
f2 = 3000;
A2 = 1;

fmin = min(f1,f2);
fmax = max(f1,f2);
Fs = fmax;
Ts = 1/(100*Fs);
t = (Ts:Ts:TMax)';

%% Signals
x1 = A1*sin(2*pi*f1*t);
x2 = A2*sin(2*pi*f2*t);

x = x1 + x2;
y = SystemWA02(x,t,NMec);

fmin = min(f1,f2);
fmax = max(f1,f2);

figure(1)
hold on
plot(t,x,t,y)
plot([0 length(x)],[0 0],'k')
xlim([0 (5/fmin)])
legend('Input','Output')

figure(2)
subplot(2,1,1)
hold on
x_fft = abs(fft(x));
x_fft = x_fft(1:(length(x_fft)));
stem(x_fft)
xlim([0 2*fmax])
xlabel('Frequency (Hz)')
ylabel('|X(f)|')
text(fmin,x_fft(fmin+1),'  <- f1')  % Designation of Symbol 1
text(fmax,x_fft(fmax+1),'  <- f2')  % Designation of Symbol 1

subplot(2,1,2)
y_fft = abs(fft(y));
y_fft = y_fft(1:(length(y_fft)));
stem(y_fft)
xlim([0 5*fmax])
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

Int = (fmax-fmin)/2;

figure(3)
subplot(2,2,1)
hold on
plot(y_fft)
xlim([fmin-Int fmax+Int])
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
title('f')

subplot(2,2,2)
hold on
plot(y_fft)
xlim([(2*fmin)-Int (2*fmax)+Int])
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
title('2f')

subplot(2,2,3)
hold on
plot(y_fft)
xlim([(3*fmin)-Int (3*fmax)+Int])
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
title('3f')

subplot(2,2,4)
hold on
plot(y_fft)
xlim([(4*fmin)-Int (4*fmax)+Int])
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
title('4f')

% text(fmin,y_fft(fmin+1),'  <- f1')  % Designation of Symbol 1
% text(fmax,y_fft(fmax+1),'  <- f2')  % Designation of Symbol 1
% 
% text(2*fmin,y_fft(2*fmin+1),'  <- 2*f1')  % Designation of Symbol 1
% text(2*fmax,y_fft(2*fmax+1),'  <- 2*f2')  % Designation of Symbol 1
% 
% text(3*fmin,y_fft(3*fmin+1),'  <- 3*f1')  % Designation of Symbol 1
% text(3*fmax,y_fft(3*fmax+1),'  <- 3*f2')  % Designation of Symbol 1
% 
% text(4*fmin,y_fft(4*fmin+1),'  <- 4*f1')  % Designation of Symbol 1
% text(4*fmax,y_fft(4*fmax+1),'  <- 4*f2')  % Designation of Symbol 1
% %% Gain
% j = 1;
% for i=10:10:10000
%     x = A1*sin(2*pi*i*t)+A2*sin(2*pi*i*t);
%     y = SystemWA02(x,t,NMec);
%     Av(j) = 20*log10(max(y)/max(x));
%     j = j + 1;
% end
% 
% f=10:10:10000;
% 
% figure(3)
% hold on
% plot(f,Av)
% xlabel('Frequency (Hz)')
% ylabel('Gain (dB)')
% hline = refline(0, 0);
% hline.Color = 'k';