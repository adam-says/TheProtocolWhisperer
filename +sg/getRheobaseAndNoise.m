% The Protocol Whisperer auxiliary function
% 
% This function calculates the rheobase, input resistance, 
% current needed to elicit a desired firing rate, and standard
% deviation for noisy stimulation
%
% Nov 2025, Adam Armada-Moreira

function [RHEOBASE Rin S OUTCUR] = getRheobaseAndNoise(experimentLoad)

% =====================================================
% Load the data from the abf file
[data,si,h] = sg.abfload(experimentLoad);
vCh = find(strcmp(h.recChUnits,'mV'));
iCh = find(strcmp(h.recChUnits,'pA'));
d.i = squeeze(data(:,iCh,:));
d.v = squeeze(data(:,vCh,:));
d.fs = 1/(si * 1e-6);
d.t = [1:size(d.i,1)] ./ d.fs;
amp = [];

% =====================================================
% Calculate the rheobase
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

% =====================================================
% Calculate IV relationship, using subthreshold sweeps
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


% =====================================================
% Determine current needed to elicit a specific firing rate
% TODO: give the desired FR as input to the function
% TODO: Make the determined current an output of the function
counter = 1;
CUR = [];
FR = [];
for i = whichLoop:size(d.v,2)
    iLevel = d.i(:,i);
    thresh = (max(iLevel) - min(iLevel))/2;
    TF = ischange(iLevel, 'Threshold',thresh);
    limits = find(TF);
    deltalimit = limits(2) - limits(1);
    CUR(counter) = round(median(iLevel(limits(1)+5:limits(2)-5)) - median(iLevel(1:limits(1)-5)));

    [pks, locs] = findpeaks(d.v(:,i), 'MinPeakHeight',0);
    if numel(pks) > 1
        FR(counter) = length(pks) / (deltalimit / d.fs); % Calculate firing rate
    else
        FR(counter) = NaN;
    end

    counter = counter + 1;
end

% Find the current value that elicits MINFR and MAXFR
MINFR = 5;
MAXFR = 10;

whichFRidx = find(FR >= MINFR & FR < MAXFR, 1);

if isempty(whichFRidx)
    whichFRidx = find(isnan(FR),1,'last');
end

OUTCUR = CUR(whichFRidx);



end