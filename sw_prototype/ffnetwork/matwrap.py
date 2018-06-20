import math
import numpy as np
import math
import pdb
import ctypes
import inspect

# Sandy Bridge SSE wants 16 byte aligned data
def getAlignedArr(paddim, elements):
    nbytes = 4 * paddim
    data = np.empty(nbytes + 16, dtype=np.uint8);
    startind = -data.ctypes.data % 16
    arr = data[startind:startind + nbytes].view (np.float32). reshape (paddim)
    if len(elements) != 0:
        arr [0: len(elements)] = elements
        arr [len(elements) : paddim] = 0
    return arr

class Alnmat(object):
    def __init__(self, elements):
        self.rows = len(elements)
        self.cols = len(elements[0])
        self.padcols = int (4* math.ceil (self.cols / 4.0))
        self.maxitem = None
        self.minitem = None
        paddim = self.padcols * self.rows; 
        self.data = getAlignedArr(paddim, []);
        base = 0
        for i in range (0, self.rows):
            self.data [base: base + self.cols] = elements[i]
            self.data [base + self.cols: base + self.padcols] = 0
            base += self.padcols
    def __setitem__(self, key, value): 
        if (key [0] >= self.rows) or (key[1] >= self.cols):
            raise IndexError ("Matrix index out of bound")
        # do some auditing for the FPGA
        if (self.maxitem is None) or (self.maxitem < value):
            self.maxitem = value
        if (self.minitem is None) or (self.minitem > value):
            self.minitem = value
        self.data [key[0] * self.padcols + key[1]] = value
    def __getitem__(self, key): 
        if (key [0] >= self.rows) or (key[1] >= self.cols):
            raise IndexError ("Matrix index out of bound")
        return self.data [key[0] * self.padcols + key[1]]
    def __mul__(self, vec):
        res = Alnvec (rows = self.rows)
        matvecmul (self, vec, res)
        return res
        

    def to_numpy_array(self):
        nparr = np.array([0] * (self.rows * self.cols), dtype = np.float32)
        base = 0
        npbase = 0;
        for i in range (0, self.rows):
            nparr[npbase: npbase + self.cols] = self.data[base: base + self.cols]
            base += self.padcols
            npbase += self.cols 
        nparr = np. reshape (nparr, (self.rows, self.cols))  
        return nparr


class Alnvec(object):
    def __init__(self, elements=[], rows=None, backing=None):
        if (len(elements) == 0) and (rows is None):
            raise ValueError ("vector length undefined")
        if rows is None:
            self.dim = len(elements)
        else:
            self.dim = rows;
        self.paddim = int(4 * math.ceil (self.dim / 4.0)) 
        self.maxitem = None
        self.minitem = None

        if backing is None:
            self.data   = getAlignedArr (self.paddim, elements)
        else:
            self.data = backing
    def __getitem__(self, key):
        if (key >= self.dim): 
            raise IndexError ("vector index out of bound")
        return self.data [key]
    def __setitem__(self, key, value):
        if (key >= self.dim):
            raise IndexError ("vector index out of bound")
        if (self.maxitem is None) or (self.maxitem < value):
            self.maxitem = value
        if (self.minitem is None) or (self.minitem > value):
            self.minitem = value
        self.data [key] = value
    def __add__ (self, other,res = None):
        if (res is None):
            res = Alnvec (rows = self.dim)
        if (isinstance(other, Alnvec)):
            vec_vec_opt (OPT_ADD, self, other, res) 
        else:
            vec_sca_opt (OPT_ADD, self, other, res) 
        return res
    def __iadd__(self, other):
        return self.__add__(other, self)
    __radd__ = __add__
    
    def __mul__(self, other, res = None):
        if (res is None):
            res = Alnvec (rows = self.dim)
        if (isinstance(other, Alnvec)):
            vec_vec_opt (OPT_MUL, self, other, res) 
        else:
            vec_sca_opt (OPT_MUL, self, other, res) 
        return res
    
    def __imul__(self, other):
        return self.__mul__(other, self)
    __rmul__ = __mul__
    
    # use the ** operator for a special purpose
    # vec1 ** vec2 = vec1 x vec2.transpose()
    def __pow__ (self, other, res = None):
        if (res is None):
            res = Alnvec (rows = self.dim)
        return mult_perpendicular (self, other)
    
    def __ipow__(self, other):
        return self.__pow__(other, self)
    
    def __sub__(self, other,res = None):
        if (res is None):
            res = Alnvec (rows = self.dim)
        if (isinstance(other, Alnvec)):
            vec_vec_opt (OPT_SUB, self, other, res) 
        else:
            vec_sca_opt (OPT_SUB, self, other, res) 
        return res

    def __isub__(self, other):
        return self.__sub__(other, self) 
    
    def __rsub__(self, other):
        res = Alnvec (rows = self.dim)
        if (isinstance (other, Alnvec)):
            # should not happen
            res = other.__sub__(self)
        else:
            res = -1 * self
            res += other
        return res

    def __len__(self):
        return self.dim
    
    def sum (self):
        return vec_collapse_opt (OPT_ADD, self)
    #copy content into another instance of Alnvec
    def deepcopy (self, backing = None):
        if (backing is not None):
            dstbuf = backing
        else:
            dstbuf = Alnvec(rows=self.dim)

        dstbuf.dim = self.dim
        dstbuf.paddim = self.paddim
        for i in range (0, self.dim):
            dstbuf.data[i] = self.data[i]
        return dstbuf
        

libmatmul = ctypes.cdll.LoadLibrary("libmul.so")
cmatmul = libmatmul.matmul

def matvecmul (mat, vec, backing):
    res = backing 
    res. dim = mat.rows
    cmatmul (ctypes.c_void_p (mat.data.ctypes.data), #float* d1
             ctypes.c_int     (mat.rows),             #int row1
             ctypes.c_int     (mat.cols),             #int col1

             ctypes.c_void_p (vec.data.ctypes.data), #float* d2
             ctypes.c_int     (vec.dim),              #int row2
             ctypes.c_void_p (res.data.ctypes.data));     #float* res

# matt = vec1 * vec2T
def mult_perpendicular (vec1, vec2):
    veclist = []
    for i in vec1:
        res = vec2 * i
        veclist.append(res)
    return Alnmat (veclist)

OPT_DIV=3
OPT_SUB=2
OPT_ADD=1
OPT_MUL=0

cvec_vec_add = libmatmul.vec_vec_add
cvec_vec_sub = libmatmul.vec_vec_sub
cvec_vec_div = libmatmul.vec_vec_div
cvec_vec_mul = libmatmul.vec_vec_mul
cvec_sca_add = libmatmul.vec_sca_add
cvec_sca_sub = libmatmul.vec_sca_sub
cvec_sca_mul = libmatmul.vec_sca_mul
cvec_sca_div = libmatmul.vec_sca_div

cvec_col_add = libmatmul.vec_collapse_add
cvec_col_add.restype = ctypes.c_float
cvec_col_mul = libmatmul.vec_collapse_mul
cvec_col_mul.restype = ctypes.c_float

cvec_vec_funcs = [cvec_vec_mul, cvec_vec_add, cvec_vec_sub, cvec_vec_div];
cvec_sca_funcs = [cvec_sca_mul, cvec_sca_add, cvec_sca_sub, cvec_sca_div];
cvec_col_funcs = [cvec_col_mul, cvec_col_add]


def vec_vec_opt (opt, vec1, vec2, backing):
    if (vec1.dim != vec2.dim):
        raise ValueError ("vector size mismatch")
    res = backing 
    res.dim = vec1.dim
    cfunc = cvec_vec_funcs[opt];
    cfunc (ctypes.c_void_p (vec1.data.ctypes.data),
                       ctypes.c_void_p (vec2.data.ctypes.data),
                       ctypes.c_int (vec1.dim),
                       ctypes.c_void_p (res.data.ctypes.data))

def vec_sca_opt (opt, vec1, sca, backing):
    res = backing
    res.dim = vec1.dim
    cfunc = cvec_sca_funcs[opt];
    cfunc (ctypes.c_void_p (vec1.data.ctypes.data),
                      ctypes.c_int (vec1.dim),
                      ctypes.c_float (sca),
                      ctypes.c_void_p (res.data.ctypes.data))

def vec_collapse_opt (opt, vec1):
    cfunc = cvec_col_funcs[opt] 
    res = cfunc (ctypes.c_void_p (vec1. data. ctypes.data), vec1. dim);
    return res



