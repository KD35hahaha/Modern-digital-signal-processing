clear
clc

%������������

a1 = -0.975;
a2 = 0.95;
s = 0.0731;
trials = 100;        %����������
data_length = 512;
n = 1:data_length;
v = sqrt(s) * randn(data_length,1);
u0 = [0 0 0];
num = 1;
den = [1 a1 a2];
Zi = filtic(num,den,u0);
u = filter(num,den,v,Zi);
figure(1)
plot(u);
xlabel('n'); ylabel('(n)--y(n)');
grid;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LMS�����㷨

h1 = 0.05;              %��������h1  h2
h2 = 0.005;
w1 = zeros(2,data_length);    %�ڲ�ͬ���������µ�w1 w2Ȩ������ʼֵ���洢�ռ�
w2 = zeros(2,data_length);
e1 = zeros(data_length,1);     %�������ĳ�ʼֵ���洢�ռ��С
e2 = zeros(data_length,1);
d1 = zeros(data_length,1);
d2 = zeros(data_length,1);      %�����źŵĹ���ͬ��
for n = 3:data_length-1         %LMS����
     w1(:,n+1) = w1(:,n) + h1 * u(n-1:-1:n-2) * conj(e1(n));
     w2(:,n+1) = w2(:,n) + h2 * u(n-1:-1:n-2) * conj(e2(n));
     d1(n+1) = w1(:,n+1)' * u(n:-1:n-1);
     d2(n+1) = w2(:,n+1)' * u(n:-1:n-1);
     e1(n+1) = u(n+1) - d1(n+1);
     e2(n+1) = u(n+1) - d2(n+1);
end
figure(2)
plot(1:512,w1(1,:),'r');
hold on;
plot(1:512,w1(2,:),'b');
hold off;
xlabel('��������');
ylabel('��ͷȨֵ');
title('����0.05 ');
figure(3)
plot(1:512,w2(1,:),'r');
hold on;
plot(1:512,w2(2,:),'b');
hold off;
xlabel('��������');
ylabel('��ͷȨֵ');
title('����0.005');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����ʣ�������ʧ������������ѧϰ����

wopt = zeros(2,trials);     
Jmin = zeros(1,trials);   %��С��������ֵ�洢
sum_eig = zeros(trials,1);
%ͨ��ά�ɻ��򷽳̼�����С�������Jmin
rm(2)=0;
rm(1)=0;
rm(3)=0;
for m=3:trials
    rm(m+1)=xcorr(u(m),'biased');   %��������غ��� bisaed ��ƫ����
    R=[rm(m) rm(m+1);rm(m-1) rm(m)];
    p=[rm(m-1);rm(m-2)];
%     wopt(m)=R\p;      %�������Ȩֵ
    [v,d]=eig(R);       %�����R��ȫ������ֵ�����ɶԽ���D������R��������������V����������
    Jmin(m)=rm(m)-p'*wopt(:,m);       %����ά�����
    sum_eig(m)=d(1,1)+d(2,2);           %��������ֵ֮��
end
sJmin = sum(Jmin) / trials;     %100��ƽ�����
sum_eig_100trials = sum(sum_eig)/100;   %100��ƽ������ֵ֮��
Jexfin1 = h1 * sJmin * (sum_eig_100trials / (2 - h1 * sum_eig_100trials)); %ʣ����������̬ȡֵ
Jexfin2 = h2 * sJmin * (sum_eig_100trials /(2 - h2 * sum_eig_100trials));
M1 = Jexfin1 / sJmin;   %����ʧ������
M2 = Jexfin2 / sJmin;

Jex1=Jexfin1;    %ʣ��������1 2   
Jex2=Jexfin2;


