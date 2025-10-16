% The Protocol Whisperer auxiliary function
% 
% This function calculates the rheobase, input resistance, and standard
% deviation for noisy stimulation
%
% Oct 2025, Adam Armada-Moreira

function [RHEOBASE Rin S] = getRheobaseAndNoise(experimentLoad)
[data,si,h] = sg.abfload(experimentLoad);
vCh = find(strcmp(h.recChUnits,'mV'));
iCh = find(strcmp(h.recChUnits,'pA'));
d.i = squeeze(data(:,iCh,:));
d.v = squeeze(data(:,vCh,:));
d.fs = 1/(si * 1e-6);
d.t = [1:size(d.i,1)] ./ d.fs;
amp = [];

for i=1:size(d.v,2)
    amp(i) = max(d.v(:,i));
end

[~, whichLoop] = max(diff(amp));
whichLoop = whichLoop + 1;

rheo_trace = d.i(:,whichLoop);
thresh = (max(rheo_trace) - min(rheo_trace))/2;
TF = ischange(rheo_trace, 'Threshold',thresh);
limits = find(TF);
deltalimit = limits(2) - limits(1);
stimlimits = limits;
stimlimits(1) = stimlimits(1) + deltalimit/2;
v0 = mean(rheo_trace(1:limits(1)-5),'omitnan');
v1 = mean(rheo_trace(stimlimits(1):stimlimits(2)),'omitnan');
RHEOBASE = v1 - v0;

vVal = [];
iVal = [];

for i = 1:max(10,whichLoop-1)
    vVal(i) = median(d.v(stimlimits(1):stimlimits(2),i));
    iVal(i) = median(d.i(stimlimits(1):stimlimits(2),i));
end

% Do a linear regression of the determined values
IVALS = [ones(size(iVal)); iVal];
b = IVALS'\vVal';
Rin = b(2);

% Noise SD estimation
deltaV = 5; % Desired deltaV, in mV
noiseAmp = deltaV / Rin;
S = noiseAmp / 8; %TODO: check if this is ok 



end