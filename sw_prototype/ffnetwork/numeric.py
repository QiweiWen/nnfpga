import numpy as np
import os
import sys
import re
import random
import pdb
from numpy import inf

#import matmulWrapper as matwrap
from matwrap import *
import math

def replace_problem_data(arr):
    arr = arr.deepcopy()
    # unpythonic way to replace problem data
    for i in range (0, arr.dim):
        if arr[i] == 0:
            arr[i] = 0.00001
        elif arr[i] == 1:
            arr[i] = 0.99999
    return arr

# cost function for a single training example
class costfun(object):
    # 
    # Y and H: Alnvec objects
    # Y: teacher output
    # H: hypothesis output
    # return value: penalty function value
    def __call__(self, Y, H):
        return 0
# 1/2 * sum((Y - H) .^ 2)
class L2N(costfun):
    def __call__(self, Y, H):
        tmp = Y - H
        pdb.set_trace()
        tmp *= tmp
        res = tmp.sum() / 2
        return res


import pdb
# cross entropy cost function
class xentro(costfun):
    def __call__(self, Y, H):    
        Y = replace_problem_data(Y)
        H = replace_problem_data(H)
        logH = Alnvec(elements=[
           math.log(x) for x in H])
        oneLessH = 1 - H 
        logOLH = Alnvec(elements=[
            math.log(x) for x in oneLessH])
        oneLessY = 1 - Y 
        res = Y*logH + oneLessY*logOLH 
        return -1 * res.sum()

# sigmoid activation function
# vec: Alnvec
def activate(vec, backing=None):
    if (backing is not None):
        res = backing
    else:
        res = Alnvec(rows = vec.dim)
    res.dim = vec.dim
    dim = vec.dim 
    for i in range (0,dim):
        if (vec[i] < 0):
            a = np.exp(vec[i])
            res[i] = a/(1 + a)
        else:
            res[i] = 1/(1 + np.exp(-1* vec[i]))
    return res

# first derivative of the sigmoid function
def sigmoidgrad(vec):
    sigmoid = activate (vec) 
    one_minus_sigmoid = sigmoid * -1
    one_minus_sigmoid += 1
    sigmoid *= one_minus_sigmoid
    return sigmoid





