clc
clear all
close all

recorded=audioread('record_project.wav');% call record signal
recorded_signal=recorded(:,1);
Characters=audioread('character.wav'); % call char signal
Characters_Signal=Characters(:,1);
Fs=48000; %sampling freqency
Fc = 3400; % Cutoff frequency
CarrierFreq=48000;
ts=1/(15*CarrierFreq); % time sampling for carrier frequency (freq sampling = 15 * freq carrier)
t=[0:1/Fs:5-1/Fs]'; % column for time sampling for signal 
%t1=[0:size(recorded_signal)-1/length(recorded_signal)]*ts;
t1=[0:length(recorded_signal)-1]*ts; % row for time sampling signal after signal carried on carrier
t1=t1';
t2=[0:1/Fs:8-1/Fs]'; % the same for char signal  
%x=length(recorded_signal);
%y=[0:size(recorded_signal)-1/length(recorded_signal)];
filtered_signal = LPF(recorded_signal,Fc,Fs); %filter signal beyond 3.4 KHz
%sound (filtered_signal,Fs);
%pause(6);
filteredc_signal = LPF(Characters_Signal,Fc,Fs);
%sound (filteredc_signal,Fs);


carrier = cos(2*pi*CarrierFreq*t1); % carrier signal
mod_index=0.8;
modulated_signal = (1 + mod_index*(filtered_signal)).*carrier; % modulated signal

%envelope = abs(hilbert(modulated_signal));
envelope = abs(1 + mod_index*(filtered_signal));
demodulated_signal = envelope - mean(envelope);
%sound (demodulated_signal,Fs);


recorded_energy = sum(recorded_signal.^2);
demodulated_energy = sum(demodulated_signal.^2);
%sound (demodulated_signal,Fs);
%pause(6);
scaling_factor = sqrt(recorded_energy/demodulated_energy);
scaled_demodulated_signal = scaling_factor * demodulated_signal;
%sound (scaled_demodulated_signal,Fs);
figure(1)
subplot(2,3,1);
timedomain(recorded_signal,t,'message m(t)') %plotting function in time domain

subplot(2,3,4);
timedomain(filtered_signal,t,'Filtered m(t)')

subplot(2,3,2);
timedomain(Characters_Signal,t2,'Characters m(t)')
subplot(2,3,5);
timedomain(filteredc_signal,t2,'Filtered m(t)')

subplot(2,3,3);
timedomain(modulated_signal,t1,'s(t)')
subplot(2,3,6);
timedomain(scaled_demodulated_signal,t1,'DemodulatedSignal')

figure(2)


subplot(2,3,1);
freqdomain(recorded_signal,t,15*Fs,'M(F)') %plotting function in frequency domain with.. 
%sampling frequency greater ten times than  CarrierFreq
ylim([0,1000])
subplot(2,3,4);
freqdomain(filtered_signal,t,15*Fs,'Filtered M(F)')
ylim([0,1000])
subplot(2,3,2);
freqdomain(Characters_Signal,t2,Fs,'Characters M(F)')
ylim([0,1000])
subplot(2,3,5);
freqdomain(filteredc_signal,t2,Fs,'Filtered M(F)')
ylim([0,1000])
subplot(2,3,3);
freqdomain(modulated_signal,t1,15*Fs,'S(F)')
xlim([-85e3,85e3]);
ylim([0,1000])
subplot(2,3,6);
freqdomain(scaled_demodulated_signal,t1,15*Fs,'DemodulatedSignal')
xlim([-85e3,85e3]);
ylim([0,1000])

% disp('recorded_signal')
% soundsc(recorded_signal,Fs)
% pause(5);
% disp('filtered_signal')
% soundsc(filtered_signal,Fs)
% pause(5);
% disp('demodulated_signal')
% soundsc(demodulated_signal,Fs)
% pause(5);
% disp('scaled_demodulated_signal')
% soundsc(scaled_demodulated_signal,Fs)
%  while Fc>200
%     sig= LPF(recorded_signal,Fc,Fs);
%     fprintf('Cutoff Frequency = %d Hz\n',Fc)
%     soundsc(sig,Fs);
%     pause(5);
%     Fc=Fc-400;
%  end