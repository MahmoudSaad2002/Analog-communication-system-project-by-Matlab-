clc
clear all
close all
recorded_signal=audioread('record_project.wav');

% Define parameters
fs = 48000;         % Sampling frequency (Hz)
fc = 48000;         % Carrier frequency (Hz)
ts=1/(10*fc);
message_freq = 3000; % Message frequency (Hz)
duration = 2;       % Duration of the signal (seconds)
beta_values = [3, 5]; % List of beta values
noise_levels = [40,30,20,15,10,5]; % List of noise levels 

% Create a time vector
t = 0:1/fs:duration-1/fs;


% Generate the message signal (sinusoidal tone)
message_signal = sin(2*pi*message_freq*t);

t1=[0:size(message_signal)-1/length(message_signal)]*ts;
t1=t1';



for i = 1:length(noise_levels)
    
beta= beta_values(1);
kf = (2*pi*beta*message_freq);
modulated_fm = cos(2*pi*fc*t1+kf*cumsum(message_signal)/fs);
received_signal = awgn(modulated_fm,noise_levels(i),mean(modulated_fm.^2));
%demodulation
env = abs(hilbert(diff(received_signal)));
demodulated_signal = env - mean(env);

demodulated_signal = LPF(demodulated_signal,3400,fs);

%fprintf('SNR = %d dB\n',noise_levels(i));
% 
% soundsc(demodulated_signal,fs)
% pause(2)


end


beta_values = [10,20,30,40,50,60];
SNR_LEVEL=30;
for i = 1:length(beta_values)
   beta=beta_values(i);
   
    kf = (2*pi*beta*message_freq);
    modulated_fm = cos(2*pi*fc*t1+kf*cumsum(message_signal)/fs);
    received_signal = awgn(modulated_fm,SNR_LEVEL,mean(modulated_fm.^2));
    %demodulation
    env = abs(hilbert(diff(received_signal)));
    demodulated_signal = env - mean(env);

    demodulated_signal = LPF(demodulated_signal,3400,fs);
%     fprintf('Beta = %d \n',beta_values(i));
%      soundsc(demodulated_signal,fs)
%      pause(2);
end




