clear
clc
%�������ֵ������Ϊ1�ĸ���˹���������� 
N = 256;
noise = (randn(1,N) + 1i * randn(1,N) / sqrt(2));
%���������������ź�
f1 = 0.15;
f2 = 0.17;
f3 = 0.26;              %�źŵĹ�һ��Ƶ��
SNR1 = 30;
SNR2 = 30;
SNR3 = 27;             %�źŵ������
A1 = 10^(SNR1 / 20);
A2 = 10^(SNR2 / 20);
A3 = 10^(SNR3 / 20);         %�źŵķ���
signal1 = A1 * exp(1i * 2 * pi * f1 * (0:N-1));
signal2 = A2 * exp(1i * 2 * pi * f2 * (0:N-1));
signal3 = A3 * exp(1i * 2 * pi * f3 * (0:N-1));     %�����������ź�
%�����۲�����u(n)
un = signal1 + signal2 + signal3 + noise;
%��������غ���ֵ
p = 16;                            %ARģ�͵Ľ���
r0 = xcorr(un,p,'biased');         %ֱ�Ӽ�������غ���
r = r0(p + 1:2 * p + 1);           %��ȡr(0),r(1),...,r(p)
%����һ��ARģ�͵�ϵ�������뷽��
a(1,1) = -r(2)/r(1);                       %1��ARģ�͵�ϵ��
signal(1) = r(1) - (abs(r(2)^2)/r(1));          %1��ARģ�͵����뷽��
%Levinsion-Durbin�����㷨
for m = 2:p
    k(m) = -(r(m+1) + sum(a(m-1,1:m-1) .* r(m:-1:2)))/signal(m-1);
    a(m,m) = k(m);
    for i = 1:m-1
        a(m,i) = a(m-1,i) + k(m) * conj(a(m-1,m-i));
    end
    signal(m) = signal(m-1) * (1-abs(k(m))^2);
end
%����ʮ����ARģ�͵Ĺ�����
NF = 1024;                          %AR������FFT�ĵ���
Par = signal(p)./fftshift(abs(fft([1,a(p,:)],NF)).^2);  %p��ARģ�͵Ĺ�����
C = 10*log10(Par);
f = (-length(C)/2 + 1):(length(C)/2);
figure(1)
plot(f/NF,C);
xlabel('w/(2*pi)');
ylabel('��һ��������/dB');
title('16��ARģ��');
