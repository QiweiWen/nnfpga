#include <stdio.h>
#include <string.h>
#include "matmul.h"

#define BITMASK ((size_t)0xf)
#define errprint(...) fprintf(stderr, __VA_ARGS__)

static inline size_t ceildiv (size_t a, size_t b){
    if (a % b) return a/b + 1;
    return a/b;
} 

//whether the address is 16 byte aligned
static inline char is_aligned (void* addr){
	size_t res = BITMASK & (size_t)addr;
	return res == 0? 1: 0;
}

//the nearest higher 16 byte aligned address
static inline void* next_aligned (void* addr){
	if (is_aligned (addr)) return addr;
	return ((size_t)addr & ~BITMASK) + (void*)0x10;
}

void    matmul(
        float* d1, int row1, int col1,
        float* d2, int row2,
		float* res)
{
    if (row2 != col1) return;
    /*
     * Sandy Bridge SSE wants 16-byte aligned data addresses
     * Here we assume the data from python is aligned and padded properly
     * 
     */
    float* curr = d1;
    /* Sanity check */
    if (!(is_aligned(d1) && is_aligned(d2))){
        errprint ("Matrix or vector not aligned properly you silly sod\n");
        return ;
    }

    size_t nsse = col1/4;
    int nrems = col1 % 4;
    for (int i = 0; i < row1; ++i){    
        float accu = 0;
        __m128* sse_arr1 = (__m128*)curr,
             * sse_arr2 = (__m128*)d2;
        __m128 sse_accu = _mm_set_ps(0,0,0,0);
        int j = 0;
        for (; j < nsse; ++j){
            sse_accu = SSEADD(sse_accu, SSEMUL(sse_arr1[j], sse_arr2[j]));
        }
        sse_accu = _mm_hadd_ps (sse_accu, sse_accu);
        sse_accu = _mm_hadd_ps (sse_accu, sse_accu);
        accu += _mm_cvtss_f32(sse_accu);
        // can't make any assumptions about the 4-float vector
        // that contains the padding because matmulWrapper.Alnvec's
        // allocated memory can be re-used
        if (nrems){ 
            float* rem1 = (float*)&sse_arr1[j],
                 * rem2 = (float*)&sse_arr2[j];
            for (int i = 0; i < nrems; ++i){
                accu += rem1[i] * rem2[i];
            }
        }
        curr += col1;	
        curr = next_aligned(curr);
        res [i] = accu;
    }
}

static void opt_vec_vec_impl (vecopt_t type, float* d1, float* d2, int size, float* res){	
    int nsse = ceildiv (size, 4);
    __m128* curr1 = (__m128*)d1;
    __m128* curr2 = (__m128*)d2;
    __m128* rescurr = (__m128*)res;
    for (int i = 0; i < nsse; ++i){
        switch (type){
            case vecopt_add:
                *rescurr = SSEADD(*curr1, *curr2);                  
                break;
            case vecopt_mul:
                *rescurr = SSEMUL(*curr1, *curr2);
                break;
            case vecopt_sub:
                *rescurr = SSESUB(*curr1, *curr2); 
                break;
            case vecopt_div:
                *rescurr = SSEDIV(*curr1, *curr2);
        }
        curr1++;
        rescurr++;
        curr2++;
    }
    return;
}

static void opt_vec_sca_impl (vecopt_t type, float* d1, int size, float sca, float* res){	
    __m128 const_vec = _mm_set_ps(sca,sca,sca,sca);
    int nsse = ceildiv (size, 4);
    __m128* curr = (__m128*)d1;
    __m128* rescurr = (__m128*)res;
    for (int i = 0; i < nsse; ++i){
        switch (type){
            case vecopt_add:
                *rescurr = SSEADD(*curr, const_vec);                  
                break;
            case vecopt_mul:
                *rescurr = SSEMUL(*curr, const_vec);
                break;
            case vecopt_sub:
                *rescurr = SSESUB(*curr, const_vec); 
                break;
            case vecopt_div:
                *rescurr = SSEDIV(*curr, const_vec);
        }
        curr++;
        rescurr++;
    }
    return;
}

float opt_vec_collapse_impl (vecopt_t opt, float* d1, int size){ 
    if (opt == vecopt_add || opt == vecopt_mul){
        // again, no assumptions about padded data
        int nsse = size/4; 
        int nrems = size % 4;
        float init_val = opt == vecopt_add? 0: 1;
        __m128 accu = _mm_set_ps(init_val, init_val, init_val, init_val);
        __m128* curr = (__m128*)d1;
        for (int i = 0; i < nsse; ++i){
            accu = opt==vecopt_add?SSEADD(*curr, accu):SSEMUL(*curr,accu); 
            ++curr;
        }
        float sca_accu = opt == vecopt_add? 0: 1;
        if (nrems){
            float* rem = (float*)curr; 
            for (int i = 0; i < nrems; ++i){ 
                if (opt == vecopt_add){
                    sca_accu += rem[i];
                }else{
                    sca_accu *= rem[i]; 
                }
            } 
        }
        if (opt == vecopt_add){ 
            accu = _mm_hadd_ps (accu, accu);
            accu = _mm_hadd_ps (accu, accu);
            return _mm_cvtss_f32(accu) + sca_accu;
        }else{
            //alas 
            float* vec = (float*)&accu;
            float res=  vec[0];
            for (int i = 1; i < 4; ++i){
                res *= vec[i]; 
            } 
            return res * sca_accu;
        }
    }
    errprint ("vector collapse only implemented for add and mul\n");
    return 0;
}
          
#define IMPL_ELEMWISE_VEC(opt) \
void  vec_vec_##opt (float* d1, float* d2, int size, float* res){\
	opt_vec_vec_impl ( vecopt_##opt, d1, d2, size, res);\
}

IMPL_ELEMWISE_VEC(add);
IMPL_ELEMWISE_VEC(mul);
IMPL_ELEMWISE_VEC(div);
IMPL_ELEMWISE_VEC(sub);

#define IMPL_ELEMWISE_SCA(opt) \
void vec_sca_##opt (float* d1, int size, float sca, float* res){ \
	opt_vec_sca_impl (vecopt_##opt, d1, size, sca, res);\
}

IMPL_ELEMWISE_SCA(add);
IMPL_ELEMWISE_SCA(mul);
IMPL_ELEMWISE_SCA(div);
IMPL_ELEMWISE_SCA(sub);

#define IMPL_VEC_COLLAPSE(opt) \
float vec_collapse_##opt (float* d1, int size){ \
    return opt_vec_collapse_impl (vecopt_##opt, d1, size);\
}

IMPL_VEC_COLLAPSE(add);
IMPL_VEC_COLLAPSE(mul);


