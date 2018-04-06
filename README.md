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

2. Split back propagation into two distinct operations: 
   2.1. feeding error terms backwards and storing error terms in FIFO
   2.2. reading error terms from FIFO and updating l2 cache content

   Also, unactivated multiplication result doesn't need to go into FIFOs

3. It turns out I can't avoid having column processing elements after all! The output shift register can take input as frequently as every nrows cycles,
   but row processing elements produce output every ncols cycles. That is, only if every layer has fewer neurons than the layer before it will 
   forward propagation work without data hazard. 
   
   I hate myself now because I jumped right into implementation without thinking any of it through. Should have learnt the lesson from the previous
   two attempts...

Immediate TODOs:

1. write the read-update-write dual port blockram wrapper
2. write the column processor and column-major matrix unit. For a given forward propagation matrix its parameter will come from
   the SISO shift register (feeder\_array.vhd) if it is row-major, and the SIPO shift register (param\_sipo.vhd) if it is column major.
   For a given transpose matrix, it is guaranteed to differ from the corresponding feed forward matrix in row/column order, and thus
   can use the same shift register unit. The same parameter stream from l2 cache (row major, increasing order) can still be used, otherwise
   I would have given up right about now...

   So, there needs be four different kinds of matrixes: sipo-row-major, siso-row-major, sipo-column-major and siso-column-major. I think I need
   to consider metaprogramming the HDL files to automate some things.

