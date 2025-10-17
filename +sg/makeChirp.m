%% Chirp
function [time, stim, fs] = makeChirp(RHEOBASE, relamp)

% Parameters
fs = 10000;
NSamples = 50 * fs;
freq_start = 1;
freq_end = 1000;

%freq_space = 'log'; %TODO: allow choice between linear and log freq sweep
amp = relamp * RHEOBASE;


F = [];
CHIRP = [];
for i = 1:NSamples
    F(i) = freq_start + (i/NSamples) *(freq_end-freq_start)*0.5;
    CHIRP(i) = amp * sin(2*pi*F(i)*i*(1/fs));
  
end


stim = [zeros(1,1*fs) CHIRP zeros(1,1*fs)];
stim = [0 stim];


time = [0:numel(stim)-1] ./ fs;
end


