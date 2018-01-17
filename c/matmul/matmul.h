#ifndef MATMUL_H
#define MATMUL_H

#include <x86intrin.h>

#define SSEMUL _mm_mul_ps
#define SSEADD _mm_add_ps
#define SSESUB _mm_sub_ps
#define SSEDIV _mm_div_ps

/*
 * Multiply a flattened matrix and a vector
 * Why reinvent the wheel?
 * Because I feel like doing so,
 * and I want to teach myself ctypes and SIMD
 */
extern void    matmul(
        float* d1, int row1, int col1,
        float* d2, int row2, float* res);

typedef enum{
	vecopt_mul,
	vecopt_add,
	vecopt_div,
	vecopt_sub
}vecopt_t;


/*
 * vector element wise operations
 */

//vector-vector operations
#define FUN_ELEMWISE_VEC(opt) \
extern void vec_vec_##opt (float* d1, float* d2, int size, float* res)

FUN_ELEMWISE_VEC(add);
FUN_ELEMWISE_VEC(mul);
FUN_ELEMWISE_VEC(div);
FUN_ELEMWISE_VEC(sub);

//vector-scalar operations
#define FUN_ELEMWISE_SCA(opt) \
extern void vec_sca_##opt (float* d1, int size, float sca, float* res);

FUN_ELEMWISE_SCA(add);
FUN_ELEMWISE_SCA(mul);
FUN_ELEMWISE_SCA(div);
FUN_ELEMWISE_SCA(sub);

//vector collapsing operations
#define FUN_VEC_COLLAPSE(opt) \
extern float vec_collapse_##opt(float* d1, int size);
FUN_VEC_COLLAPSE(add);
FUN_VEC_COLLAPSE(mul);

#endif
