% The Protocol Whisperer auxiliary function
% 
% This function optimises the SD of OU noise to elicit a desired firing rate
%
% Nov 2025, Adam Armada-Moreira

function optimalS = optimiseNoiseSD(experimentLoad, rangeS, baseS, fs)

% Desired FR
FINALFR = 10; % in Hz

% =====================================================
% Load the data from the abf file
[data,si,h] = sg.abfload(experimentLoad);
vCh = find(strcmp(h.recChUnits,'mV'));
iCh = find(strcmp(h.recChUnits,'pA'));
d.i = squeeze(data(:,iCh,:));
d.v = squeeze(data(:,vCh,:));
d.fs = 1/(si * 1e-6);
d.t = [1:size(d.i,1)] ./ d.fs;

% =====================================================
% Determine the time range for each sweep and calculate FR

nSweeps = numel(rangeS);

binarySweep = d.i;
binarySweep(binarySweep > mean(d.i)) = 1;

TF = ischange(binarySweep);
alllims = find(TF);

% Make a struct with the sweep info
steps = [];
for i = 1:numel(rangeS)
    steps(i).limits = [alllims(2*i -1) (alllims(2*i) -1)];
    deltalimit = steps(i).limits(2) - steps(i).limits(1);
    steps(i).S = rangeS(i) * baseS;
    [pks, locs] = findpeaks(d.v(steps(i).limits(1):step(i).limits(2), 'MinPeakHeight',0);
    if numel(pks) > 1
        steps(i).FR = length(pks) / (deltalimit / fs); % Calculate firing rate
    else
        steps(i).FR = NaN;
    end
end

k = dsearchn([steps.fr]', FINALFR);

optimalS = steps(k).S;

end