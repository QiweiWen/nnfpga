# nnfpga-new
implementation of feedforward neural network in FPGA

## What is this?
I'm trying to make a FPGA coprocessor that implements a simple feed-forward neural network on a Zedboard. Ideally the CPU will
stream the training examples and correct output and be able to use the circuit to make predictions or, possibly, stream the trained
weight and bias out of the FPGA into other systems.

I'm hoping to achieve good parallelism (through pipelining) and scalability; that is, should I only manage to deploy a tiny
working system on the Zynq PL (if I even make it that far), I can argue convincingly that the network can be made twice as large
if I had twice the resource in LUTs, FFs, block rams and DSP slices.

## 15/05/2018
--------------

Realised timing was bad, added block ram output register back in; realised timing was still shit, found out that the FIFO I stole from the internet was garbage, so I re-wrote it. Made adjustments everywhere for the increased FIFO and block ram latency and verified correct operation again, varied FIFO data rate to test full/empty cases, all good.
