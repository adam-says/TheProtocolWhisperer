% The Protocol Whisperer
% This function creates a stim file where the Ornstein noise SD changes

function [time, stim, fs, rangeS] = noiseSweep(S, I0)



rangeS = [0.5 1 1.5 2]; %in fold-change | DECIDE: input or parameter

% Parameters
fs = 20000;
sweepTime = 1; % in s
sweepWait = 1; % in s


stim = [];
for i = 1:numel(rangeS)
    base = ones(1,sweepTime*fs) * I0;
    epoch = [zeros(1,0.5*sweepWait*fs) sg.makeNoise(fs,base,rangeS(i)*S) zeros(1,0.5*sweepWait*fs)];
    stim = [stim epoch];
end

stim = [0 stim];


time = [0:numel(stim)-1] ./ fs;
end %function