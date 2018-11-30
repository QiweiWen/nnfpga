#include <math.h>
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include "truthtable.h"
#include <assert.h>
#include <math.h>
#include <utility>
#include "truthtable.h"

double unisigmoid (double in){
    assert (in >= 0);
    return (double)1/(exp(in * -1) + 1);
}

double unisigmoidgrad (double in){
    assert (in >= 0);
    double sig = unisigmoid (in);
    return sig * (1 - sig);
}

TruthTable::TruthTable (int dec, int frc, FApprox func):
    _dec (dec), _frc (frc), _func(func), _width(dec + frc),
   _vector_result(_width)
{
    table_fill ();
    gen_vector_result();
}

void TruthTable:: table_fill (void)
{
    size_t toobig = (1 << (_width)) - 1;
    FT curr = 0, end = (FT)toobig;
    for (curr = 0; curr <= end; ++curr){
        Fixed f(_dec, _frc, curr);
        double d = f.to_float();
        double result = _func (d);
        Fixed fixed_result(_dec, _frc, result);
        Result r(_dec, _frc) ;
        r. input = f;
        r. output = fixed_result;
        _table.push_back (std::move(r));
    }
}

static inline void number_to_prodterm
            (FT num, prodterm_t& term, int width)
{
    FT mask = 1;
    for (int i = 0; i < width; ++i){
        bit_t bit;
        bit.position = i;
        bit.onoff = ((mask & num) != 0);
        term.push_back (bit);
        mask = mask << 1;
    }
}

void TruthTable::gen_vector_result (void)
{
    for (auto itr = _table.begin(); itr != _table.end(); ++itr){
        Fixed output = itr->output,
              input  = itr->input;
        FT outputraw = output.get_data();
        FT mask = 1;
        for (int i = 0; i < _width; ++i){
            if (mask & outputraw){
                //found new product term
                prodterm_t term;
                number_to_prodterm (input.get_data(), term, _width);
                _vector_result[i].push_back(term);
            }
            mask = mask << 1;
        }
    }
}

const vector_result_t&
TruthTable::get_vector_result(void) const {
    return _vector_result;
}

