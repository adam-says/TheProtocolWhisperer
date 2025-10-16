import scipy.io
import numpy as np
import pyabf
import pyabf.abfWriter as abfWriter
import sys


#if len(sys.argv) < 2:
#    print("Usage: %s matfile.mat abffile.abf" % sys.argv[0])
#    sys.exit(-1)
    
def run_abf_writer(matfile, abffile):
    data = scipy.io.loadmat(matfile)
    signal = data['signal']
    samplingRate = int(data['samplingRate'][0][0])
    abfWriter.writeABF1(signal, abffile, samplingRate, units='pA')
    return

run_abf_writer(matfile, abffile)
#run_abf_writer(sys.argv[1], sys.argv[2])