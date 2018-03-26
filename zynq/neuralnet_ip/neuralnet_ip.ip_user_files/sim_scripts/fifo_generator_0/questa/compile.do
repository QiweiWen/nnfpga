vlib work
vlib msim

vlib msim/xil_defaultlib

vmap xil_defaultlib msim/xil_defaultlib

vcom -work xil_defaultlib -64 \
"../../../../neuralnet_ip.srcs/sources_1/ip/fifo_generator_0/fifo_generator_0_sim_netlist.vhdl" \


