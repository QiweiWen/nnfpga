# nnfpga-new
implementation of feedforward neural network in FPGA

## What is this?
I'm trying to make a FPGA coprocessor that implements a simple feed-forward neural network on a Zedboard. Ideally the CPU will
stream the training examples and correct output and be able to collect the trained parameters from
the FPGA after some time.

I'm hoping to achieve good parallelism (through pipelining) and scalability; that is, should I only manage to deploy a tiny
working system on the Zynq PL (if I even make it that far), I can argue convincingly that the network can be made twice as large
if I had twice the resource in LUTs, FFs, block rams and DSP slices.

## High level design

Rather than implementing a neural network verbatim by modeling each neuron individually, I decided early on to base the design
around the matrix-vector product operations. The complex interconnection between layers has been a major source of 
non-scalability, which I hope to avoid.

I'm using the systolic array method of matrix-vector multiplication, where each input vector element is forwarded from one row
processor to the next, and the output vector is completed in O(row + col) cycles. See the paper in chapter 5 of the book, 
"FPGA Implementations of Neural Networks" by A.R.Omondi for the main inspiration for the design, although I took a number of
different design decisions, the most important of which are listed in the following paragraph.

Rather than using a fixed number of processing elements that switch between processing the rows and columns of the two matrixes, I opted for a simpler approach whereby
the matrixes are only ever row-major, with a processing element instantiated for each row. Different layers are then realised with
separate hardware modules rather than the same module time-multiplexed between modes. The parallel output from each matrix is collected
into a parallel-in, serial-out shift register to be fed into the next stage. The result is that each matrix-vector product incurs an additional latency
roughly as many more cycles long as there are rows in the weight matrix, and more hardware is instantiated for the same use case implemented in the
paper (a single hidden layer), but it also means that the entire process is now pipelined between training examples and that implementing
different network layouts is possible. I've also opted for inferred RAM rather than shift registers to hold weight and bias parameters, trading
latency for lower resource usage.

The backprop part I haven't thought through as much, but the gist of it is that intermediate results from forward propagation are stored in blockram and
updated parameters are stored in a "level 2 cache". After iterating through all the training examples, the new parameters are dumped from L2 cache to
the row processors, representing one step of gradient descent. The process continues for a number of cycles specified from CPU, after which the software
examines the trained parameters and decides whether to continue training.

## Previous Attempts

As the name suggests, this repository is based on an older one. I finished the software prototype relatively quickly and got
bogged down in the FPGA design. I tried out two completely silly designs in hardware and they,
most shockingly, didn't work. By the time I realised my foolishness the repository was already 7 months old with almost 200
commits, mostly made of crap. Starting a new repository removes some of the unease I get when I run "git log".

## Plan going forward

Implement forward propagation, get PS-PL communication going, verify circuit operation, move on to backprop
