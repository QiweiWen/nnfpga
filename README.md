# nnfpga-new
implementation of feedforward neural network in FPGA

## What is this?
I'm trying to make a FPGA coprocessor that implements a simple feed-forward neural network on a Zedboard. Ideally the CPU will
stream the training examples and correct output and be able to use the circuit to make predictions or, possibly, stream the trained
weight and bias out of the FPGA into other systems.

I'm hoping to achieve good parallelism (through pipelining) and scalability; that is, should I only manage to deploy a tiny
working system on the Zynq PL (if I even make it that far), I can argue convincingly that the network can be made twice as large
if I had twice the resource in LUTs, FFs, block rams and DSP slices.

## 07/05/2018
--------------

Working on moving the fixed point truncation logic out of the critical path by accumulating full sums and only truncating at the output.
Otherwise it'll be difficult to squeeze a block ram read and a multadd into one clock cycle.

Done this for row processor
