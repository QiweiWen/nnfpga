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
04/04/2018:
-------------
Realised that the asymmetric dual port ram wrappers (l2-cache-weight) and (l2-cache-bias) are completely inadequate and useless. What I really need
is a wrapper around the dual port ram that will read the existing value from one port, add the computed delta to it, and then write
the sum through the other port.

What's really bad is that I might need to implement the same algorithm for l1 cache as well. The reason for this is that I realised that
I'm now faced with a massive tradeoff between arithmatic precision, ease of implementation and resource usage: I could, for example, only implement the
"read, add and write"-capable wrapper for the l2 cache, by multiplying the derivatives computed from each training example by a scaled-down
learning rate and summing them directly to the l2 cache. Doing so means, however, that the error will be through the roof as most of the times
the derivative will be scaled down to 0. I could also keep a separate l2 cache for holding sums of derivatices times the real learning rate and
adding the content of the two l2 cache together at the end of the training cycle, but doing so means drastically increasing blockram usage.

That leaves the only remaining choice: implement the "read, add and write"-capable wrapper for the per-row processor l1 cache unit as well.

I think the real way forward is to get rid of my SDP ram unit that l1 cache was based on altogether and use the same hardware module for l1 and
l2. That is, expect overhaul of all modules based on block ram.

I regret not thinking the algorithm through before starting to code so, so very much.
