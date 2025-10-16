%% The Protocol Whisperer: Auxiliary function
% This function creates the waveforms of the eCode protocol, including:
% - Fire Pattern
% - IV curve
% - IDrest
% - AP Waveform
% - HyperDepol
% - sAHP

% Oct 2025, Adam Armada-Moreira

function out = computeECode(rheo)

% Fire Pattern
out(1).id = 'firePattern';
out(1).fs = 10000;

tmp = [0,...
    zeros(1,0.1*out(1).fs),...
    ones(1,3.6*out(1).fs)*1.2*rheo,...
    zeros(1,0.1*out(1).fs),...
    ones(1,3.6*out(1).fs)*2*rheo,...
    zeros(1,0.6*out(1).fs)];

out(1).stim = tmp;
out(1).time = [0:numel(out(1).stim)-1] / out(1).fs;

% IV
out(2).id = 'IV';
out(2).fs = 10000;

tmp = [0];
sweeps = [-1.4*rheo:0.2*rheo:0.6*rheo];

for i = 1:numel(sweeps)
    epoch = [zeros(1,0.1*out(2).fs),...
        ones(1,3*out(2).fs)*sweeps(i),...
        zeros(1,0.9*out(2).fs)];
    tmp = [tmp epoch];
end

out(2).stim = tmp;
out(2).time = [0:numel(out(2).stim)-1] / out(2).fs;

% IDrest
out(3).id = 'IDrest';
out(3).fs = 10000;
tmp = [0];
sweeps = [0:0.25*rheo:2.75*rheo];

for i = 1:numel(sweeps)
    epoch = [zeros(1,0.1*out(2).fs),...
        ones(1,1.35*out(2).fs)*sweeps(i),...
        zeros(1,0.35*out(2).fs)];
    tmp = [tmp epoch];
end
out(3).stim = tmp;
out(3).time = [0:numel(out(3).stim)-1] / out(3).fs;

% APwaveform
out(4).id = 'APwaveform';
out(4).fs = 250000;
tmp = [0];
sweeps = [2*rheo:0.5*rheo:3.5*rheo];

for i = 1:numel(sweeps)
    epoch = [zeros(1,0.1*out(4).fs),...
        ones(1,0.05*out(4).fs)*sweeps(i),...
        zeros(1,0.15*out(4).fs)];
    tmp = [tmp epoch];
end
out(4).stim = tmp;
out(4).time = [0:numel(out(4).stim)-1] / out(4).fs;

% HyperDepol
out(5).id = 'HyperDepol';
out(5).fs = 10000;
tmp = [0];
sweeps = [-0.4*rheo:0.4*rheo:0.8*rheo];

for i = 1:numel(sweeps)
    epoch = [zeros(1,0.1*out(5).fs),...
        ones(1,0.4*out(5).fs)*sweeps(i),...
        ones(1,0.27*out(5).fs)*2*rheo,...
        zeros(1,0.18*out(5).fs)];
    tmp = [tmp epoch];
end
out(5).stim = tmp;
out(5).time = [0:numel(out(5).stim)-1] / out(5).fs;

% sAHP
out(6).id = 'sAHP';
out(6).fs = 10000;
tmp = [0];
sweeps = [1.5*rheo:0.5*rheo:3*rheo];

for i = 1:numel(sweeps)
    epoch = [zeros(1,0.1*out(6).fs),...
        ones(1,0.25*out(6).fs)*0.4*rheo,...
        ones(1,0.225*out(6).fs)*sweeps(i),...
        zeros(1,0.425*out(6).fs)];
    tmp = [tmp epoch];
end
out(6).stim = tmp;
out(6).time = [0:numel(out(6).stim)-1] / out(6).fs;
end