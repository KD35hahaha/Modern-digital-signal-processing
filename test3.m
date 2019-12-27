clear
clc
wp = 0.4 * pi;
ws = 0.096 * pi;
rs = 65;
DB = abs(wp - ws);           %������ɴ����
M = ceil(12*pi/ DB);  %���㲼��������������� 
N=M+mod(M+1,2);   %ȷ��hn����NΪ����
wc = (wp + ws)/ 2 / pi;    %���������ͨ�˲���ͨ����ֹƵ��
hn = fir1(N-1,wc,blackman(N));  %����fir1�����ͨFIRDF��h(n)


%����ͼ
figure(1)
stem(hn);
xlabel('n');
ylabel('h(n)');
title('h(n)����');
% %��ĺ�������
% [Hn,w] = freqz(hn);        %����Ƶ����Ӧ
% db = 20*log10(abs(Hn));    %��Ϊ�ֱ�ֵ
% db1=db';
% figure(2)
% plot(w / pi,db1);
% xlabel('w/ \p');
% ylabel('20lg|Hg(w)|');
% title('��ĺ�������')
% %��Ƶ��������
% figure(3)
% plot(w,angle(Hn));
% xlabel('Ƶ��');
% ylabel('��λ');
% title('��Ƶ��������')
figure(4)
freqz(hn,1,512)

