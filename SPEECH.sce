//Speech Signal Analysis and Noise Reduction in Scilab. 
clear;
clc;
[y,Fs,bits]=wavread("D:\anant_sample.wav");
disp('Sampling Rate in Hz Fs = ',Fs);
disp('Number of bits used per speech sample b =',bits);
N = length(y);
T = N/Fs;
disp('Total Number of Samples N =',N)
disp('Duration of speech signal in seconds T=',T)
clc;
//Reading a speech signal
[x,Fs,bits]=wavread("D:\anant_sample.wav");
order = 40;
// Adaptive filter order
x = x';
N = length(x);
t = 1:N;
figure(1)
subplot(2,1,1)
plot(t,x)
title('Noise free Speech Signal')
//Generation of noise signal
noise = 0.1*rand(1,length(x));
//Adding noise with speech signal
for i = 1:length(noise)
primary(i)= x(i)+noise(i);
end
subplot(2,1,2)
plot(t,primary)
title('primary = speech+noise (input 1);Speech signal with Sampling Rate = 8 KHz, No. of 
Samples = 8360')
//Reference noise generation
for i = 1:length(noise)
 ref(i)= noise(i)+0.025*rand(10);
end
figure(2)
subplot(2,1,1)
plot(t,ref)
title('reference noise (input 2)')
w = zeros(order,1);
Average_Power = pow_1(x,N)
mu = 1/(10*order*Average_Power);
//Speech noise cancellation
for k = 1:110
 for i =1:N-order-1
 buffer = ref(i:i+order-1); //current order points of reference
 desired(i) = primary(i)-buffer'*w; // dot product the reference & filter
 w = w+(buffer.*mu*desired(i)); //update filter coefficients
 end
end
subplot(2,1,2)
plot([1:length(desired)],desired)
title('Denoised Speech Signal at Adaptive Filter Output')
//Calculation of Mean Squarred Error between the original speech signal and
//Adaptive filter output
for i =1:N-order-1
 err(i) = x(i)-desired(i);
 square_error(i)= err(i)*err(i);
end
MSE = (sum(square_error))/(N-order-1);
MSE_dB = 20*log10(MSE);
