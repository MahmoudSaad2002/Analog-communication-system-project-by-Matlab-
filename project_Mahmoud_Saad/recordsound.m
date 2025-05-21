function recorded_signal=recordsound(Fs,duration)
nBits = 16; % number of bits per sample
nChannels = 1; % number of channels (mono)
recObj = audiorecorder(Fs, nBits, nChannels); % create a recording object
disp('Start speaking.')
recordblocking(recObj, duration); % start recording and wait until finished
disp('End of recording.')
recorded_signal = getaudiodata(recObj); % get the recorded data
end
