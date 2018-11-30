#ifndef TRUTH_H
#define TRUTH_H

#include "fixedpoint.h"
#include <vector>

typedef double (*FApprox) (double);

extern double unisigmoid (double);
extern double unisigmoidgrad (double in);

typedef struct{
    int position;
    bool onoff;
}bit_t;

typedef std::vector <bit_t> prodterm_t;
typedef std::vector <prodterm_t> sumterm_t;
typedef std::vector <sumterm_t> vector_result_t;

struct Result{
    Result (int dec, int frc):
        input (dec, frc, (FT)0), output (dec, frc, (FT)0){}
    Fixed input;
    Fixed output;
};

class TruthTable{
private:
    void table_fill (void);
    int _dec, _frc;
    FApprox _func;
    void gen_vector_result(void);
public:
    TruthTable (int dec, int frc, FApprox func = unisigmoid);
    const vector_result_t& get_vector_result(void) const;
    void put_vector_result (vector_result_t&& vec){
        _vector_result = std::move (vec);
    }
    const std::vector <Result>& get_table (void) const
    {
        return _table;
    }
    int _width;
private:
    vector_result_t _vector_result;
    std::vector <Result> _table;
};

#endif
