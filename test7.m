clear
clc

%����ARģ�͵�����ź�
a1=0.99;
seta=0.995;
N=1024;

for i=1:600
y=randn(1,N)*sqrt(seta);  % noise sig 
num=1;  %����ϵ��
den=[1 a1]; %��ĸϵ��
u0=zeros(length(den),1)';  %��ʼ����
xic=filtic(num,den,u0);  %��ʼ����
un=filter(num,den,y,xic);   %��������

%����������Ӧ�źź͹۲����ݾ���
n0=1;  %��Ҫʵ��n0������Ԥ��
m=2;   %�˲������� ��ͷ��
b=un(n0+1:N);  %Ԥ��������Ӧd(n)
l=length(b);
un1 = [zeros(m-1,1), un];  %��չ����  %%%%
a=zeros(m,l);      %u(n)
for k=1:l-1
    a(:,k)=un1(m-1+k:-1:k);  %�۲����ݾ���A����
end

%Ӧ��RLS�㷨����������Ȩ����
delta=0.004;    %��������
lambda=0.98;       %��������
w=zeros(m,l+1);     %�洢Ȩ����
epsilon=zeros(l,1);  %����������洢
p1=eye(m)/delta;   %��ؾ������
for k=1:l
    pin=p1*a(:,k);
    denok=1+a(:,k)'*pin;      
    kn=pin/denok;
    epsilon(k)=b(k)-w(:,k)'*a(:,k);
    w(:,k+1) = w(:,k) + kn * conj(epsilon(k));
    p1=p1/lambda-kn*a(:,k)'*p1/lambda;
end
mse=abs(epsilon).^2;
JFWC(i,:) =mse;
W1(i,:) = w(1,:);
W2(i,:) = w(2,:);
end


%��800�ξ�ֵ
mse = mean(JFWC);
w1 = mean(W1);     %������ͷ��Ȩֵ
w2 = mean(W2);

figure(1)
plot(1:800,mse(1:800),'r');
xlabel('��������');
ylabel('MSE');
title('�������');
grid on;
%Ȩֵ
figure(2)
plot(1:800,w1(1:800),'r');
hold on;
plot(1:800,w2(1:800),'b');
hold off;
xlabel('��������');
ylabel('Ȩֵ');
title('����Ȩֵ');
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LMS�㷨 ���н�
% %������������
% clear
% clc
% %����ARģ�͵�����ź�
% a1=0.99;
% seta=0.995;
% data_length=2000;
% h1 = 0.05;
% for i=1:1000
% y=randn(1,data_length)*sqrt(seta);  % noise sig 
% num=1;  %����ϵ��
% den=[1 a1]; %��ĸϵ��
% u0=zeros(length(den),1)';  %��ʼ����
% xic=filtic(num,den,u0);  %��ʼ����
% u=filter(num,den,y,xic);   %��������
% end
% 
% %%
% %100������
% W1 = zeros(100,4500);
% W2 = zeros(100,4500);
% for m = 1:100
% %������������
% L = 5000;
% a1 = 0.99;
% s = 0.995;
% n = 1:L;
% v = sqrt(s) * randn(L,1);
%     u(1) = v(1);
%     for k = 2:L
%       u(k) = -a1 * u(k-1) + v(k);
%     end
% u=u(500:end);
% 
% %LMS�����㷨
% M = 2;
% w(1,:) = zeros(1,M);
% e(1) = u(1);
% mu = 0.001;
% uu = zeros(1,M);
% w(2,:) = w(1,:) + mu * e(1) * uu;
% uu = [u(1),uu(1:M-1)];
% dd = (w(2,:)*uu')';
% e(2) = u(3) - dd;
% 
% for k = 3:4501
%   w(k,:) = w(k-1,:) + mu * e(k-1) * uu;
%   uu = [u(k-1),uu(1:M-1)];
%   dd = (w(k,:)*uu')';
%   e(k) = u(k)-dd;
% end
% W1(m,:) = w(1:4500,1)';
% W2(m,:) = w(1:4500,2)';
% end
% 
% W11 = mean(W1);
% W22 = mean(W2);
% 
% plot(1:4500,W11,'r');
% hold on;
% plot(1:4500,W22,'b');
% xlabel('��������');
% ylabel('��ͷȨֵ');
% title('����0.05');
% grid on;
