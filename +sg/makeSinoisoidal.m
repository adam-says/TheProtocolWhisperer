function [time, stim, fs] = makeSinoisoidal(S,RHEO,sineAmp,noisy)
% TMP: these will become function inputs
%S = 2; % SD of noise
%noisy = 0; % Switch to add noise to sine, 0 - no; 1 - yes;
%RHEO = 120;
%sineAmp = 1.5; % Amplitude of the sinusoidal, as a percent of the Rheobase


% Parameters
frequencies = [1,10,20,50,100,200,500,1000];
fs = 20000; % Sampling rate
wait_time = 30; % Wait time between sweeps, in s

dt = 1/fs; % seconds per sample 
StopTime = 50; % seconds 
t = (0:dt:StopTime)'; % seconds 


stim = [zeros(1,1*fs)]; % Initial one second wait


for i = 1:numel(frequencies)
    F = frequencies(i); % Sine wave frequency (hertz) 
    epoch = sineAmp*RHEO*sin(2*pi*F*t);
    epoch = epoch';
    if noisy
        epoch = sg.makeNoise(fs,epoch,S);
    end
    stim = [stim epoch zeros(1,wait_time*fs)];
end

stim = [0 stim];


time = [0:numel(stim)-1] ./ fs;

end