/*
 * Generates a combinational sigmoid unit
 *
 */

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string>
#include "fixedpoint.h"
#include "truthtable.h"
#include "metaprogram.h"
#include <exception>
#include <cstring>

#define OPTIONS ":d:f:g"
#define EXECNAME "sigmoidgen"
#define MAXWIDTH 32

static void print_usage(const char* me, const std::string& err){
    if (err.size())
        printf ("%s\n", err.c_str());
    printf ("%s -d [decimal bits] -f [fraction bits] [-g]\n", me);
}

static void metaprogram (int dec, int frc, bool grad){
    FApprox func = grad? unisigmoidgrad: unisigmoid;
    TruthTable tt(dec, frc, func);
    try{
        Metaprogrammer mp(tt, grad);
        mp.do_metaprogram();
    }catch (const std::exception& e){
        printf ("failed opening template %s for reading: %s\n",  
                grad? SIGMOIDGRADFILE:SIGMOIDFILE, strerror (errno));
    }
}

int main (int argc, char** argv){
    char c;
    int decimals = -1, fractions = -1;
    bool decset = false, fracset = false, isgrad = false;
    std::string errmsg;
        
    while ((c = getopt(argc, argv, OPTIONS)) != -1){
        bool wrong = false;
        switch (c){
        case 'd':
            decset = true;
            decimals = atoi (optarg);
            break;
        case 'f':
            fracset = true;
            fractions = atoi (optarg);
            break;
        case 'g':
            isgrad = true;
            break;
        case '?':
            errmsg = std::string("Unrecognised option ") + (char)optopt; 
            wrong = true;
            break;
        case ':':
            errmsg = std::string("Option requires an argument: ") + (char)optopt;
            wrong = true;
            break;
        }
        if (wrong)
            goto WRONG; 
    }
    if (!decset){
        errmsg = "Decimal bit depth not set";
        goto WRONG;
    }
    if (!fracset){
        errmsg = "Fraction bit depth not set";
        goto WRONG;
    }
    if ((decimals < 0 || fractions < 0) || (decimals + fractions > MAXWIDTH)){
        errmsg = std::string ("Invalid bit depths specified: ") 
                                + std::to_string(decimals) + "," 
                                + std::to_string(fractions); 
        goto WRONG;
    }
    metaprogram (decimals, fractions, isgrad);
    return EXIT_SUCCESS;
WRONG:
    print_usage (EXECNAME, errmsg);
    return EXIT_FAILURE;
}   
