function saveATF(filename, time, stim)

% filename = 'test.txt';
% time = NOISETIME;
% stim = NOISEWAVE;

h1 = {'ATF' '1.0'};
h2 = {0 4};
h3 = {'""' '""' '""' '""'};

values = cell(numel(time),4);

for i = 1:numel(time)
    values{i,1} = time(i);
    values{i,2} = stim(i);
    values{i,3} = stim(i);
    values{i,4} = stim(i);
end
fido = fopen(filename, 'w');
fprintf(fido, '%s\t%s\n', h1{:});
fprintf(fido, '%d\t%d\n', h2{:});
fprintf(fido, '%s\t%s\t%s\t%s\n', h3{:});
for k1 = 1:size(values,1)
    fprintf(fido, '%.4f\t%f\t%f\t%f\n', values{k1,:});
end
fclose(fido);

end