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
###29/03/2018:
-------------

Completed the transpose matrix. All components of the forward propagation unit is complete.
Next step:
1. Come up with a black box design of the forward propagation unit, work out all input and output
   characteristics
2. Implement it by connecting the lego bricks
