clc
clear all
close all

recorded=audioread('record_project.wav');% call record signal
recorded_signal=recorded(:,1);
Fs=48000; %sampling freqency
Fc = 3400; % Cutoff frequency
CarrierFreq=48000;
ts=1/(15*CarrierFreq);
t=[0:1/Fs:5-1/Fs]';  %time
%t1=[0:size(recorded_signal)-1/length(recorded_signal)]*ts; 
t1=[0:length(recorded_signal)-1]*ts;
t1=t1';
%sound(recorded_signal,Fs);
%pause(6);
filtered_signal = LPF(recorded_signal,Fc,Fs); %filter signal beyond 3.4 KHz
df=600;
carrier = cos(2*pi*(CarrierFreq)*t1); % carrier signal
mod_index=0.8;
modulated_signal =  (mod_index*(filtered_signal)).*carrier; % modulated signal

%carrier1 = cos(2*pi*(CarrierFreq)*t1);
% coherent detector 
demodulated_signal = modulated_signal .* carrier;
demodulated_signal=LPF(demodulated_signal,Fc,Fs);
%sound(demodulated_signal,Fs);
%pause(6);
%SSB-SC
% carrier2 = sin(2*pi*CarrierFreq*t1); % carrier signal
% ssb_sc_signal = hilbert(filtered_signal) .* carrier2 - filtered_signal.*carrier;
ssb_sc_signal = modulate(filtered_signal,CarrierFreq,15*Fs,'amssb');
demodulated_ssb=demod(ssb_sc_signal,CarrierFreq,15*Fs,'amssb');
%demodulated_ssb = real(LPF(ssb_sc_signal.*carrier2,Fc,Fs));
% sound(demodulated_ssb,Fs);
figure(1)
subplot(2,2,1)
timedomain(modulated_signal,t,'DSB-SC')

subplot(2,2,2)
timedomain(demodulated_signal,t,'DemodulatedSignal')

subplot(2,2,3)
timedomain(real(ssb_sc_signal),t,'SSB-SC')

subplot(2,2,4)
timedomain(demodulated_ssb,t,'DemodulatedSignalSSB')

figure(2)
subplot(2,2,1)
freqdomain(modulated_signal,t1,15*Fs,'DSB-SC(F)')
xlim([-85e3,85e3]);
subplot(2,2,2)
freqdomain(demodulated_signal,t1,15*Fs,'DemodulatedSignal')

subplot(2,2,3)
freqdomain(ssb_sc_signal,t1,15*Fs,'SSB(F)')
xlim([-85e3,85e3]);
subplot(2,2,4)
freqdomain(demodulated_ssb,t1,15*Fs,'DemodulatedSignalSSB')

%  soundsc(demodulated_signal,Fs)
%  pause(5);
%  soundsc(demodulated_ssb,Fs)
%  different values of LO frequency
%  i=0;
%  df=-400;
%  while(i~=5)
%     df=df+200;
%     carrier = cos(2*pi*(CarrierFreq+df)*t); % carrier signal
%     demodulated_signal = LPF(modulated_signal .* carrier,Fc,Fs);
%     soundsc(demodulated_signal,Fs)
%     pause(5);
%     i=i+1;
% end