function [time, stim, fs] = makeOverlappedSines(I0, S, sineAmp)
%repeats = 6; ONLY DBG

fs = 20000; % Sampling rate
stimTime = 30; % in s
stimBufferBefore = 0.1; % in s
stimBufferAfter = 9; % in s

sineAmp = sineAmp / 8;
frequencies = [2, 11, 19, 47, 101, 199, 499, 997];

% Building the waveform

dt = 1/fs; % seconds per sample 
t = (0:dt:stimTime)'; % seconds 

fullwave = [];
for i = 1:numel(frequencies)
    F = frequencies(i); % Sine wave frequency (hertz)
    epoch = sineAmp*I0*sin(2*pi*F*t);
    epoch = epoch';
    fullwave(i,:) = epoch;
end

finalwave = I0 + sum(fullwave);
noisyWave = sg.makeNoise(fs,finalwave,S);

stim = [zeros(1,stimBufferBefore*fs) noisyWave zeros(1,stimBufferAfter*fs)];
stim = [0 stim];
time = [0:numel(stim)-1] ./ fs;


end

