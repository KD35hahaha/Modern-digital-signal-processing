clear
clc
T =0.1;   %����1s
fs = 1 / T;
%������˹�˲��������ָ�����
Wp = 0.1 * pi / (fs/2);
Ws = 0.3 * pi / (fs/2);
Rp = 1;
Rs = 10;
[n,Wc] = buttord(Wp,Ws,Rp,Rs);  %�����˲����Ľ���n��3dB��ֹƵ��
%������Ӧ���䷨
[B,A] = butter(n,Wc,'s');  %������Ӧ��ģ���˲�����ϵͳ����
[Bz,Az] = impinvar(B,A);   %��������Ӧ���䷨��ģ���˲���ת��Ϊ�����˲���H(s)>>H(z)
figure(1)
freqz(Bz,Az,1024,fs)
title('������Ӧ���䷨')
%˫�߷�
[A,B] = butter(n,Wc);
% sos = zp2sos(z,p,G);
figure(2)
freqz(A,B,1024,fs)
title('˫�߷�')
