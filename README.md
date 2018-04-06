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
06/04/2018:
-------------
Had some thinking over about the algorithm.

1. The number of training examples processed in parallel will be 128. A batch of training examples will be used for a number of iterations
   until they are discarded and the next batch is streamed in from software. Derivatives are added together, the sum shifted 7 bits to the right
   and multiplied with learning rate to avoid rounding error. Hopefully enough to avoid overfitting?

2. Split back propagation into two distinct operations: feeding error terms backwards and storing error terms in FIFO and reading error terms from
   FIFO and updating l2 cache dontent

3. It turns out I can't avoid having column processing elements after all! The output shift register can take input as frequently as every nrows cycles,
   but row processing elements produce output every ncols cycles. That is, only if every layer has fewer neurons than the layer before it will 
   forward propagation work without data hazard. I'm so fucked.
