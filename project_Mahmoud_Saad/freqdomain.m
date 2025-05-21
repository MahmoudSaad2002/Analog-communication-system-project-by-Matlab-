function freqdomain(signal,t,Fs,name)
%Lfft = length(t);
%Lfft=2^ceil(log2(Lfft));
Lfft = ceil(length(t)); % find length of time domain 
M_freq=fftshift(fft(signal,Lfft));% The fftshift function is used to shift the zero-frequency component to the center of the spectrum.
freqm =(-Lfft/2:Lfft/2-1)/(Lfft/Fs); % x_axis  freq for each sample  
plot(freqm,abs(M_freq))
xlabel('f(Hz)');
ylabel('M(f)');  
title(name);
xlim([-50000,50000]);
end
