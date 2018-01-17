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

from optimise import *


def numpy_activate (arr):
    for i in range (0, len(arr)):
        me = arr[i]
        if (me < 0):
            me = np.exp(me)
            arr[i] = me/(1+me)
        else:
            arr[i] = 1/(1 + np.exp(-1 * me))

def numpy_feed_forward (net, inputarr):
    thisvec = inputarr
    bias   = net.bias_vectors
    matrixes = net.weight_matrixes
    for i in range(0,net.nlayers - 1):
        matt = matrixes[i]
        rows = matt.rows
        cols = matt.cols
        #turn matt into numpy array
        npmatt = matt.to_numpy_array()
        biasarr = bias[i].data[0: bias[i].dim]
        thisvec = np. matmul (npmatt, thisvec)
        thisvec += biasarr
        #activate 
        numpy_activate (thisvec)
    return thisvec;

def test_feed_forward():
    net = nn.Neuralnet(reg = 5)
    invec = np.random.random (size = net.nunits[0])
    invec = matwrap.Alnvec (elements = invec)
    res = net.feed_forward (invec)
    npres = numpy_feed_forward (net, np.array(invec.data[0:invec.dim]))
    return (res, npres)

def test_feed_backward():
    net = nn.Neuralnet(reg = 5)
    owidth = net.nunits[net.nlayers - 1]
    NINST = 10
    teachers = [] 
    invecs = []
    for i in range (0, NINST):
        k = randint (0, owidth - 1)
        teachers.append (Alnvec (elements = [0] * owidth))
        teachers[i] [k] = 1
        invec = np.random.random (size = net.nunits[0])
        invec = matwrap.Alnvec (elements = invec)
        invecs.append(invec)
    gc = net.train (invecs, teachers)
    # brute force gradients    
    weight=True
    for i in range (0, net.nparams):
        (isw, tup) = gc.offset_to_coord (i) 
        if ((weight and  isw) != weight):
            weight = isw
            print "bias begins"
        if (isw == True):
            (n, j, k) = tup
            parameter = net.weight_matrixes[n][j,k]
            print ("backprop gradient: %f" %
                    gc.wget(n,j,k))
        else:
            (n, j) = tup
            parameter = 0 
            k = 0
            print ("backprop gradient: %f" %
                    gc.bget(n,j))
        accu = 0
        for inst in range (0, NINST):
            accu += gc.bruteforce (isw, xentro(), invecs[inst], teachers[inst], n, j, k)
        accu += parameter * net.regterm 
        accu /= NINST 
        print ("brute force gradient: %f" % accu)

def test_training():
    net = nn.Neuralnet(reg = 1)
    owidth = net.nunits[net.nlayers - 1]
    NINST = 100 
    teachers = [] 
    invecs = []
    #o[3] = i[4] xor i[2]
    for i in range (0, NINST):
        teachers.append (Alnvec (elements = [0] * owidth))
        invec = np.random.random (size = net.nunits[0])
        invec = matwrap.Alnvec (elements = invec)
        if (invec[4] >= 0.5):
            invec[4] = 1
        else:
            invec[4] = 0

        if (invec[2] >= 0.5):
            invec[2] = 1
        else:
            invec[2] = 0
        
        teachers[i][3] = 0
        if (invec[4] != invec[2]):
            teachers[i][3] = 1

        invecs.append(invec)

    res = do_optimise(net, invecs, teachers)
    pdb.set_trace()
    

if __name__ == "__main__":
    np.random.seed()
    print ("Testing forward prop")
    (res, npres) = test_feed_forward()
    print ("Pause to inspect result")
    pdb.set_trace()
    print ("Testing backprop")
    test_feed_backward()
    print ("Pause to inspect result")
    pdb.set_trace()
    print ("Testing training")
    test_training()




