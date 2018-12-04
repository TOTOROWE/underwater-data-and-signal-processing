%错误的滤波器参数，截止频率太低
clear;clc;
%% 参数确定
fs = 3000;%采样频率
f0 =400;%载频
fa = 20;%包络频率
Ts = 2;%持续时间
f1 = 400;%混频频率
fp = 5;%截止频率
fss = 15;
t = 0:1/fs:Ts-1/fs;%时间点
%% 信号产生
At=cos(2*pi*fa*t);%包络信号
% At = 2;
thetat = cos(2*pi*0.5*t);%相位信号
% thetat=0.5;
Xt = At.*cos(2*pi*f0*t+thetat);%窄带信号
nn = length(t);%采样点数
f= (-nn/2:nn/2-1)*(fs/nn);%频率网格
figure;subplot(2,1,1);plot(t,Xt);axis([0 Ts -3 3]);title('窄带信号');xlabel('t/s');ylabel('Amplitude/V')
subplot(2,1,2);plot(f,abs(fftshift(fft((Xt)))));title('窄带信号频谱');xlabel('f/Hz');ylabel('Amplitude')
%% 正交解调

at = 2*Xt.*cos(2*pi*f1*t);%a(t)滤波前
bt = -2*Xt.*sin(2*pi*f1*t);%b(t)滤波前
figure;subplot(2,2,1);plot(t,at);title('a(t)滤波前');xlabel('t/s');ylabel('Amplitude/V')
subplot(2,2,3);plot(t,bt);title('b(t)滤波前');xlabel('t/s');ylabel('Amplitude/V')
subplot(2,2,2);plot(f,abs(fftshift(fft(at))));title('a(t)滤波前频谱');xlabel('f/Hz');ylabel('Amplitude')
subplot(2,2,4);plot(f,abs(fftshift(fft(bt))));title('b(t)滤波前频谱');xlabel('f/Hz');ylabel('Amplitude')
%% 滤波器

Wp = 2*fp/fs;%截止频率换算
Ws = 2*fss/fs;
[n,Wn] = buttord(Wp,Ws,3,50);%巴特沃斯滤波器
[z,p,k] = butter(n,Wn);
sos = zp2sos(z,p,k);
figure;freqz(sos,512,4000);%滤波器响应
[b,a] = butter(n,Wn);
atf = filter(b,a,at);%滤波
btf = filter(b,a,bt);%滤波

figure;subplot(4,1,1);plot(t,At.*cos(thetat));title('标准a(t)波形');xlabel('t/s');ylabel('Amplitude/V')
subplot(4,1,2);plot(f,abs(fftshift(fft(At.*cos(thetat)))));title('标准a(t)频谱');xlabel('f/Hz');ylabel('Amplitude')
subplot(4,1,3);plot(t,atf);title('a(t)滤波后');xlabel('t/s');ylabel('Amplitude/V')
subplot(4,1,4);plot(f,abs(fftshift(fft(atf))));title('a(t)滤波后频谱');xlabel('f/Hz');ylabel('Amplitude')

figure;subplot(4,1,1);plot(t,At.*sin(thetat));title('标准b(t)波形');xlabel('t/s');ylabel('Amplitude/V')
subplot(4,1,2);plot(f,abs(fftshift(fft(At.*sin(thetat)))));title('标准b(t)频谱');xlabel('f/Hz');ylabel('Amplitude')
subplot(4,1,3);plot(t,btf);title('b(t)滤波后');xlabel('t/s');ylabel('Amplitude/V')
subplot(4,1,4);plot(f,abs(fftshift(fft(btf))));title('b(t)滤波后频谱');xlabel('f/Hz');ylabel('Amplitude')