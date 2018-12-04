clear;clc;
%% ����
fs = 80000;%������
A = 1;%A
f0 = 5000;%f0
T = 0.1;%����ʱ�� ȡ0.002��0.1
tao = -T:0.0001:T;
fai = -500:1:500;
t = -T/2:1/fs:T/2;
nn = length(t);%��������
ff = (-nn/2:1:(nn/2-1))*(fs/nn);%Ƶ������
%% �ź�
st = real(A*exp(1i*(2*pi*f0*t)));%�ź�
% st(400:end)=0;
figure;plot(t,st);title('CW�ź�');xlabel('t/s');ylabel('Amplitude/V')
spec = abs(fftshift(fft(st)));%Ƶ��
figure;plot(ff,spec);title('CW�ź�Ƶ��');xlabel('f/Hz');ylabel('Amplitude')
%% ģ����Բ
fai1 = diag(fai)*ones(length(fai),length(tao));
tao1 = diag(tao)*ones(length(tao),length(fai));
ambf = abs(sin(pi*fai1'.*(T-abs(tao1)))./(pi*fai1'.*(T-abs(tao1))).*(T-abs(tao1)));
% ambf = abs(sinc(pi*(k*tao1+fai1').*(T-abs(tao1))).*(T-abs(tao1)));
[X,Y] = meshgrid(tao,fai);
ambf(ambf<0.707*max(max(ambf)))=0;
figure;contour(X,Y,ambf')
% figure;mesh(X,Y,ambf')
xlabel('tao/s');ylabel('fai/Hz')

% figure;plot(fai,ambf(20,:));
% figure;plot(tao,ambf(:,500));