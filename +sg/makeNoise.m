function noisyStim = makeNoise(fs,stim,s)
% Generate noise stim

noisyStim = [];
fs_ms = fs / 1000;
corr = 5; % in ms, time-constant of the exponential decay of the autocorrelation function of f(t)
noisemean = 0; %TODO: check if this is working correctly
dur = numel(stim);

rng('shuffle')
tmp1 = (1/fs_ms)./corr;
tmp2 = noisemean * tmp1;
tmp3 = s * sqrt(2*tmp1);
stimOut = [];
stimOut(1) = noisemean;
for j=2:dur
    stimOut(j) =  stimOut(j-1) + tmp2 - (tmp1*stimOut(j-1)) + tmp3 * randn();
end

noisyStim = stim + stimOut;



end