#!/bin/bash
cd ..
source ../../config/include/config.sh
rm -rf vhdl
mkdir vhdl
./sigmoidgen -d ${DECIMALS} -f ${FRACTIONS}  > vhdl/sigmoid.vhd
./sigmoidgen -d ${DECIMALS} -f ${FRACTIONS}  -g > vhdl/sigmoidgrad.vhd
