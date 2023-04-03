close all;
clc;
clear;
%% semnal dreptunghiular cu amplitudinea A/4 - A si factor de umplere de 50%   ------ punctul a). din tema
% F0 = 300; A = 2.5; Tmax = 50 ms; Fs = 16000; Nfft = 1024;

F0 = 300; %frecventa fundamentala
A = 2.5;  %amplitudinea semnalului
Tmax = 0.05;  %timpul de analiza maxim al semnalului
Fs = 16000;   %frecventa de esantionare
Nfft = 1024;  %numarul de esantioane pentru transformata Fourier

Ts = 1/Fs;   %perioada de esantionare
T = 1/F0;    %perioada semnalului
N_es = Tmax*Fs; %numarul total de esantioane din Tmax
n = 0:N_es-1;   %vectorul unitate pentru reprezentarea semnalului discret
P = Tmax/T; %numarul de perioade din Tmax
N = N_es/P; %numarul de esantioane ca semnalul sa fie periodic

%% semnal discret x[n]
x = (A/2).*(square(2*pi*F0/Fs*n)+1);  %functia de generare a semnalului S3
x(x<A/4)=A/4;                         %pentru valori mai mici de A/4 se seteaza amplitudinea semnalului la A/4
figure(1),stem(n,x),grid on
title('Semnalul discret generat'),xlabel('n'),ylabel('x[n]');

%% semnal analogic refacut prin conversie digital-analogica
t = 0:Ts:Tmax-Ts;  %vectorul timp pentru reprezentarea semnalului analogic

% x_analogic = (A/2).*(square(2*pi*F0*t)+1);
% x_analogic(x_analogic<A/4)=A/4;

x_analogic = interp1(n/Fs, x, t);   %functie matlab predefinita pentru refacerea semnalului analogic prin conversie D/A

figure(2), plot(1000*t, x_analogic)
title('Semnal analogic x(t)')
xlabel('t[ms]')
ylabel('Amplitudine')
grid on

parametrii(x, N_es, Tmax, T);  %punctul b cu functia de valoare medie si numarul de perioade

%% punctul c).
X=fft(x,N_es);%transformata fourier discreta a lui x(n) in Nes puncte
k=0:N_es-1;
figure(3), plot(k,abs(X)), title('Spectrul de amplitudine |X(k)|'), xlabel('k'), ylabel('X|k|'), grid  %afisarea modulului TFD a semnalui x

k0 = F0*N_es/Fs; %verificare k0 = P
%primul subpunct

f = -0.5: 1/N_es: 0.5-1/N_es;
figure(4)
subplot(2,1,1), plot(f,fftshift(abs(X))), title('Spectrul de amplitudini in frecvente normate'), xlabel('frecventa normata'), ylabel('|X|'), grid
subplot(2,1,2), plot(f,fftshift(angle(X))), title('Spectrul de faza in frecvente normate'), xlabel('frecventa normata'), ylabel('|phase|'), grid
%al doilea subpunct

F = -Fs/2:Fs/N_es:Fs/2-Fs/N_es;
figure(5)
plot(F,fftshift(abs(X))), title('Spectrul de amplitudini in frecvente nenormate'), xlabel('F[Hz]'), ylabel('|X|'), grid
% ultimul subpunct

%% punctul d).
X=fft(x,Nfft);%transformata fourier discreta a lui x(n) in Nfft puncte
k=0:Nfft-1;
figure(6), plot(k,abs(X)), title('Spectrul de amplitudine |X(k)|'), xlabel('k'), ylabel('X|k|'), grid  %afisarea modulului TFD a semnalui x

k1 = F0*Nfft/Fs; %verificare k1 != k0 => difera numarul de esantioane si nu corespunde cu perioada si frecventa Fs de esantionare
%primul subpunct

f = -0.5: 1/Nfft: 0.5-1/Nfft;
figure(7)
subplot(2,1,1), plot(f,fftshift(abs(X))), title('Spectrul de amplitudini in frecvente normate'), xlabel('frecventa normata'), ylabel('|X|'), grid
subplot(2,1,2), plot(f,fftshift(angle(X))), title('Spectrul de faza in frecvente normate'), xlabel('frecventa normata'), ylabel('|phase|'), grid
%al doilea subpunct

F = -Fs/2:Fs/Nfft:Fs/2-Fs/Nfft;
figure(8)
plot(F,fftshift(abs(X))), title('Spectrul de amplitudini in frecvente nenormate'), xlabel('F[Hz]'), ylabel('|X|'), grid
% ultimul subpunct
