function signal=LPF(inp,Fc,Fs)
[b,a] = butter(6,Fc/(Fs)); % 6th-order low-pass Butterworth filter
signal = filter(b, a, inp);
end