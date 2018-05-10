# nnfpga-new
implementation of feedforward neural network in FPGA

## What is this?
I'm trying to make a FPGA coprocessor that implements a simple feed-forward neural network on a Zedboard. Ideally the CPU will
stream the training examples and correct output and be able to use the circuit to make predictions or, possibly, stream the trained
weight and bias out of the FPGA into other systems.

I'm hoping to achieve good parallelism (through pipelining) and scalability; that is, should I only manage to deploy a tiny
working system on the Zynq PL (if I even make it that far), I can argue convincingly that the network can be made twice as large
if I had twice the resource in LUTs, FFs, block rams and DSP slices.

## 09/05/2018
--------------

After spending some time building up the scaffolding around the column processing unit I finally put the design together into a
VHDL module.

Column processors are the result of an alternative systolic array mapping to the row processor method, whereby parameters are fed
into each processing element in parallel offset by one cycle between neighbours.


    ve. element  [   ]  --->  (eventually) serial output
    ---->        [   ]
                 [   ] <--|
                          |  partial sums
                 [   ] ---|
       ---->     [   ]
                 [   ] <--|
                          |  partial sums
                 [   ] ---|
            ---->[   ]
                 [   ]

Partial sums are calculated in each column processor, passed to its neighbour and accumulated to be output serially in the last unit.

I decided on a "best-effort" approach, that is, all signals are assumed to arrive at the expected clock cycle, which I think is a
reasonable assumption to make after thinking about it carefully. The column processor performs neither buffering nor keeping track
of states in the case where one input arrives but not the other.
