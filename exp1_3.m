%������˲�����������ֹƵ��̫��
clear;clc;
%% ����ȷ��
fs = 3000;%����Ƶ��
f0 =400;%��Ƶ
fa = 20;%����Ƶ��
Ts = 2;%����ʱ��
f1 = 400;%��ƵƵ��
fp = 5;%��ֹƵ��
fss = 15;
t = 0:1/fs:Ts-1/fs;%ʱ���
%% �źŲ���
At=cos(2*pi*fa*t);%�����ź�
% At = 2;
thetat = cos(2*pi*0.5*t);%��λ�ź�
% thetat=0.5;
Xt = At.*cos(2*pi*f0*t+thetat);%խ���ź�
nn = length(t);%��������
f= (-nn/2:nn/2-1)*(fs/nn);%Ƶ������
figure;subplot(2,1,1);plot(t,Xt);axis([0 Ts -3 3]);title('խ���ź�');xlabel('t/s');ylabel('Amplitude/V')
subplot(2,1,2);plot(f,abs(fftshift(fft((Xt)))));title('խ���ź�Ƶ��');xlabel('f/Hz');ylabel('Amplitude')
%% �������

at = 2*Xt.*cos(2*pi*f1*t);%a(t)�˲�ǰ
bt = -2*Xt.*sin(2*pi*f1*t);%b(t)�˲�ǰ
figure;subplot(2,2,1);plot(t,at);title('a(t)�˲�ǰ');xlabel('t/s');ylabel('Amplitude/V')
subplot(2,2,3);plot(t,bt);title('b(t)�˲�ǰ');xlabel('t/s');ylabel('Amplitude/V')
subplot(2,2,2);plot(f,abs(fftshift(fft(at))));title('a(t)�˲�ǰƵ��');xlabel('f/Hz');ylabel('Amplitude')
subplot(2,2,4);plot(f,abs(fftshift(fft(bt))));title('b(t)�˲�ǰƵ��');xlabel('f/Hz');ylabel('Amplitude')
%% �˲���

Wp = 2*fp/fs;%��ֹƵ�ʻ���
Ws = 2*fss/fs;
[n,Wn] = buttord(Wp,Ws,3,50);%������˹�˲���
[z,p,k] = butter(n,Wn);
sos = zp2sos(z,p,k);
figure;freqz(sos,512,4000);%�˲�����Ӧ
[b,a] = butter(n,Wn);
atf = filter(b,a,at);%�˲�
btf = filter(b,a,bt);%�˲�

figure;subplot(4,1,1);plot(t,At.*cos(thetat));title('��׼a(t)����');xlabel('t/s');ylabel('Amplitude/V')
subplot(4,1,2);plot(f,abs(fftshift(fft(At.*cos(thetat)))));title('��׼a(t)Ƶ��');xlabel('f/Hz');ylabel('Amplitude')
subplot(4,1,3);plot(t,atf);title('a(t)�˲���');xlabel('t/s');ylabel('Amplitude/V')
subplot(4,1,4);plot(f,abs(fftshift(fft(atf))));title('a(t)�˲���Ƶ��');xlabel('f/Hz');ylabel('Amplitude')

figure;subplot(4,1,1);plot(t,At.*sin(thetat));title('��׼b(t)����');xlabel('t/s');ylabel('Amplitude/V')
subplot(4,1,2);plot(f,abs(fftshift(fft(At.*sin(thetat)))));title('��׼b(t)Ƶ��');xlabel('f/Hz');ylabel('Amplitude')
subplot(4,1,3);plot(t,btf);title('b(t)�˲���');xlabel('t/s');ylabel('Amplitude/V')
subplot(4,1,4);plot(f,abs(fftshift(fft(btf))));title('b(t)�˲���Ƶ��');xlabel('f/Hz');ylabel('Amplitude')