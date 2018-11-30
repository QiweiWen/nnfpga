#include <stdlib.h>
#include "metaprogram.h"
#include <vector>
#include <iostream>
#include <fstream>
#include <sys/stat.h>
#include <sys/types.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/wait.h>
#include <assert.h>
#include <ext/stdio_filebuf.h>

void Metaprogrammer::print_product_term
(prodterm_t term, std::vector<size_t>& _pipe_bits){
    static size_t pipeline_bit = 0;
    _pipe_bits.push_back (pipeline_bit);

    if (term.empty()){
        printf (PROD_OUT " (%zu) <= \'1\';\n", pipeline_bit);
    }else{
        printf (PROD_OUT " (%zu) <= \'1\' when ", pipeline_bit);
        for (auto& bit: term){
            printf (INPUT " (%d) = \'%d\' and ", bit.position, bit.onoff?1:0);
        }
        printf ("(true) else '0';\n");
    }

    ++pipeline_bit;
}

void Metaprogrammer::print_sum_term (const sumterm_t& term, int pin){
    if (term.size() == 0){
        printf (SUM_OUT " (%d) <= \'0\';\n", pin);
        return;
    }
    std::vector<size_t> pipeline_bits;
    for (auto itr = term.begin(); itr != term.end(); ++itr){
        print_product_term (*itr, pipeline_bits);
    }

    printf (SUM_OUT " (%d) <= \'1\' when ", pin);
    for (auto bit: pipeline_bits){
        printf (PIPE_OUT " (%zu) = \'1\' or ", bit);
    }
    printf ("(false) else '0';");
}

void Metaprogrammer::print_dictionary (void){
    for (auto& kv: _running_dict){
        const std::string& name = kv.first,
                           val  = kv.second.val,
                           type = kv.second.type;
        printf ("constant %s: %s := %s;\n", name.c_str(), type.c_str(), val.c_str());
    }
}

void Metaprogrammer::do_metaprogram (void){
    std::string line;
    espresso_start();
    vector_result_t result = _tt.get_vector_result();

    // insert a pipeline register between the and gates and or gates
    // to reduce fan-out
    size_t register_size = 0;
    for (auto& sum_term: result)
        register_size += sum_term.size();

    _running_dict ["PIPE_LEN"] = {
        .val = std::to_string(register_size),
        .type = "integer"
    };

    while (getline (infile, line)){
        if (line.find (CONST_DUMP) != std::string::npos){
            print_dictionary ();
        }else if (line.find (CUE) != std::string::npos){
            for (size_t i = 0; i < result.size(); ++i){
                print_sum_term (result[i], i);
                printf ("\n");
            }
        }else{
            std::cout << line << std::endl;
        }
    }
}

static inline bool print_as_binary (size_t bits, const Fixed& num, FILE* fd){
    FT data = num.get_data();
    FT mask = ((FT)1 << (bits - 1));
    for (size_t i = 0; i < bits; ++i){
        int result = fprintf (fd, (mask & data)?"1":"0");
        if (result < 0){
            return false;
        }
        mask = mask >> 1;
    }
    return true;
}

bool Metaprogrammer::stream_to_espresso (int fd){
    FILE* stream = fdopen (fd, "w");
    fprintf (stream, ".i %d\n", _tt._width);
    fprintf (stream, ".o %d\n", _tt._width);
    const std::vector <Result>& raw = _tt.get_table();
    bool success = true;
    for (auto itr = raw.begin(); itr != raw.end(); ++itr){
        success = success && print_as_binary (_tt._width, itr->input, stream);
        success = success && (fprintf (stream, " ") >= 0);
        success = success && print_as_binary (_tt._width, itr->output, stream);
        success = success && (fprintf (stream, "\n") >= 0);
        if (!success){
            return success;
        }
    }
    success = success && (fprintf (stream, ".e\n") >= 0);
    fclose (stream);
    return success;
}

/*
 * extract product term from the left column
 * in the form of --01-110
 */
static inline void read_input_column
(const std::string& column, prodterm_t& term, const TruthTable& _tt)
{
    for (int i = 0; i < _tt._width; ++i){
        int j = _tt._width - i - 1;
        if (column[i] != '-'){
            bit_t bit;
            bit.position = j;
            bit.onoff = (column[i] == '1');
            term.push_back(bit);
        }
    }
}

/*
 * extract output bits from the right column
 * in the form of ~~11~1~~~1
 */
static inline void read_output_column
(const std::string& column, std::vector<int>& outpins, const TruthTable& _tt)
{
    for (int i = 0; i < _tt._width; ++i){
        int j = _tt._width - i - 1;
        if (column[i] == '1') {
            outpins.push_back (j);
        }
    }
}

//trim from left
inline std::string& ltrim(std::string& s, const char* t = " \t\n\r\f\v")
{
    s.erase(0, s.find_first_not_of(t));
    return s;
}

// trim from right
inline std::string& rtrim(std::string& s, const char* t = " \t\n\r\f\v")
{
    s.erase(s.find_last_not_of(t) + 1);
    return s;
}

// trim from left & right
inline std::string& trim(std::string& s, const char* t = " \t\n\r\f\v")
{
    return ltrim(rtrim(s, t), t);
}

void Metaprogrammer::parse_espresso_output (int fd){
    vector_result_t optimised(_tt._width);
    __gnu_cxx::stdio_filebuf<char> filebuf(fd, std::ios::in);
    std::istream is(&filebuf);
    std::string line;
    while (getline (is, line)){
        line = trim (line);
        size_t first_space = line.find_first_of(" \t");
        size_t last_space = line.find_last_of(" \t");
        std::string incol = line.substr(0, first_space);
        std::string outcol = line.substr(last_space + 1, std::string::npos);
        prodterm_t term;
        read_input_column (incol, term, _tt);
        std::vector<int> outpins;
        read_output_column (outcol, outpins, _tt);
        for (auto itr = outpins.begin(); itr != outpins.end(); ++itr){
            optimised [*itr].push_back (term);
        }
    }
    _tt.put_vector_result (std::move(optimised));
    return;
}

void Metaprogrammer::espresso_start(void){
    std::string errmsg;
    const char* orig_table = "./original";
    const char* optimised_table = "./optimised";
    mkfifo (orig_table, 0666);
    mkfifo (optimised_table, 0666);

    int pid = fork();
    if (pid == 0){
        int infd = open (orig_table, O_RDONLY);
        int outfd = open (optimised_table, O_WRONLY);
        dup2 (infd, STDIN_FILENO);
        dup2 (outfd, STDOUT_FILENO);
        close (infd);
        close (outfd);
        char* const argv[4] = {(char*)ESPRESSO,(char*)"-o",(char*)"kiss",NULL};
        execvp (ESPRESSO, argv);
        fprintf (stderr, "CHILD: exec fails\n");
        exit (1);
    }else if (pid > 0){
        int outfd = open (orig_table, O_WRONLY);
        int infd = open (optimised_table, O_RDONLY);
        signal(SIGPIPE, SIG_IGN);
        bool success = stream_to_espresso (outfd);
        close (outfd);
        if (success){
            parse_espresso_output (infd);
        }
        close (infd);
        unlink (orig_table);
        unlink (optimised_table);
        int status;
        waitpid (pid, &status, 0);
        status = WEXITSTATUS (status);
        if (status != 0){
            errmsg = "Espresso returned error\n";
            goto parent_err;
        }
    }else{
        errmsg = std::string("Fork failed: ") + strerror (errno);
        goto parent_err;
    }
    return;
parent_err:
    fprintf (stderr, "%s\n", errmsg.c_str());
    fprintf (stderr, "Using unoptimised truth table\n");
    return;
}
