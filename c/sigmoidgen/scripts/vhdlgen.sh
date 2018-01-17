#!/bin/bash
cd ..
source ../../include.mk
rm -rf vhdl
mkdir vhdl
./sigmoidgen -d ${DECIMALS} -f ${FRACTIONS}  > vhdl/sigmoid.vhd
./sigmoidgen -d ${DECIMALS} -f ${FRACTIONS}  -g > vhdl/sigmoidgrad.vhd


