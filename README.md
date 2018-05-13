# nnfpga-new
implementation of feedforward neural network in FPGA

## What is this?
I'm trying to make a FPGA coprocessor that implements a simple feed-forward neural network on a Zedboard. Ideally the CPU will
stream the training examples and correct output and be able to use the circuit to make predictions or, possibly, stream the trained
weight and bias out of the FPGA into other systems.

I'm hoping to achieve good parallelism (through pipelining) and scalability; that is, should I only manage to deploy a tiny
working system on the Zynq PL (if I even make it that far), I can argue convincingly that the network can be made twice as large
if I had twice the resource in LUTs, FFs, block rams and DSP slices.

## 13/05/2018
--------------

Verified column processing element operation with two testbenches, one of which only supplies stimuli and the other connects three column processors in series so I could verify the timing of input FIFO reading, weight memory reading and input partial sum addition. Works pretty well, but much trickier than the row processor, and therefore leaves me with a lingering sense of unease.

I spent some time away from the code editor to think through some other areas that have received less thinking through: weight and bias derivative computation.

With a row-major j\*i forward propagation stage, the corresponding backward propagation is column-major. The derivate matrix of the stage being the outer product of delta input and last layer activated output, I propose that the delta vector, which comes from a row-major stage and is therefore distributed across j-many FIFOs, be fed in parallel into j derivative units. Meanwhile the last layer activated output, which comes from a column-major forward propagation stage, is concentrated in one big FIFO buffer. It is therefore fed serially through the first derivative unit at a step per cycle.

Vice-versa for a column-major j\*i stage, with i derivative units and the input characteristics of dL and a(L - 1) reversed, dL being serial because it comes from a column-major stage and a(L-1) being parallel because it came from a row-major forward propagation stage.

The design of the derivative unit is now clear. As for bias, the derivative is just dL, much less tricky than I feared.

I think something resembling a working system is in its infancy.
