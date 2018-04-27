# nnfpga-new
implementation of feedforward neural network in FPGA

## What is this?
I'm trying to make a FPGA coprocessor that implements a simple feed-forward neural network on a Zedboard. Ideally the CPU will
stream the training examples and correct output and be able to use the circuit to make predictions or, possibly, stream the trained
weight and bias out of the FPGA into other systems.

I'm hoping to achieve good parallelism (through pipelining) and scalability; that is, should I only manage to deploy a tiny
working system on the Zynq PL (if I even make it that far), I can argue convincingly that the network can be made twice as large
if I had twice the resource in LUTs, FFs, block rams and DSP slices.

## 27/04/2018
--------------

Progress has been slow, didn't have a chance to work on the project in the last few weeks. Recently finished the dual port ram wrapper
that allows the kinds of access pattern required. The only gotcha is that there needs to be a blank cycle between read-update-write and
read, which should be acceptible.

The algorithm is now clear, but implementation will be hard and debugging extremely difficult. Might be better to draw some schematics so
as not to lose track of design decisions

