# nnfpga-new
implementation of feedforward neural network in FPGA

## What is this?
I'm trying to make a FPGA coprocessor that implements a simple feed-forward neural network on a Zedboard. Ideally the CPU will
stream the training examples and correct output and be able to collect the trained parameters from
the FPGA after some time.

I'm hoping to achieve good parallelism (through pipelining) and scalability; that is, should I only manage to deploy a tiny
working system on the Zynq PL (if I even make it that far), I can argue convincingly that the network can be made twice as large
if I had twice the resource in LUTs, FFs, block rams and DSP slices.

16/04/2018:
-------------
The last handful of days have been chaotic. I found some time to read a few papers admist the drama and chaos and found a solution to the flow control problem.
I've also redesigned most of the circuit, so I will begin what will amount to a rewrite of the entire hardware.

1. The difference in data rate between modules is compensated using FIFOs backed by block ram. The number of training examples in parallel will be hard coded (e.g. 128, 256)
so I will get rid of the custom FIFO I pulled from the interwebs.

2. Column processors are inevitable if the performance is to be acceptible. Output PISO shift register is simply a cop-out, one that doesn't work at that. 
I can be stupid as fuck sometimes.
Rather than coming up with elaborate ways for row processors to stall, commit the sum of products to shift register and then to a vector FIFO to match the data rate between layers,
it makes more sense to connect each row processor with its own word FIFO which feeds into column processors of the next layer.

3. The l1 cache shouldn't be part of the row or column processor anymore, but rather should be shared between a column processor of the transpose matrix and a row processor of the
forward propagation matrix. l1 cache units will remain unmodified while training is going on, the derivative sums will be commited to the l2 cache. While training, both ports of
the block ram will be used for reading, one for the forward unit and one for the backward unit; after training, one port will be read, the content modified, and into the other port
will be written the updated weight.

It's just imperative that one works through the algorithm first and design the RTL accordingly when doing this sort of thing rather than jumping into the RTL only to find that
some designs are unworkable. I should have learnt the lesson after the previous two attempts. I hope to god I got the gist of it right this time around.

Immediate TODOs:

write the TDP wrapper to support the aforementioned memory operations.
