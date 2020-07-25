% IS - Trabalho pratico 2

close all
clear all
clc

NumMec = 79970;
N = 10000;
%Ts = 0.00000001;    %% sampling time
Ts =0.00001;
% Este tempo de amostragem significa que a frequencia para ser bem
% amostrada tem de ser no máximo f = (1/Ts)/2, que é a frequencia que verifica o
% teorema de nyquist, ou seja,1/f >= 2*Ts
% No entanto, verifica-se que apena para frequencia até 500 é que o sinal
% fica perfeitamente amostrado. Para testar este sistema não linear, apenas
% se irão usar frequencia entre 1Hz até 200 Hz, pois foi considerado que o f no máximo podia ser f=(1/Ts)/50 

% PIRES 
% Para fazer testes, sempre que alteras a frquencia dos sinais x1 e x2, tens de fazer 
% o seguinte:
% Escolhes um f1 e um f2. Pegas no valor mais alto destes dois e vais calcular o tempo de amostragem
% que precisas: Ts = 1/(f1*10) ou Ts = 1/(f2*10) -> escolhes entre o f1 e f2
% o que tiver o valor mais alto. Depois do Ts desta conta, escolhes um
% tempo de amostragem que seja inferior ao que deu na conta. Vamos usar
% sempre valores de 0.01, 0.001, 0.0001, 0.00001, etc...
% Por exemplo: se f1 = 88 Hz e f2 = 13 Hz:
% Ts = 1/(f1*2) = 1/(88*10) = 0.00113 -> entao escolhe-se um Ts que é menor que 0.00113, neste caso
% vai ficar Ts = 0.001! Mas para ser mais segura, acrescenta sempre mais 1
% zero. Entao Ts = 0.0001!!!!!
% Outro exemplo: se f1 = 80e3 Hz e f2 = 65e3 Hz:
% Ts = 1/(f1*2) = 1/(80e3*10) = 0.00000125 -> entao escolhe-se um Ts que é menor que 0.00000125, neste caso
% vai ficar Ts = 0.000001! Mas para ser mais segura, acrescenta sempre mais 1
% zero. Entao Ts = 0.0000001!!!!!
% Antes de tirares conclusoes, confirma sempre a figure(2), que tem a fft do sinal de entrada. 
% Tebs sempre que confirmar se as 2 riscas que aparecem correspondem à duas frequencias (f1 e f2) 
% que esco5lheste para os sinais. O N a partir de agora nunca é alterado!

Fa = 1/Ts;
n= 0:N-1;
t = (n./Fa)';
%freq = -Fa/2:Fa/N:(Fa-Fa/N)/2;
freq = 0:Fa/N:(Fa-Fa/N);
%cc =linspace(0, 1, fix(N/2)+1)*(Fa/2);
%%cc =linspace(0, 1, fix(N-1)+1)*(Fa/2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Signal 1
%f1 = 500e3;         %% frequency - 1/f1 deve ser duas vezes maior que Ts
f1 = 4000;
A1 = 1;          %% amplitude
x1 = A1*sin(2*pi*f1*t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Signal 2
%f2 = 200e3;         %% frequency
f2 = 1000;
%A2 = 0.8;          %% amplitude
A2 = 1.2;
x2 = A2*sin(2*pi*f2*t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Signal total 
x = x1 + x2;

% 9) Agora com A1 = 54 e A2 = 100 e f1 = 721 e f2 = 83. O sinal de saida
% satura claramente, ficando praticamente uma onda retangular. 

% 10) Agora com A1 = 30 e A2 = 150 e f1 = 50 e f2 = 30. O sinal de saida
% satura claramente, ficando praticamente uma onda retangular. 

% 11) Agora com A1 = 30 e A2 = 40 e f1 = 50 e f2 = 30. O sinal de saida
% satura claramente, ficando praticamente uma onda retangular. 

% 12) Agora com A1 = 15 e A2 = 10 e f1 = 50 e f2 = 30. O sinal de saida
% satura claramente quando a amplitude do sinal de entrada é mais elevada,
% mas quando esta é mais baixa, o sinal de saida começa a nao saturar

% 12) Agora com A1 = 10 e A2 = 17 e f1 = 50 e f2 = 30. O sinal de saida
% satura claramente quando a amplitude do sinal de entrada é mais elevada,
% mas quando esta é mais baixa, o sinal de saida começa a nao saturar

% 13) Agora com A1 = 8 e A2 = 4 e f1 = 50 e f2 = 30. O sinal de saida
% satura claramente quando a amplitude do sinal de entrada é mais elevada,
% mas quando esta é mais baixa, o sinal de saida começa a nao saturar

% 14) Agora com A1 = 4 e A2 = 3 e f1 = 50 e f2 = 30. O sinal de saida
% satura quando a amplitude do sinal de entrada é mais elevada,
% mas quando esta é mais baixa, o sinal de saida começa a nao saturar.
% Começa a notar a diferença entra a passagem de saturação para a não
% saturação

% 15) Agora com A1 = 2 e A2 = 2 e f1 = 50 e f2 = 30. O sinal de saida
% satura quando a amplitude do sinal de entrada é mais elevada,
% mas quando esta é mais baixa, o sinal de saida começa a nao saturar.
% Nota-se a diferença entra a passagem de saturação para a não
% saturação

% 16) Agora com A1 = 0.6 e A2 = 0.5 e f1 = 50 e f2 = 30. O sinal de saida
% já nao está saturado

% 17) Agora com A1 = 0.6 e A2 = 0.5 e f1 = 200 e f2 = 550. O sinal de saida
% já nao está saturado. Verifica-se o mesmo que nos primeiros pontos. 

% 18) Agora com A1 = 0.6 e A2 = 0.5 e f1 = 2 e f2 = 5. O sinal de saida
% já nao está saturado. Verifica-se o mesmo que nos primeiros pontos. 

% Comparação dos sinais x1, x2 e x (x = x1+x2) no tempo
figure(1);
subplot(3,1,1)
plot(t,x1)
title('Signal x1')
xlabel('Time (s)')
ylabel('Amplitude (V)')
subplot(3,1,2)
plot(t,x2)
title('Signal x2')
xlabel('Time (s)')
ylabel('Amplitude (V)')
subplot(3,1,3)
plot(t,x)
title('Input Signal: x = x1+x2')
xlabel('Time (s)')
ylabel('Amplitude (V)')

% Comparação dos sinais x1, x2 e x (x = x1+x2) na frequencia (FFT)
figure(2)
stem(freq, abs(fft(x1))./N)
hold on
stem(freq, abs(fft(x2))./N)
hold on
stem(freq, (abs(fft(x)))./N)
hold off
legend('FFT x1','FFT x2','FFT x')
title('FFT - signals x1,x2 and x')
legend('FFT x')
title('FFT - signal x')
xlabel('Frequency (Hz)')
ylabel('Amplitude (V)')

%
y = SystemWA02(x,t,NumMec);

figure(3)
plot(t,x,t,y)
legend('Input Signal','Output Signal')
title('Output and Input Signals')
xlabel('Time (s)')
ylabel('Amplitude (V)')

figure(4)
x_fft =  abs(fft(x));
y_fft =  abs(fft(y));
subplot(3,1,1)
stem(freq,x_fft./(N))
xlim([0 7000])
title('FFT Input Signals')
ylabel('Amplitude (V)')
xlabel('Frequency (Hz)')
subplot(3,1,2)
stem(freq,y_fft./(N))
xlim([0 7000])
title('FFT Output Signal')
ylabel('Amplitude (V)')
xlabel('Frequency (Hz)')
subplot(3,1,3)
stem(freq,x_fft./(N))
xlim([0 7000])
hold on
stem(freq,y_fft./(N))
title('FFT Output and FFT Input Signal')
legend('FFT Input Signals','FFT Output Signal')
ylabel('Amplitude (V)')
xlabel('Frequency (Hz)')
hold off
xlim([0 7000])

%%%%%%%%%%% Ganho %%%%%%%%%%%
xFreq_Norm = x_fft./N;
yFreq_Norm = y_fft./N;

ganho = zeros(1,N);

for i=1:N
    if(xFreq_Norm(i) > 0.05 && yFreq_Norm(i) > 0.05)
        ganho(i) = yFreq_Norm(i)/xFreq_Norm(i);
    end
end

figure(5)
plot(freq,ganho)
title('Amplifier gain')
xlabel('Frequency (Hz)')
ylabel('Gain')
xlim([0 5000])