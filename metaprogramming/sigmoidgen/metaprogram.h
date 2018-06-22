#ifndef TMPGEN_H
#define TMPGEN_H

#include "truthtable.h" 
#include "fixedpoint.h"
#include <utility>
#include <iostream>
#include <fstream>
#include <exception>

#define INPUT "datain"
#define OUTPUT "dataout_pipe"


#define SIGMOIDFILE "./template/sigmoid.vhd.in" 
#define SIGMOIDGRADFILE "./template/sigmoidgrad.vhd.in" 
#define CUE "<GO>"

#define ESPRESSO "./tools/espresso"

class Metaprogrammer{
public: 
    Metaprogrammer(TruthTable& tt, bool isgrad): 
        _tt(tt), infile (isgrad? SIGMOIDGRADFILE: SIGMOIDFILE)
    {
        if (!infile.is_open()){
            throw std::exception(); 
        }
    }
    void espresso_start(void);
    bool stream_to_espresso (int fd);
    void parse_espresso_output (int fd);
    void do_metaprogram(void);
private:
    void print_product_term (prodterm_t);
    void print_sum_term (const sumterm_t&, int);
    TruthTable& _tt;
    std::ifstream infile;
};

#endif
