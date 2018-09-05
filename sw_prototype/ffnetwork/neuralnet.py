import numpy as np
#import numeric
import os
import sys
import re
import random
import pdb
from matwrap import *
from numeric import *
import bisect
from operator import add

config_options = {
        "NLAYERS" : "set_nlayers",
        "NUNITS"   : "set_nunits"
}

NLAYERS_MIN = 3
NLAYERS_MAX = 10
EPSILON=0.001

class Neuralnet(object):
# maths stuff
    def __feed_forward_once (self, invec, matt, bias): 
        zres = matt*invec
        zres += bias
        ares = activate (zres)
        return (zres, ares)

    def feed_forward (self, invec):
        resvec = [invec]
        ares = invec
        for i in range(0, self.nlayers - 1):
            (zres, ares) = self.__feed_forward_once (
                    ares,self.weight_matrixes[i], self.bias_vectors[i])
            resvec += [zres, ares]
        return resvec
    
    def feed_backward(self,ffres,Y, log = None):
        nres = len(ffres)
        Aind = nres - 1
        Zind = Aind - 1
        gc = flattener(self)

        f = open (log, "w") if log else None

        for i in reversed(range(1, self.nlayers)):
            A = ffres[Aind]
            Z = ffres[Zind]
            if (i == self.nlayers - 1):
                D = A - Y
            else:
                tmatt = self.transpose_matrixes[i] 
                D = (tmatt * D) * sigmoidgrad(Z)
                if f:
                    f.write ("\n(tcol) transpose matrix columns:\n")
                    for y in range (0, tmatt.cols):
                        for x in range (0, tmatt.rows):
                            f.write ("%f|" % tmatt[(x,y)])
                        f.write("\n");
                        
                    f.write ("\n(trow) transpose matrix row 0:\n")
                    for x in range (0, tmatt.cols):
                        f.write ("%f|" % tmatt[(0,x)])
                    
                    f.write ("\ndLL1:\n")
                    for x in range(0, D.dim):
                        f.write ("%f|" % D[x])
                    f.write ("\n\n")

            Aind -= 2
            Zind -= 2
            lastA = ffres[Aind]
            wgradmatt = D ** lastA
            
            if f:
                f.write ("trows size: %d, tcols size: %d\n" % (wgradmatt.rows, wgradmatt.cols)) 

                f.write ("dL:\n")
                for x in D:
                    f.write ("%f|" % x)

                f.write ("\n(trow) derivative matrix column 0:\n")
                for x in range (0, wgradmatt.rows):
                    f.write ("%f|" % wgradmatt[(x, 0)])

                f.write ("\n(tcol) derivative matrix row 0:\n") 
                for x in range (0, wgradmatt.cols):
                    f.write ("%f|" % wgradmatt[(0, x)])
                if (Zind >= 0):
                    f.write ("\napll1:\n")
                    lastZ = ffres[Zind]
                    for x in range(0, lastZ.dim):
                        f.write ("%f|" % sigmoidgrad(lastZ)[x])

                f.write ("\nall1:\n")
                for x in range (0, lastA.dim):
                    f.write ("%f|" % lastA[x])

            gc.wmattput (i - 1, wgradmatt)
            gc.bvecput (i, D)
        if f:
            f.close()
        return gc 
    
    # ffres_set: precomputed feed forward result (if provided)
    def train (self, invecs, teachers, ffres_set = None):
        if (ffres_set is  None):
            ffres_set = []
            for invec in invecs:
                ffres_set.append (self.feed_forward(invec))
        gcaccu = flattener(self)
        for i in range (0, len(invecs)):
            ffres = ffres_set[i]
            teacher = teachers[i] 
            gcaccu += self.feed_backward(ffres, teacher)
        gcaccu.regularise()
        gcaccu /= len(invecs)
        return gcaccu 
# misc functions
    def set_nlayers(self, arg):
        try:
            nlayers = int (arg) 
            if (nlayers > NLAYERS_MAX) or (nlayers < NLAYERS_MIN):
                raise ValueError ("%d is outside of the range of valid network depths" % nlayers)
            self.nlayers = int (arg)
        except:
            raise SyntaxError("set nlayers") 

    def set_weight(self, layer, coord, weight):    
        matt = self.weight_matrixes[layer]
        conmatt = self.transpose_matrixes[layer]
        x = coord[0]
        y = coord[1]
        matt[(x,y)] = weight
        conmatt[(y,x)] = weight
        self.flatparams.wput (layer, x, y, weight)
    
    def set_bias (self, layer, row, bias):
        vec = self.bias_vectors[layer - 1]
        vec[row] = bias
        self.flatparams.bput (layer, row, bias)

    def set_nunits(self, arg):
        if self.nlayers == 0:
            raise ValueError ("Need to set depths first")
        try:
            nunits = int(arg)
        except:
            raise SyntaxError("set nlayers") 
        self.nunits.append(nunits)
        if (nunits > self.max_units):
            self.max_units = nunits
    
    def refresh_regcost(self):
        if (self.regterm != 0):
            self.regcost = sum([i**2 for i in self.flatparams.backing[0: self.nweights]])
            self.regcost *= self.regterm/2 
        

#Constructor and friends
    # use the H(ma + b) method of introducing bias
    # to avoid frequent array insertion
    # The maths is actually equivalent to the bias unit method
    def __weight_init(self):
        for i in range (0, self.nlayers - 1):
            rows = self.nunits[i + 1]
            cols = self.nunits[i]
            randomweights = np.random.random(size = rows * cols) - 0.5
            self.nweights += len(randomweights)
            # regularisation cost
            squaresum = sum ([i**2 for i in randomweights])
            self.regcost += squaresum
            # reshape for Alnmat
            randomweights = randomweights.reshape (rows, cols)
            matt = Alnmat (randomweights)
            self.weight_matrixes.append(matt)
            tmatt = Alnmat (randomweights.transpose())
            self.transpose_matrixes.append(tmatt) 

            randombias = np.random.random(size = rows) - 0.5
            bias = Alnvec (elements = randombias) 
            self.bias_vectors.append (bias)
            self.nbiases += len(randombias)
        self.nparams = self.nbiases + self.nweights
        self.regcost *= self.regterm/2
        self.flatparams = flattener(self, False)

    def __init__(self, filename= "nn.cfg", reg = 0.0):
        self.nlayers = 0
        self.nunits = []
        self.weight_matrixes = []
        self.transpose_matrixes = []
        self.bias_vectors = []
        self.max_units = 0;
        #regularisation term
        self.regterm = reg
        self.regcost = 0.0 
        #total number of parameters
        self.nparams = 0;
        self.nbiases = 0;
        self.nweights = 0;
        self.flatparams = None
        
        with open (filename) as nn_cfg:
            for line in nn_cfg:
                m = re.match ("\s*\[(.*?)\]\s*(.*)", line)
                if m:
                    opt = m.group(1)
                    arg = m.group(2) 
                    if opt in config_options:
                        try:
                            eval ("self.%s(\"%s\")" % (config_options[opt], arg))
                        except SyntaxError, se:
                            raise SyntaxError ("Syntax Error in line: %s" % line)
                    else:
                        raise SyntaxError ("syntax error in config file:\n%s\n" % line)
                else:
                    raise SyntaxError ("syntax error in config file:\n%s\n" % line) 
        # initialise with random weights 
        self.__weight_init()

class flattener(object):
    def __init__(self, net, grad = True):
        self.neuralnet = net
        self.weight_offsets = []
        self.bias_offsets = []
        self.net = net
        woffset = 0
        boffset = 0
        for i in range (0, net.nlayers - 1):    
            self.weight_offsets.append (woffset)
            self.bias_offsets.append (boffset)
            matt = net.weight_matrixes[i]
            woffset += matt.rows * matt.cols  
            boffset += net.bias_vectors[i].dim
        self.backing = []
        if (grad == True):
            self.backing = [0]* net.nparams
        else:
            for i in range (0, net.nparams):
                (isw, tup) = self.offset_to_coord (i)
                if (isw):
                    (l, j, k) = tup
                    self.backing.append(self.net.weight_matrixes[l][j,k])
                else:
                    (l, j) = tup
                    self.backing.append(self.net.bias_vectors[l - 1][j])
    
    def getwoffset(self, layer, i, j):
        net = self.net
        matt = net.weight_matrixes[layer]
        if (i >= matt.rows) or  (j >= matt.cols):
            raise ValueError ("Index out of range")
        thisoffset = i * matt.cols + j
        offset = thisoffset + self.weight_offsets[layer]
        return offset
    
    def getboffset(self, layer, i):
        net = self.net
        offset = net.nweights
        offset += self.bias_offsets [layer - 1]
        offset += i
        if (i >= net.bias_vectors [layer - 1].dim):
            raise ValueError ("Index out of range")
        return offset

    def offset_to_coord (self, offset):
        if (offset < 0 or offset >= self.net.nparams):
            raise ValueError ("Index out of range")
        if (offset < self.net.nweights):
            isweight = True
            mattindex = bisect.bisect_right (self.weight_offsets, offset) - 1
            matt = self.net.weight_matrixes[mattindex]
            mattoffset = offset - self.weight_offsets [mattindex]
            row = mattoffset//matt.cols
            col = mattoffset % matt.cols
            tup = (mattindex, row, col)
        else:
            isweight = False
            biasindex = bisect.bisect_right (self.bias_offsets, offset - self.net.nweights)
            tup = (biasindex, offset - self.net.nweights - self.bias_offsets [biasindex - 1]) 
            
        return (isweight, tup)

    def wput (self, layer, i, j, val):
        offset = self.getwoffset(layer, i, j)
        self.backing[offset] = val

    def wget (self, layer, i, j):
        offset = self.getwoffset(layer, i, j)
        return self.backing[offset]

    def wmattput (self, layer, gmatt):
        wmatt = self.net.weight_matrixes[layer]
        if (gmatt.rows == wmatt.rows and gmatt.cols == wmatt.cols):
            for i in range (0, gmatt.rows):
                for j in range (0, gmatt.cols):
                    self.wput  (layer, i, j, gmatt[i,j])
        else:
            raise ValueError("Matrix sizes mismatch")

    def bput (self, layer, i, val):
        offset = self.getboffset(layer, i)
        self.backing [offset] = val

    def bget (self, layer, i):
        offset = self.getboffset(layer, i)
        return self.backing [offset]
    
    def bvecput (self, layer, gvec):
        bvec = self.net.bias_vectors[layer - 1]
        if (bvec.dim != gvec.dim):
            raise ValueError("Vector sizes mismatch")
        for i in range (0, bvec.dim):
            self.bput (layer, i, gvec[i])
    #operations to support summing over training examples
    def __iadd__(self,other):
        if (self.net is not other.net):
            raise ValueError ("Invalid summing")
        self.backing = map (add, self.backing, other.backing)
        return self
    def __idiv__(self,m):
        self.backing = [ i/(float(m)) for i in self.backing]
        return self

    def regularise(self):
        for i in range (0, self.net.nweights):
            (isw, coord) = self.offset_to_coord(i)
            (l, j, k) = coord
            self.backing[i] += self.net.weight_matrixes[l][j,k] * self.net.regterm
            

    def bruteforce (self, isweight, cost, inarr, Y, l, i, j = 0):
        if (isweight):
            old = self.net.weight_matrixes[l][i,j]
            self.net.weight_matrixes[l][i,j] = old + EPSILON
            ffres = self.net.feed_forward(inarr)
            aL = ffres[len(ffres) - 1]
            C1 = cost (Y, aL)
            self.net.weight_matrixes[l][i,j] = old - EPSILON
            ffres = self.net.feed_forward(inarr)
            aL = ffres[len(ffres) - 1]
            C2 = cost (Y, aL)
            self.net.weight_matrixes[l][i,j] = old
            return (C1 - C2) / (2*EPSILON)
        else:
            old = self.net.bias_vectors[l - 1][i]
            self.net.bias_vectors[l - 1][i] = old + EPSILON
            ffres = self.net.feed_forward(inarr)
            aL = ffres[len(ffres) - 1]
            C1 = cost (Y, aL)
            self.net.bias_vectors[l - 1][i] = old - EPSILON
            ffres = self.net.feed_forward(inarr)
            aL = ffres[len(ffres) - 1]
            C2 = cost (Y, aL)
            self.net.bias_vectors[l - 1][i] = old
            return (C1 - C2) / (2*EPSILON)            

