clear
clc
%�������ֵ������Ϊ1�ĸ���˹���������� 
N = 256;
noise = (randn(1,N) + 1i * randn(1,N) / sqrt(2));
%���������������ź�
f1 = 0.15;
f2 = 0.17;
f3 = 0.26;           %�źŵĹ�һ��Ƶ��
SNR1 = 30;
SNR2 = 30;
SNR3 = 27;          %�źŵ������
A1 = 10^(SNR1 / 20);
A2 = 10^(SNR2 / 20);
A3 = 10^(SNR3 / 20);    %�źŵķ���
signal1 = A1 * exp(1i * 2 * pi * f1 * (0:N-1));
signal2 = A2 * exp(1i * 2 * pi * f2 * (0:N-1));
signal3 = A3 * exp(1i * 2 * pi * f3 * (0:N-1));     %�����������ź�
%�����۲�����u(n)
un = signal1 + signal2 + signal3 + noise;
%����ͼ��
NF = 1024;                  %����ͼ����FFT�ĵ���
Spr = fftshift((1/NF) * abs(fft(un,NF)).^2);
A = 10 * log10(Spr);
f = (-length(A)/2 + 1):(length(A)/2);
figure(1)
plot(f/NF,A);
xlabel('w/2\pi');
ylabel('��һ��������/dB');
title('����ͼ��');

%BT��
M = 64;                        %����غ����ĵ��߳���
r = xcorr(un,M,'biased');           %��������غ���
NF = 1024;                      %BT����FFT�ĵ���
BT = fftshift(fft(r,NF));             %BT�����㹦����
B = 10 * log10(BT);
f = (-length(B)/2 + 1):(length(B)/2);
figure(2)
plot(f/NF,B);
xlabel('w/2\pi');
ylabel('��һ��������/dB');
title('BT��');
