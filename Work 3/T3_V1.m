%% Begin
clear all
close all
clc

NMec = 79970;

[t, vi, vo_r] = GetReferenceSignals(NMec);
figure
hold on
plot(t,vi,t,vo_r)
legend('Input','Output')
xlabel('Time (s)')
ylabel('Amplitude (V)')

N = length(t);

L = 10e-3:(20e-3-10e-3)/(N-1):20e-3;
C = 10e-6:(20e-6-10e-6)/(N-1):20e-6;
T1 = 1.0:(1.5-1.0)/(N-1):1.5;

%% Nedler Mead Simplex
ErrFunc = @(theta) ((vo_r-Circuit(vi,t,theta(1),theta(2),theta(3)))'*(vo_r-Circuit(vi,t,theta(1),theta(2),theta(3))));
L0 = L(randperm(length(L),1));
C0 = C(randperm(length(C),1));
T10 = T1(randperm(length(T1),1));
x0 = [L0, C0, T10];

Err_x0 = Circuit(vi,t,x0(1),x0(2),x0(3))-vo_r;
NMSE_x0 = 20*log10(sqrt((1/N)*sum((Err_x0).^2))/(sqrt((1/N)*sum((Circuit(vi,t,x0(1),x0(2),x0(3))).^2))));

options = optimset('Display','final','TolFun',1,'TolX',1);
x = fminsearch(ErrFunc,x0,options);

Err_x = Circuit(vi,t,x(1),x(2),x(3))-vo_r;
NMSE_x = 20*log10(sqrt((1/N)*sum((Err_x).^2))/(sqrt((1/N)*sum((Circuit(vi,t,x(1),x(2),x(3))).^2))));

%% Gradiente Descente
Ranges = [min(L) max(L); min(C) max(C); min(T1) max(T1)];
Steps = [(20e-3-10e-3)/(N-1); (20e-6-10e-6)/(N-1); (1.5-1.0)/(N-1)];
threshold = 10e-10;
NrIter = 20;
[Param, Err] = GradientDescent1(x, Ranges, ErrFunc, Steps, threshold, NrIter);

Err_Final = Circuit(vi,t,Param(end,1),Param(end,2),Param(end,3))-vo_r;
NMSE_Final = 20*log10(sqrt((1/N)*sum((Err_Final).^2))/(sqrt((1/N)*sum((Circuit(vi,t,Param(end,1),Param(end,2),Param(end,3)).^2)))));

%--------------
vo = Circuit(vi, t, x0(1), x0(2), x0(3));
figure
hold on
plot(t,vo,t,vo_r)
legend('Model','Real')

figure
hold on
plot(t,Err_x0)
xlabel('Time (s)')
ylabel('Amplitude (V)')
%--------------
%--------------
vo = Circuit(vi, t, x(1), x(2), x(3));
figure
hold on
plot(t,vo,t,vo_r)
legend('Model','Real')

figure
hold on
plot(t,Err_x)
xlabel('Time (s)')
ylabel('Amplitude (V)')
%--------------
%--------------
vo = Circuit(vi, t, Param(end,1), Param(end,2), Param(end,3));
figure
hold on
plot(t,vo,t,vo_r)
legend('Model','Real')
xlabel('Time (s)')
ylabel('Amplitude (V)')

figure
hold on
plot(t,Err_Final)
xlabel('Time (s)')
ylabel('Amplitude (V)')