clear;clc;
%% 参数
fs = 80000;%采样率
A = 1;%A
f0 = 2000;%f0
k = 80000;%k
T = 0.01;%持续时间
tao = -T:0.0001:T;
fai = -500:1:500;
t = -T/2:1/fs:T/2;
nn = length(t);%采样点数
ff = (-nn/2:1:(nn/2-1))*(fs/nn);%频率网格
%% 信号
st = real(A*exp(1i*(2*pi*f0*t+pi*k*t.*t)));%信号
figure;plot(t,st);title('LFM信号');xlabel('t/s');ylabel('Amplitude/V')
spec = abs(fftshift(fft(st)));%频谱
figure;plot(ff,spec);title('LFM信号频谱');xlabel('f/Hz');ylabel('Amplitude')
%% 模糊椭圆
fai1 = diag(fai)*ones(length(fai),length(tao));
tao1 = diag(tao)*ones(length(tao),length(fai));
% ambf = abs(sinc(pi*fai1'.*(T-abs(tao1))).*(T-abs(tao1)));
ambf = abs(sin(pi*(k*tao1+fai1').*(T-abs(tao1)))./(pi*(k*tao1+fai1').*(T-abs(tao1))).*(T-abs(tao1)));
[X,Y] = meshgrid(tao,fai);
ambf(ambf<0.707*max(max(ambf)))=0;
% ambf(ambf>0.8*max(max(ambf)))=1;
figure;contour(X,Y,ambf')
% figure;mesh(X,Y,ambf')
xlabel('tao/s');ylabel('fai/Hz')


% figure;plot(fai,ambf(20,:));
% figure;plot(tao,ambf(:,500));
