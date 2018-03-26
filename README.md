# nnfpga-new
implementation of feedforward neural network in FPGA

## What is this?
I'm trying to make a FPGA coprocessor that implements a simple feed-forward neural network on a Zedboard. Ideally the CPU will
stream the training examples and correct output and be able to collect the trained parameters from
the FPGA after some time.

I'm hoping to achieve good parallelism (through pipelining) and scalability; that is, should I only manage to deploy a tiny
working system on the Zynq PL (if I even make it that far), I can argue convincingly that the network can be made twice as large
if I had twice the resource in LUTs, FFs, block rams and DSP slices.

## Current Progress:
26/03/2018:
-------------
sketched out a design that separates the forward prop and back prop logic into a consumer and producer logic separated by fixed-size
FIFOs. FIFO depth == number of parallel training examples taken before blocking for software input.

currently working on: 
1. SIPO shift register for feeding parameter stream into conjugate matrix units
2. FIFO buffer for storing unactivated matrix multiplication result
