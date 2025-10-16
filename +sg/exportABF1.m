function exportABF1(stim, fs, outputname)
% Define the Python environment
pythonExe = '/usr/bin/python3'; % Replace with your Python path
pyenv('Version', pythonExe);
% Verify the environment
pe = pyenv;

% Add the directory containing the Python script to the Python path
path_add = fileparts(which('run_abf_writer.py'));
if count(py.sys.path, path_add) == 0
    insert(py.sys.path, int64(0), path_add);
end

% Attempt to import the module
try
    py.importlib.import_module('pyabf');
catch e
    disp('Error importing the module:');
    disp(e.message);
end    
signal = stim;
samplingRate = fs;
save('TMP.mat', 'signal', 'samplingRate');
pyrunfile("run_abf_writer.py",matfile='TMP.mat', abffile=outputname)
delete('TMP.mat')


end