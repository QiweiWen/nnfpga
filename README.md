# nnfpga-new
implementation of feedforward neural network in FPGA

## What is this?
I'm trying to make a FPGA coprocessor that implements a simple feed-forward neural network on a Zedboard. Ideally the CPU will
stream the biases, training examples and correct output, and be able to collect the trained parameters from
the FPGA after some time.

I'm hoping to achieve good parallelism (through pipelining) and scalability; that is, should I only manage to deploy a tiny
working system on the Zynq PL (if I even make it that far), I can argue convincingly that the network can be made twice as large
if I had twice the resource in LUTs, FFs, block rams and DSP slices.

## Previous Attempts

As the name suggests, this repository is based on an older one. I finished the software prototype relatively quickly and got
bogged down in the FPGA design. I tried out two completely silly designs in hardware and they,
most shockingly, didn't work. By the time I realised my foolishness the repository was already 7 months old with almost 200
commits, mostly made of crap. Starting a new repository removes some of the unease I get when I run "git log".
