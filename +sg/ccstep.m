% The Protocol Whisperer: auxiliary function
%
% This function creates the waveform of a CC step protocol
%
% Oct 2025, Adam Armada-Moreira

function [time, stim, fs] = ccstep()
% Parameters
fs = 10000; % Sampling rate
v_start = -200; % Starting current
v_step = 50; % Current step
v_end = 800; % End current

% Building the waveform
steps = [v_start:v_step:v_end];

stim = [];
for i = 1:numel(steps)
    epoch = [zeros(1,0.1*fs) ones(1,2*fs)*steps(i) zeros(1,0.9*fs)];
    stim = [stim epoch];
end

stim = [0 stim];


time = [0:numel(stim)-1] ./ fs;
end