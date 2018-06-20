#ifndef FIXED_H
#define FIXED_H

#include <assert.h>
#include <stdlib.h>
#include <stdio.h>

#define BITS_PER_BYTE 8

typedef size_t FT;

class Fixed {
public:
    Fixed(int dec, int frac, double value): _decimals (dec), _fractions(frac)
    {
        assert (BITS_PER_BYTE*sizeof(FT) >= (size_t)(_decimals + _fractions));
        _fraction_term = ((size_t)1 << frac);
        *this = value;
    }

    Fixed(int dec, int frac, FT value): _decimals (dec), _fractions(frac)
    {
        assert (BITS_PER_BYTE*sizeof(FT) >= (size_t)(_decimals + _fractions));
        _fraction_term = ((size_t)1 << frac);
        _data = value;
    }

    double to_float(void){
       return ((double)_data) / _fraction_term; 
    }
 
    Fixed& operator=(double d){
        _data = (FT)(d * _fraction_term);
        return *this;
    }

    FT get_data (void) const{
        return _data;
    }
private:
    size_t  _fraction_term; 
    int     _decimals;
    int     _fractions;
    FT      _data;
};

#endif
