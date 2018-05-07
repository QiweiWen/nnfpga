// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.4 (lin64) Build 1412921 Wed Nov 18 09:44:32 MST 2015
// Date        : Mon May  7 15:29:17 2018
// Host        : dave-H110M-S2H running 64-bit Ubuntu 16.04.4 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/dave/workspace/nnfpga/zynq/neuralnet_ip/neuralnet_ip.srcs/sources_1/ip/xbip_multadd_1/xbip_multadd_1_stub.v
// Design      : xbip_multadd_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "xbip_multadd_v3_0_8,Vivado 2015.4" *)
module xbip_multadd_1(A, B, C, SUBTRACT, P, PCOUT)
/* synthesis syn_black_box black_box_pad_pin="A[15:0],B[15:0],C[47:0],SUBTRACT,P[47:0],PCOUT[47:0]" */;
  input [15:0]A;
  input [15:0]B;
  input [47:0]C;
  input SUBTRACT;
  output [47:0]P;
  output [47:0]PCOUT;
endmodule