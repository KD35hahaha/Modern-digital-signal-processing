clear
clc
%�������ֵ������Ϊ1�ĸ���˹���������� 
N = 32;
noise = (randn(1,N) + 1i * randn(1,N))* sqrt(2);
%���������������ź�
f1 = 0.15;
f2 = 0.17;
f3 = 0.26;        %�źŵĹ�һ��Ƶ��
SNR1 = 30;
SNR2 = 30;
SNR3 = 27;       %�źŵ������
A1 = 10^(SNR1 / 20);
A2 = 10^(SNR2 / 20);
A3 = 10^(SNR3 / 20);        %�źŵķ���
signal1 = A1 * exp(1i * 2 * pi * f1 * (0:N-1));
signal2 = A2 * exp(1i * 2 * pi * f2 * (0:N-1));
signal3 = A3 * exp(1i * 2 * pi * f3 * (0:N-1));     %�����������ź�
%�����۲�����u(n)
un = signal1 + signal2 + signal3 + noise;
%����FFT������غ������ټ��㷽��
Uk = fft(un,2*N);                 %��un����2N���FFT
Sk = (1/N)*abs(Uk).^2;            %���㹦���׹���Sk
r0 = ifft(Sk);                    %�Թ����׹���Sk��FFT
r1 = [r0(N+2:2*N),r0(1:N)];       %���ݽ̲ģ�3.1.8���������غ���

figure(1)
stem(real(r1));               %��ȡʵ��
xlabel('m');
ylabel('ʵ��');
figure(2)
stem(imag(r1));               %��ȡ�鲿
xlabel('m');
ylabel('�鲿');
%�̲�ʽ��3.1.2����������غ���
r = xcorr(un,N-1,'biased');
figure(3)
stem(real(r));                %��ȡʵ��
xlabel('m');
ylabel('ʵ��');
figure(4)
stem(imag(r));                %��ȡ�鲿
xlabel('m');
ylabel('�鲿');

