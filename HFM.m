clear;clc;
%% ����
fs = 80000;%������
A = 1;%A
f0 = 2000;%f0
K = 160;%k
T = 0.1;%����ʱ��
tao = -T:0.001:T;
fai = -500:1:500;
t = -T/2:1/fs:T/2;%����̫С����ʱ��̫��
t0 = T;
theta0 = 0;
nn = length(t);%��������
ff = (-nn/2:1:(nn/2-1))*(fs/nn);%Ƶ������
%% �ź�
st = real(A*exp(-1i*(2*pi*K*log(1-t/t0+theta0))));%�ź�
figure;plot(t,st);title('LFM�ź�');xlabel('t/s');ylabel('Amplitude/V')
spec = abs(fftshift(fft(st)));%Ƶ��
figure;plot(ff,spec);title('LFM�ź�Ƶ��');xlabel('f/Hz');ylabel('Amplitude')
%% ģ����Բ
fai1 = diag(fai)*ones(length(fai),length(tao));
tao1 = diag(tao)*ones(length(tao),length(fai));
ambf = zeros(length(tao),length(fai));
t = -T/2:100/fs:T/2;
for i=1:length(t)
    ambf = ambf+(exp(1i*2*pi*(fai1'.*t(i)+f0*t0*log(1-tao1./(t0-(i))))));
end
ambf=abs(ambf);
[X,Y] = meshgrid(tao,fai);
ambf(ambf<0.707*max(max(ambf)))=0;
figure;contour(X,Y,ambf')
% figure;mesh(X,Y,ambf')
xlabel('tao/s');ylabel('fai/Hz')



% figure;plot(fai,ambf(20,:));
% figure;plot(tao,ambf(:,500));