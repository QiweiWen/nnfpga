# nnfpga-new
implementation of feedforward neural network in FPGA

## What is this?
I'm trying to make a FPGA coprocessor that implements a simple feed-forward neural network on a Zedboard. Ideally the CPU will
stream the training examples and correct output and be able to use the circuit to make predictions or, possibly, stream the trained
weight and bias out of the FPGA into other systems.

I'm hoping to achieve good parallelism (through pipelining) and scalability; that is, should I only manage to deploy a tiny
working system on the Zynq PL (if I even make it that far), I can argue convincingly that the network can be made twice as large
if I had twice the resource in LUTs, FFs, block rams and DSP slices.

The idea is to model matrix-vector multiplcation as systolic arrays allocated along either individual rows or columns of the matrix. In the case of
row processing elements, the input vector feeds serially into the first processing element and is forwarded to subsequent processors, and the
inner products apepar on the output ends of the row processors in parallel. In the case of column processors, elements of the input vector is fed
in parallel to each processor, partial results are forwarded between neighbours, and the result vector is streamed out of the output end of the last
processor in a serial manner. Allowing for the difference in data rate because of matrix dimensions (using fixed-depth FIFOs), the output pattern of
one type of systolic array processor can be said to be identical to the input pattern of the other, allowing them to be combined to form a multi-layer
network.

I observe that rows in the forward-propagation matrix are columns in the backwards-propagation matrix, allowing the dual port weight memory to be shared,
reducing the demand for block ram. Processing elements are written in such a way that they can be implemented either using DSP slices or in fabric. On-line
training is preferred over batch training and the pipeline does not stall even as the weight and bias memory and registers are being partially overwritten,
trading accuracy for performance.

## 16/05/2018
--------------

Realised timing was bad, added block ram output register back in; realised timing was still shit, found out that the FIFO I stole from the internet was garbage, so I re-wrote it. Made adjustments everywhere for the increased FIFO and block ram latency and verified correct operation again, varied FIFO data rate to test full/empty cases, all good.
