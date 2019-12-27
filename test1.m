%�����ַ��˲�������
% clear
% clc
% fs=12000;
% N=12000;
% n=0:N-1;
% t = n / fs;  %ʱ������
% 
% s = 15 * rand(size(t));  %ԭʼ��Ƶ�ź�
% w = 20 * rand(1) * sin(2 * pi * 1500 * t);  %�����ź�
% x = s + w;  %����ź�
% 
% f = fs * (0:(N / 2)) / N;  %Ƶ������
% 
% %ԭʼ�źŵ�Ƶ�׷���
% y = fft(s);
% P1 = abs(y/N);
% mag = P1(1:N/2+1);
% % mag(2:end-1) = 2 * mag(2:end-1);
% 
% %����źŵ�Ƶ�׷���
% y1 = fft(x);
% P2 = abs(y1/N);
% mag1 = P2(1:N/2+1);
% mag1(2:end-1) = 2 * mag1(2:end-1);
% 
% %(����)�˲�������
% Wp = [1400,1600]/(fs/2);
% Ws = [1450,1550]/(fs/2);
% Rp = 0.1;
% Rs = 20;
% 
% %������˼�˲��������
% [aa,Wc] = buttord(Wp,Ws,Rp,Rs);
% %[z,p,G] = butter(n,Wc,'stop');
% %figure(1)
% %SOS = zp2sos(z,p,G);       ˫���Է�
% %freqz(SOS,1024,fs);
% [B,A] = butter(aa,Wc,'stop');
% Y = filter(B,A,x);
% 
% %�˲����Ƶ�׷���
% y2 = fft(Y);
% P3 = abs(y2/N);
% mag2 = P3(1:N/2+1);
% % mag2(2:end-1) = 2 * mag2(2:end-1);
% 
% figure(2)
% subplot(2,1,1)
% plot(f,mag,'b')
% ylim([0 0.5]);xlabel('Ƶ��/Hz');ylabel('���')
% title('ԭʼ�źŷ�Ƶͼ')
% subplot(2,1,2)
% plot(f,mag1,'b')
% ylim([0 1]);xlabel('Ƶ��/Hz');ylabel('���')
% title('����������ķ�Ƶͼ')
% figure(3)
% subplot(2,1,1)
% plot(f,mag,'b')
% ylim([0 0.5]);xlabel('Ƶ��/Hz');ylabel('���')
% title('ԭʼ�źŷ�Ƶͼ')
% subplot(2,1,2)
% plot(f,mag2,'b')
% ylim([0 0.5]);xlabel('Ƶ��/Hz');ylabel('���')
% title('�˲���ķ�Ƶͼ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�ݲ��˲�������
clear
clc

fs = 12000;  %����Ƶ��
N = 12000;   %��������
n = 0:N-1;
t = n / fs;  %ʱ������

s = 10000 * rand(size(t));  %ԭʼ��Ƶ�ź� 
w = 10000 * rand(1) * sin(2 * pi * 1500 * t);  %�����ź�
x = s + w;  %����ź�

f = fs * (0:(N / 2)) / N;  %0��6khzƵ������

%����źŵ�Ƶ�׷���
y1 = fft(x);
P2 = abs(y1/N);
mag1 = P2(1:N/2+1);
mag1(2:end-1) = 2 * mag1(2:end-1);

%�ݲ������
r=0.9;
w0=2*pi*1500/fs;   %Ҫ�˵���Ƶ��
b=[1 -2*cos(w0) 1];
a=[1 -2*r*cos(w0) r*r];
[H,w]=freqz(b,a,N);
figure(1)
subplot(221);plot(w,abs(H));title('�ݲ����ķ�Ƶ��Ӧ');
subplot(222);plot(w,angle(H));title('�ݲ�������Ƶ��Ӧ');
subplot(223);zplane(b,a);title('�ݲ������㼫��ͼ');

%�ݲ����˲�
y2=filter(b,a,x);
Y=fft(y2);
P3=abs(Y/N);
mag2=P3(1:N/2+1);
mag2(2:end-1) = 2 * mag2(2:end-1);

figure(2);
subplot(2,1,1)
plot(f,mag1)
ylim([0 500]);xlabel('Ƶ��/Hz');ylabel('���')
title('ԭʼ�ź�Ƶ��ͼ')
subplot(2,1,2)
plot(f,mag2)
ylim([0 500]);xlabel('Ƶ��/Hz');ylabel('���')
title('�ݲ����˲�����ź�y(n)')



