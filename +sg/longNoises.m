function [time, stim, fs] = longNoises(I0, S, repeats, CELLID, CELLDIR)
%repeats = 6; ONLY DBG

fs = 20000; % Sampling rate
stimTime = 60; % in s
stimBuffer = 0.3; % in s

% Building the waveform


stim = [];
for i = 1:repeats
    stim = [zeros(1,stimBuffer*fs) sg.makeNoise(fs,ones(1,stimTime*fs)*I0,S) zeros(1,stimBuffer*fs)];
  stim = [0 stim];


time = [0:numel(stim)-1] ./ fs;

filenameABF = [CELLID '_longNoise_' num2str(i) '.abf'];
sg.exportABF1(stim,fs,[CELLDIR '/' filenameABF])
end

end

