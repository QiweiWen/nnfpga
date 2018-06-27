#!/usr/bin/python
import neuralnet as nn
import pdb
import os
import sys
import numpy as np
#import numeric
import warnings

import matwrap
import time
from numeric import *
from random import randint

def trow_processor_test():
    net = nn.Neuralnet()
    owidth = net.nunits[net.nlayers - 1]
    NINST = 10
    os.system ("rm -rf log && mkdir log")
    teachers = [] 
    invecs = []
    for i in range (0, NINST):
        k = randint (0, owidth - 1)
        teachers.append (Alnvec (elements = [0] * owidth))
        teachers[i] [k] = 1
        invec = np.random.random (size = net.nunits[0])
        invec = matwrap.Alnvec (elements = invec)
        invecs.append(invec)
    
    for i in range (0, NINST):
        ffres = net.feed_forward (invecs[i])
        net.feed_backward (ffres, teachers[i], \
                           log = os.path.join("log", "fpgatest.log.%d" % i))

if __name__ == "__main__":
    trow_processor_test()


