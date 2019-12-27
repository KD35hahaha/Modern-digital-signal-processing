clear
clc

%�������ֵ������Ϊ1�ĸ���˹����������v(n)
N = 1000;
noise = (randn(1,N) + 1i * randn(1,N)) *sqrt(2);

%�������������ź�����u(n)
signal1 = exp(1i * 0.5 * pi * (0:N-1) + 1i * 2 * pi * rand(1));  %������һ���ź�
signal2 = exp(1i * -0.3 * pi * (0:N-1) + 1i * 2 * pi * rand(1));  %�����ڶ����ź�
un = signal1 + signal2 + noise;                %�������������ź�

%��������ؾ���
M = 8;                      %����ؾ������
for k = 1:N-M
    xs( :,k) = un(k + M - 1: -1 : k);    %������������
end
R = xs * xs' / (N-M);            %��������ؾ���

%����ؾ�������ֵ�ֽ�
[U,E] = svd(R);
ev = diag(E);            %��ȡ�Խ�Ԫ���ϵ�����ֵ

%����AIC׼������ź�Դ��������
for k = 1:M
    dec = prod(ev(k:M) .^ (1/(M - k + 1)));
    nec = mean(ev(k:M));
    lnv = (dec/nec)^((M - k + 1) * N);
    AIC(k) = -2 * log(lnv) + 2 * (k-1) * (2 * M - k + 1);
end
[Amin,K] = min(AIC);   %Ѱ��ʹAIC׼����С������
% N1 = K - 1;           %Ѱ���ź�Դ����

%����MUSIC��
En = U(:,K:M);   %�����ӿռ��������ɵľ���
NF = 2048;           %MUSIC��ɨ�����
for n = 1:NF
      Aq = exp(-1i * 2 * pi * (n-1) / NF * (0:M-1)');
      Pmusic(n) = 1/(Aq' * En * En' * Aq);         %MUSIC��
end
S = 10 * log10(Pmusic);
m1 = -1023:1024;
plot(m1/2048,S);
xlabel('w/2*pi');
ylabel('��һ��������/dB');
title('MUSIC�׹���');
