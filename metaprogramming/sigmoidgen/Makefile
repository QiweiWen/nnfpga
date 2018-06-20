.PHONY: all, clean

CXX=g++
CFLAGS=-O2 -Wall -std=gnu++11
LFLAGS=-lm -pthread

OBJECTS=$(patsubst %.cpp,%.o,$(wildcard *.cpp))
HDLS=vhdl/sigmoid.vhd vhdl/sigmoidgrad.vhd

all: ${HDLS}

${HDLS}: sigmoidgen
	@chmod a+x tools/espresso
	cd scripts && ./vhdlgen.sh

sigmoidgen: ${OBJECTS}
	${CXX} ${LFLAGS} -o $@ $^

.cpp.o:
	$(CXX) $(CFLAGS) -c $<



clean:
	rm -f *.o
	rm -f sigmoidgen
	rm -rf vhdl
