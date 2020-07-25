%% Trabalho 1 - Transistor
clear all
close all
clc
N = 100000;
NumMec = 79970;
opt = tfestOptions('EnforceStability',true);
Amp = 1;

v_signal = Amp*ones(1,N);
v_zeros = zeros(1,N);
v_signal(1:round(0.01*N)) = 0;

%% 1º Sistema
% Buscar Parâmetros
h = 12e-10;
t = linspace(0,h*N,N);

[~, vgs_vi] = TransistorTest_IS(v_signal, v_zeros, h, NumMec);

d1 = iddata(vgs_vi', v_signal', h);
sys1 = tfest(d1, 1, 0, opt);
% sys1 = c2d(sys1,h);
% sys1.Denominator(2)

%Testar Parâmetros
v_test = Amp*sin(2*pi*(2/h)*t)+Amp*sin(20*pi*(2/h)*t);

[~, vgs_vi] = TransistorTest_IS(v_test, v_zeros, h, NumMec); %Vo = 0

[y_sys1,~] = lsim(sys1,v_test,t);

figure
subplot(3,1,1)
hold on
plot(t,vgs_vi,'b',t,y_sys1','r')
title('Vgs/Vi')
legend('Função','Modelo')
ylabel('Voltage (V)')
xlabel('Time (s)')

vgs_vi = vgs_vi';

Err_sys1 = y_sys1-vgs_vi;
EMod_sys1 = (Err_sys1'*Err_sys1)/length(Err_sys1);
NMSE_sys1 = 20*log10(sqrt((1/N)*sum((Err_sys1).^2))/(sqrt((1/N)*sum((y_sys1).^2))));

%% 2º Sistema
h = 23e-11;
t = linspace(0,h*N,N);

[vds_vi, vgs_vi] = TransistorTest_IS(v_signal, v_zeros, h, NumMec); %Vo = 0

d2 = iddata(vds_vi', vgs_vi', h);
sys2 = tfest(d2, 1, 0, opt);
% sys2 = c2d(sys2,h);
% sys2.Denominator(2)

%Testar Parâmetros
v_test = Amp*sin(2*pi*(2/h)*t)+Amp*sin(20*pi*(2/h)*t);

[vds_vi, vgs_vi] = TransistorTest_IS(v_test, v_zeros, h, NumMec); %Vo = 0

[y_sys2,~] = lsim(sys2,vgs_vi,t);

subplot(3,1,2)
plot(t,vds_vi,'b',t,y_sys2','r')
title('Vds/Vgs')
legend('Função','Modelo')
ylabel('Voltage (V)')
xlabel('Time (s)')

vgs_vi = vds_vi';

Err_sys2 = y_sys2-vgs_vi;
EMod_sys2 = (Err_sys2'*Err_sys2)/length(Err_sys2);
NMSE_sys2 = 20*log10(sqrt((1/N)*sum((Err_sys2).^2))/(sqrt((1/N)*sum((y_sys2).^2))));

%% 3º Sistema
h = 33e-11;
t = linspace(0,h*N,N);

[vds_vo, ~] = TransistorTest_IS(v_zeros, v_signal, h, NumMec); %Vi = 0

d3 = iddata(vds_vo', v_signal', h);
sys3 = tfest(d3, 1, 0, opt);
% sys3 = c2d(sys3,h);
% sys3.Denominator(2)

%Testar Parâmetros
v_test = Amp*sin(2*pi*(2/h)*t)+Amp*sin(20*pi*(2/h)*t);  

[vds_vi, vgs_vi] = TransistorTest_IS(v_test, v_zeros, h, NumMec); %Vo = 0
[vds_vo, vgs_vo] = TransistorTest_IS(v_zeros, v_test, h, NumMec); %Vi = 0

[y_sys3,~] = lsim(sys3,v_test,t);

subplot(3,1,3)
plot(t,vds_vo,'b',t,y_sys3','r')
title('Vds/Vo')
legend('Função','Modelo')
ylabel('Voltage (V)')
xlabel('Time (s)')

vds_vo = vds_vo';

Err_sys3 = y_sys3-vds_vo;
EMod_sys3 = (Err_sys3'*Err_sys3)/length(Err_sys3);
NMSE_sys3 = 20*log10(sqrt((1/N)*sum((Err_sys3).^2))/(sqrt((1/N)*sum((y_sys3).^2))));

%% Cálculo Parâmetros
cgs = 1/(50*sys1.Numerator);
cds = 1/(10*sys3.Numerator);
gm = -sys2.Numerator*cds;
E = 10*cds*sys3.Denominator(2);
ro = 10/(E-1);

%% Gráficos Erros
figure
subplot(3,1,1)
hold on
plot(Err_sys1)
title('Erro Vgs/Vi')
ylabel('Voltage (V)')
xlabel('Time (s)')
subplot(3,1,2)
plot(Err_sys2)
title('Erro Vds/Vgs')
ylabel('Voltage (V)')
xlabel('Time (s)')
subplot(3,1,3)
plot(Err_sys3)
title('Erro Vds/Vo')
ylabel('Voltage (V)')
xlabel('Time (s)')