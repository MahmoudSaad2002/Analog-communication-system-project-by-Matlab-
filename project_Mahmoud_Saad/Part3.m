clc
clear all
close all
recorded=audioread('record_project.wav');
recorded_signal=recorded(:,1);
Fs=48000; %sampling freqency
Fc = 3400; % Cutoff frequency
CarrierFreq=48000;
beta1=3;
beta2=5;
ts=1/(10*CarrierFreq);
t=[0:1/Fs:5-1/Fs]';
t1=[0:size(recorded_signal)-1/length(recorded_signal)]*ts;
t1=t1';

filtered_signal = LPF(recorded_signal,Fc,Fs); %filter signal beyond 3.4 KHz

kf1=(beta1*2*pi*Fc)/(max(filtered_signal));

modulated_signal1 = cos(2*pi*CarrierFreq*t1 + kf1*cumsum(filtered_signal)/Fs);
envelope1 = abs(hilbert(diff(modulated_signal1)));
demodulated_signal1 = envelope1 - mean(envelope1);
demodulated_signal1 = LPF(demodulated_signal1,Fc,Fs);

kf2=(beta2*2*pi*Fc)/(max(filtered_signal));
modulated_signal2 = cos(2*pi*CarrierFreq*t1 + kf2*cumsum(filtered_signal)/Fs);
envelope2 = abs(hilbert(diff(modulated_signal2)));
demodulated_signal2 = envelope2 - mean(envelope2);
demodulated_signal2 = LPF(demodulated_signal2,Fc,Fs);
%single tone
message_freq = 3000; % Message frequency (Hz)
duration = 5;       % Duration of the signal (seconds)
beta_values = [1, 3, 5]; % List of beta values

% Create a time vector
t_sin = [0:1/Fs:duration-1/Fs]';

% Generate the message signal (sinusoidal tone)
message_signal = sin(2*pi*message_freq*t_sin);

figure(1)
subplot(2,1,1)
timedomain(modulated_signal1,t,'Modulated Signal (\beta = 3)')
 xlim([ts*Fs*15,(ts*Fs*15+0.02)]);
 ylim([-2,2]);

subplot(2,1,2)
timedomain(modulated_signal2,t,'Modulated Signal (\beta = 5)')
xlim([ts*Fs*15,(ts*Fs*15+0.02)]);
ylim([-2,2]);

figure(2)
subplot(2,1,1)
freqdomain(modulated_signal1,t1,10*Fs,'S(F) (\beta = 3)')

subplot(2,1,2)
freqdomain(modulated_signal2,t1,10*Fs,'S(F) (\beta = 5)')

% soundsc(demodulated_signal1,Fs)
% pause(5);
% soundsc(demodulated_signal1,Fs)
% Plot the modulated signal and its spectrum for various beta values
figure;

for i = 1:length(beta_values)
    beta = beta_values(i);
    
    % Generate the FM modulated signal
    kf=(beta*2*pi*message_freq)/(max(message_signal));
    fm_modulated_signal = cos(2*pi*CarrierFreq*t + kf*cumsum(message_signal)/Fs);
    
    % Plot the modulated signal
    subplot(length(beta_values), 2, 2*i-1);
    plot(t_sin, fm_modulated_signal);
    xlabel('Time (s)');
    ylabel('Amplitude');
    title(['Modulated Signal (\beta = ' num2str(beta) ')']);
    xlim([ts*Fs*15,(ts*Fs*15+0.01)]);
    ylim([-2,2]);
    % Plot the spectrum of the modulated signal
    subplot(length(beta_values), 2, 2*i);
    f = linspace(-Fs/2, Fs/2, length(t_sin));
    spectrum = fftshift(abs(fft(fm_modulated_signal)));
    plot(f, spectrum);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    title(['Spectrum (\beta = ' num2str(beta) ')']);
end










