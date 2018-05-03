# nnfpga-new
implementation of feedforward neural network in FPGA

## What is this?
I'm trying to make a FPGA coprocessor that implements a simple feed-forward neural network on a Zedboard. Ideally the CPU will
stream the training examples and correct output and be able to use the circuit to make predictions or, possibly, stream the trained
weight and bias out of the FPGA into other systems.

I'm hoping to achieve good parallelism (through pipelining) and scalability; that is, should I only manage to deploy a tiny
working system on the Zynq PL (if I even make it that far), I can argue convincingly that the network can be made twice as large
if I had twice the resource in LUTs, FFs, block rams and DSP slices.

## 03/05/2018
--------------

Got row processor working with the new design, added column processor stub

Removed block ram output register and verified that it had no impact on setup/hold slack at all.

The critical path is truncating multiplication results back to 16 bits.

Next step:

Finish the two other basic modules, column processor and derivative unit. Start wiring everything up into a datapath and
then work on the state machine.
