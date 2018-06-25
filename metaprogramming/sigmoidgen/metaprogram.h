#ifndef TMPGEN_H
#define TMPGEN_H

#include "truthtable.h" 
#include "fixedpoint.h"
#include <utility>
#include <iostream>
#include <fstream>
#include <exception>
#include <unordered_map>

#define INPUT "datain"
#define PROD_OUT "pipe_in"
#define SUM_OUT  "dataout"

#define SIGMOIDFILE "./template/sigmoid.vhd.in" 
#define SIGMOIDGRADFILE "./template/sigmoidgrad.vhd.in" 
#define CUE "<GO>"
#define CONST_DUMP "<DICT>"

#define ESPRESSO "./tools/espresso"

typedef struct{
    std::string val;
    std::string type;
}vhdl_const_t;

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
    void print_product_term (prodterm_t, std::vector<size_t>& _pipe_bits);
    void print_sum_term (const sumterm_t&, int);
    void print_dictionary (void);
    TruthTable& _tt;
    std::ifstream infile;
    std::unordered_map <std::string, vhdl_const_t> _running_dict;
};

#endif
