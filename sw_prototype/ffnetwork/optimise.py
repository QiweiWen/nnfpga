from neuralnet import *
from matwrap import *
from numeric import *
import numpy as np
from scipy.optimize import minimize

# Wrapper class over function and backprop that scipy.optimize.minimize can understand
class opti_wrapper(object):
    def __init__(self, net, invecs, teachers, cost):
        self.net = net
        self.costfunc = cost
        self.invecs = invecs
        self.teachers = teachers

    def __call__(self,paramlist):
        # parameter update
        for i in range (0, len(paramlist)):
            (isw, tup) = self.net.flatparams.offset_to_coord(i)
            if (isw):
                (l, j, k) = tup
                self.net.set_weight(l, (j,k), paramlist[i])
            else:
                (l, j) = tup
                self.net.set_bias(l, j, paramlist[i])
        self.net.refresh_regcost() 
        # cost computation
        ffres_set = []
        accucost = 0
        for i in range (0, len(self.invecs)):
            teacher = self.teachers[i]
            invec = self.invecs[i]
            ffres = self.net.feed_forward(invec)
            ffres_set.append(ffres)
            netout = ffres[len(ffres) - 1]
            thiscost = self.costfunc(teacher, netout) 
            accucost += thiscost
        accucost += self.net.regcost
        accucost /= len(self.invecs)
        # gradient computation
        print ("%f" % accucost)
        grads = self.net.train(self.invecs, self.teachers, ffres_set).backing
        return (accucost, grads)


def do_optimise (net, invecs, teachers, cost = xentro()):
    ow = opti_wrapper(net, invecs, teachers, cost)
    fmin = minimize (fun = ow, x0 = net.flatparams.backing, method='TNC', jac=True, options={'maxiter': 500})
    return fmin
