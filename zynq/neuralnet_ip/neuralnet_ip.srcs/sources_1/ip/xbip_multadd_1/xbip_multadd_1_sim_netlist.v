// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.4 (lin64) Build 1412921 Wed Nov 18 09:44:32 MST 2015
// Date        : Tue May  8 22:30:39 2018
// Host        : dave-MS-7A37 running 64-bit Ubuntu 17.10
// Command     : write_verilog -force -mode funcsim
//               /home/dave/workspace/nnfpga/zynq/neuralnet_ip/neuralnet_ip.srcs/sources_1/ip/xbip_multadd_1/xbip_multadd_1_sim_netlist.v
// Design      : xbip_multadd_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "xbip_multadd_1,xbip_multadd_v3_0_8,{}" *) (* core_generation_info = "xbip_multadd_1,xbip_multadd_v3_0_8,{x_ipProduct=Vivado 2015.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=xbip_multadd,x_ipVersion=3.0,x_ipCoreRevision=8,x_ipLanguage=VHDL,x_ipSimLanguage=VHDL,C_VERBOSITY=0,C_XDEVICEFAMILY=zynq,C_A_WIDTH=16,C_B_WIDTH=16,C_C_WIDTH=48,C_A_TYPE=0,C_B_TYPE=0,C_C_TYPE=0,C_CE_OVERRIDES_SCLR=0,C_AB_LATENCY=0,C_C_LATENCY=0,C_OUT_HIGH=47,C_OUT_LOW=0,C_USE_PCIN=0,C_TEST_CORE=0}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "xbip_multadd_v3_0_8,Vivado 2015.4" *) 
(* NotValidForBitStream *)
module xbip_multadd_1
   (A,
    B,
    C,
    SUBTRACT,
    P,
    PCOUT);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 c_intf DATA" *) input [47:0]C;
  (* x_interface_info = "xilinx.com:signal:data:1.0 subtract_intf DATA" *) input SUBTRACT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) output [47:0]P;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcout_intf DATA" *) output [47:0]PCOUT;

  wire [15:0]A;
  wire [15:0]B;
  wire [47:0]C;
  wire [47:0]P;
  wire [47:0]PCOUT;
  wire SUBTRACT;

  (* C_AB_LATENCY = "0" *) 
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "16" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_C_LATENCY = "0" *) 
  (* C_C_TYPE = "0" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_OUT_HIGH = "47" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_USE_PCIN = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* DONT_TOUCH *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  xbip_multadd_1_xbip_multadd_v3_0_8 U0
       (.A(A),
        .B(B),
        .C(C),
        .CE(1'b0),
        .CLK(1'b0),
        .P(P),
        .PCIN({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .PCOUT(PCOUT),
        .SCLR(1'b0),
        .SUBTRACT(SUBTRACT));
endmodule

(* C_AB_LATENCY = "0" *) (* C_A_TYPE = "0" *) (* C_A_WIDTH = "16" *) 
(* C_B_TYPE = "0" *) (* C_B_WIDTH = "16" *) (* C_CE_OVERRIDES_SCLR = "0" *) 
(* C_C_LATENCY = "0" *) (* C_C_TYPE = "0" *) (* C_C_WIDTH = "48" *) 
(* C_OUT_HIGH = "47" *) (* C_OUT_LOW = "0" *) (* C_TEST_CORE = "0" *) 
(* C_USE_PCIN = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "zynq" *) 
(* ORIG_REF_NAME = "xbip_multadd_v3_0_8" *) (* downgradeipidentifiedwarnings = "yes" *) 
module xbip_multadd_1_xbip_multadd_v3_0_8
   (CLK,
    CE,
    SCLR,
    A,
    B,
    C,
    PCIN,
    SUBTRACT,
    P,
    PCOUT);
  input CLK;
  input CE;
  input SCLR;
  input [15:0]A;
  input [15:0]B;
  input [47:0]C;
  input [47:0]PCIN;
  input SUBTRACT;
  output [47:0]P;
  output [47:0]PCOUT;

  wire [15:0]A;
  wire [15:0]B;
  wire [47:0]C;
  wire CE;
  wire CLK;
  wire [47:0]P;
  wire [47:0]PCIN;
  wire [47:0]PCOUT;
  wire SCLR;
  wire SUBTRACT;

  (* C_AB_LATENCY = "0" *) 
  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "16" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_WIDTH = "16" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_C_LATENCY = "0" *) 
  (* C_C_TYPE = "0" *) 
  (* C_C_WIDTH = "48" *) 
  (* C_OUT_HIGH = "47" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_USE_PCIN = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  xbip_multadd_1_xbip_multadd_v3_0_8_viv i_synth
       (.A(A),
        .B(B),
        .C(C),
        .CE(CE),
        .CLK(CLK),
        .P(P),
        .PCIN(PCIN),
        .PCOUT(PCOUT),
        .SCLR(SCLR),
        .SUBTRACT(SUBTRACT));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2014"
`pragma protect key_keyowner = "Cadence Design Systems.", key_keyname= "cds_rsa_key", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 64)
`pragma protect key_block
JL1bgZMx6U/X68gqWYEktEeyyqogxjU6605fDMFU02lleo6HD4lzSSgVu15+6eh9MhyqgldeM/6o
I0kVXr5V5w==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-VERIF-SIM-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
hPwPY8s4HGGCASWdsZM1chsYI5faNryrLywhhOe8pKC9hhGq6HG/BWJNQww4SuZk0SOGqxGAMrRJ
4WJSFCIsCENQYFOhjV9ssmXXTr+yHnioFOYehmB7mvwvpnMjDZrZrsb9Ra9R+BR3JdU11UTX96BB
8huBSBhYVB5X+ilDRs0=


`pragma protect key_keyowner = "Xilinx", key_keyname= "xilinx_2014_03", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
IeQJymaodDStiUSbw50TxoTGG7Szf6kBlERO2XRm+tNT8NZIVKGso+psxRlFxY7BnFPBkLwVOEG8
NP1lu+LK0PrSJ+O2LqtZfosASdiWrR0xM+VgOtoOeDTDqe5qjtxywkvFWF3s/B0abwmkjIxJ1uaR
Rhe2AKUUPfVjIrIv9zVMzELYW6VyF1faCEy3hcy02aiI3gcpgky7yPi6Xm52tp24Uy3KfxeZVlvM
6zwO/qjskGYC0OaVImySqBoIJxEFK/8XtO4uNH+a+vM2U5Eoq8JFl+lTiyQYBZHXusDG9VobgswG
I0+06i9HGJkbJICwpb/Wr5wBpL6fPACd5f1LJA==


`pragma protect key_keyowner = "Synopsys", key_keyname= "SNPS-VCS-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
RmnphW7rZitNwqH64cDbydqyt7plkfMs1MDGaRvPU/Y4Z3qrtDPaDvfzJbsnhWlgfIA6utCuyP4Z
DgaLWk0YOv2Hh5wu+b+MLLVczoPdISNQsZSvA27K7x94zv/M8rOFSu6UgG8/R15upO2YLPX4C4ba
cDrKAdphUNUqxMFaKE4=


`pragma protect key_keyowner = "Aldec", key_keyname= "ALDEC15_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
sJVNxeMQSQQ0MXFH9J/fkPXfuQ82wYRh8U7a+6i8xLCVQ+CekGgLXVA2Ykjq7RmYLUK8qPkMEIc2
hI9HRK0lEKa3D4cnrfDD99ZH6pks0XxhapcodJ45obqIffPLYIgrmq77exSHojpKCRCs9dZF06FH
TvjF3b4G3ti1ErrEn/j70YF7SAtkLS0DqSIvatTt80TkiqySMZt7xoXPN6Hb0uuZYvxPo6kMH2c0
vUh0Cy3ZadFLcRlisNPU/USRVXcLmRrLnqm6nUsiLlmK/9LkV/cJI0lvVsLqbfkq5YyTSnnsnaSw
OJJt20lmQkBHtWSbP/8+XNGGWKNXZ+j5C73BGg==


`pragma protect key_keyowner = "ATRENTA", key_keyname= "ATR-SG-2015-RSA-3", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
Yb7swZA1gwJDlXI7MnqffXOljdXnAsnDcaXrwWArffm/68KS+fEVfjNImkcLFeOpU4vmql2e44Jr
i67oTImjWAP01mopJLR3BS5q2jb2v7xFc+AqT6a1NT8ZCs8HHxwVA5VnAtBuEn3CIaLggbVDk99v
IBsvfmnntMUf/Rsf5GeQWn8CRkTV0VaMhLS8H9PozJ/C9azQWK8FoFaNW/PtAQipOZMNUxIICWSu
iS4L55ygPvN0GD9+USVPq7Fz6ek/j8Gjz8PCUs3eUIFs8NQwv8PIQkirpjHhaT191ris0VvkNHjA
NJCoKeKbolTG+bVmJsqBLQ+FPiYA4+Ag80oJ4w==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-PREC-RSA", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
SIfy1ERi8OLGc7TlVl+yU2kpS4Zxhw3Tqtm9cJWwXuFC4cf0OR/ufuNav0OVjOHqjppLodaqHgo6
tOPLbTmMT34wqw66SSjeTnz+vaLpWLGzKMhitW0yTkvJSTHzt71KNXsR1PpgDizth6BvnnF8z/Fz
UsiM2ErNh+gPQHKbSnTsi34jqNf9If24EIZda7JoATFhUE5vHs3uQWUzepvy0sxZTYozjBK6WHvg
gHKgQIpTtUZVhQ7eb98ByLwJnTOtF/m9FMjdpwvUoFlShw8wgpU034Yhrbk2ULLwTJmx4BBfcUJh
0yZmgcksMP0BIrmW6tsnp/YOuph7fiJxwhOiFA==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
iPPBOeStzhPYsjByGmL0JUn9s476UE2WE6VDRcRhj5TTz/fI4D23vhRQcmhuc5u6nVqq71qqxGk2
vdPL6XN2iAk97pvkMY/57wUNV6LPyCELLuDL8TgSevVn/jQq7pIJ5+hRCpaFLEoCWYofvDK05yLy
TdQdJ2TOkmw9vEn7pzaFNQ1oJQkOvkn/k4446vL6LF+YQtiHfrYpGMnICiRV1t2TWbjvYympmAw5
wVo+DJ15RdAB+OI1xQu+1ZgIxk4PowBx7saTQRso2U4ukg1I5ZrmZYkntw/wk7c7K5caQCrvv5W5
WH59ProS39Webla9AEz0oaFXi2/FSHC8VgKFLA==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 5744)
`pragma protect data_block
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
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2014"
`pragma protect key_keyowner = "Cadence Design Systems.", key_keyname= "cds_rsa_key", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 64)
`pragma protect key_block
JL1bgZMx6U/X68gqWYEktEeyyqogxjU6605fDMFU02lleo6HD4lzSSgVu15+6eh9MhyqgldeM/6o
I0kVXr5V5w==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-VERIF-SIM-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
hPwPY8s4HGGCASWdsZM1chsYI5faNryrLywhhOe8pKC9hhGq6HG/BWJNQww4SuZk0SOGqxGAMrRJ
4WJSFCIsCENQYFOhjV9ssmXXTr+yHnioFOYehmB7mvwvpnMjDZrZrsb9Ra9R+BR3JdU11UTX96BB
8huBSBhYVB5X+ilDRs0=


`pragma protect key_keyowner = "Xilinx", key_keyname= "xilinx_2014_03", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
IeQJymaodDStiUSbw50TxoTGG7Szf6kBlERO2XRm+tNT8NZIVKGso+psxRlFxY7BnFPBkLwVOEG8
NP1lu+LK0PrSJ+O2LqtZfosASdiWrR0xM+VgOtoOeDTDqe5qjtxywkvFWF3s/B0abwmkjIxJ1uaR
Rhe2AKUUPfVjIrIv9zVMzELYW6VyF1faCEy3hcy02aiI3gcpgky7yPi6Xm52tp24Uy3KfxeZVlvM
6zwO/qjskGYC0OaVImySqBoIJxEFK/8XtO4uNH+a+vM2U5Eoq8JFl+lTiyQYBZHXusDG9VobgswG
I0+06i9HGJkbJICwpb/Wr5wBpL6fPACd5f1LJA==


`pragma protect key_keyowner = "Synopsys", key_keyname= "SNPS-VCS-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
RmnphW7rZitNwqH64cDbydqyt7plkfMs1MDGaRvPU/Y4Z3qrtDPaDvfzJbsnhWlgfIA6utCuyP4Z
DgaLWk0YOv2Hh5wu+b+MLLVczoPdISNQsZSvA27K7x94zv/M8rOFSu6UgG8/R15upO2YLPX4C4ba
cDrKAdphUNUqxMFaKE4=


`pragma protect key_keyowner = "Aldec", key_keyname= "ALDEC15_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
sJVNxeMQSQQ0MXFH9J/fkPXfuQ82wYRh8U7a+6i8xLCVQ+CekGgLXVA2Ykjq7RmYLUK8qPkMEIc2
hI9HRK0lEKa3D4cnrfDD99ZH6pks0XxhapcodJ45obqIffPLYIgrmq77exSHojpKCRCs9dZF06FH
TvjF3b4G3ti1ErrEn/j70YF7SAtkLS0DqSIvatTt80TkiqySMZt7xoXPN6Hb0uuZYvxPo6kMH2c0
vUh0Cy3ZadFLcRlisNPU/USRVXcLmRrLnqm6nUsiLlmK/9LkV/cJI0lvVsLqbfkq5YyTSnnsnaSw
OJJt20lmQkBHtWSbP/8+XNGGWKNXZ+j5C73BGg==


`pragma protect key_keyowner = "ATRENTA", key_keyname= "ATR-SG-2015-RSA-3", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
Yb7swZA1gwJDlXI7MnqffXOljdXnAsnDcaXrwWArffm/68KS+fEVfjNImkcLFeOpU4vmql2e44Jr
i67oTImjWAP01mopJLR3BS5q2jb2v7xFc+AqT6a1NT8ZCs8HHxwVA5VnAtBuEn3CIaLggbVDk99v
IBsvfmnntMUf/Rsf5GeQWn8CRkTV0VaMhLS8H9PozJ/C9azQWK8FoFaNW/PtAQipOZMNUxIICWSu
iS4L55ygPvN0GD9+USVPq7Fz6ek/j8Gjz8PCUs3eUIFs8NQwv8PIQkirpjHhaT191ris0VvkNHjA
NJCoKeKbolTG+bVmJsqBLQ+FPiYA4+Ag80oJ4w==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-PREC-RSA", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
SIfy1ERi8OLGc7TlVl+yU2kpS4Zxhw3Tqtm9cJWwXuFC4cf0OR/ufuNav0OVjOHqjppLodaqHgo6
tOPLbTmMT34wqw66SSjeTnz+vaLpWLGzKMhitW0yTkvJSTHzt71KNXsR1PpgDizth6BvnnF8z/Fz
UsiM2ErNh+gPQHKbSnTsi34jqNf9If24EIZda7JoATFhUE5vHs3uQWUzepvy0sxZTYozjBK6WHvg
gHKgQIpTtUZVhQ7eb98ByLwJnTOtF/m9FMjdpwvUoFlShw8wgpU034Yhrbk2ULLwTJmx4BBfcUJh
0yZmgcksMP0BIrmW6tsnp/YOuph7fiJxwhOiFA==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
iPPBOeStzhPYsjByGmL0JUn9s476UE2WE6VDRcRhj5TTz/fI4D23vhRQcmhuc5u6nVqq71qqxGk2
vdPL6XN2iAk97pvkMY/57wUNV6LPyCELLuDL8TgSevVn/jQq7pIJ5+hRCpaFLEoCWYofvDK05yLy
TdQdJ2TOkmw9vEn7pzaFNQ1oJQkOvkn/k4446vL6LF+YQtiHfrYpGMnICiRV1t2TWbjvYympmAw5
wVo+DJ15RdAB+OI1xQu+1ZgIxk4PowBx7saTQRso2U4ukg1I5ZrmZYkntw/wk7c7K5caQCrvv5W5
WH59ProS39Webla9AEz0oaFXi2/FSHC8VgKFLA==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 1776)
`pragma protect data_block
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
e4tDmnfiPEgO
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2014"
`pragma protect key_keyowner = "Cadence Design Systems.", key_keyname= "cds_rsa_key", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 64)
`pragma protect key_block
JL1bgZMx6U/X68gqWYEktEeyyqogxjU6605fDMFU02lleo6HD4lzSSgVu15+6eh9MhyqgldeM/6o
I0kVXr5V5w==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-VERIF-SIM-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
hPwPY8s4HGGCASWdsZM1chsYI5faNryrLywhhOe8pKC9hhGq6HG/BWJNQww4SuZk0SOGqxGAMrRJ
4WJSFCIsCENQYFOhjV9ssmXXTr+yHnioFOYehmB7mvwvpnMjDZrZrsb9Ra9R+BR3JdU11UTX96BB
8huBSBhYVB5X+ilDRs0=


`pragma protect key_keyowner = "Xilinx", key_keyname= "xilinx_2014_03", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
IeQJymaodDStiUSbw50TxoTGG7Szf6kBlERO2XRm+tNT8NZIVKGso+psxRlFxY7BnFPBkLwVOEG8
NP1lu+LK0PrSJ+O2LqtZfosASdiWrR0xM+VgOtoOeDTDqe5qjtxywkvFWF3s/B0abwmkjIxJ1uaR
Rhe2AKUUPfVjIrIv9zVMzELYW6VyF1faCEy3hcy02aiI3gcpgky7yPi6Xm52tp24Uy3KfxeZVlvM
6zwO/qjskGYC0OaVImySqBoIJxEFK/8XtO4uNH+a+vM2U5Eoq8JFl+lTiyQYBZHXusDG9VobgswG
I0+06i9HGJkbJICwpb/Wr5wBpL6fPACd5f1LJA==


`pragma protect key_keyowner = "Synopsys", key_keyname= "SNPS-VCS-RSA-1", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 128)
`pragma protect key_block
RmnphW7rZitNwqH64cDbydqyt7plkfMs1MDGaRvPU/Y4Z3qrtDPaDvfzJbsnhWlgfIA6utCuyP4Z
DgaLWk0YOv2Hh5wu+b+MLLVczoPdISNQsZSvA27K7x94zv/M8rOFSu6UgG8/R15upO2YLPX4C4ba
cDrKAdphUNUqxMFaKE4=


`pragma protect key_keyowner = "Aldec", key_keyname= "ALDEC15_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
sJVNxeMQSQQ0MXFH9J/fkPXfuQ82wYRh8U7a+6i8xLCVQ+CekGgLXVA2Ykjq7RmYLUK8qPkMEIc2
hI9HRK0lEKa3D4cnrfDD99ZH6pks0XxhapcodJ45obqIffPLYIgrmq77exSHojpKCRCs9dZF06FH
TvjF3b4G3ti1ErrEn/j70YF7SAtkLS0DqSIvatTt80TkiqySMZt7xoXPN6Hb0uuZYvxPo6kMH2c0
vUh0Cy3ZadFLcRlisNPU/USRVXcLmRrLnqm6nUsiLlmK/9LkV/cJI0lvVsLqbfkq5YyTSnnsnaSw
OJJt20lmQkBHtWSbP/8+XNGGWKNXZ+j5C73BGg==


`pragma protect key_keyowner = "ATRENTA", key_keyname= "ATR-SG-2015-RSA-3", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
Yb7swZA1gwJDlXI7MnqffXOljdXnAsnDcaXrwWArffm/68KS+fEVfjNImkcLFeOpU4vmql2e44Jr
i67oTImjWAP01mopJLR3BS5q2jb2v7xFc+AqT6a1NT8ZCs8HHxwVA5VnAtBuEn3CIaLggbVDk99v
IBsvfmnntMUf/Rsf5GeQWn8CRkTV0VaMhLS8H9PozJ/C9azQWK8FoFaNW/PtAQipOZMNUxIICWSu
iS4L55ygPvN0GD9+USVPq7Fz6ek/j8Gjz8PCUs3eUIFs8NQwv8PIQkirpjHhaT191ris0VvkNHjA
NJCoKeKbolTG+bVmJsqBLQ+FPiYA4+Ag80oJ4w==


`pragma protect key_keyowner = "Mentor Graphics Corporation", key_keyname= "MGC-PREC-RSA", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
SIfy1ERi8OLGc7TlVl+yU2kpS4Zxhw3Tqtm9cJWwXuFC4cf0OR/ufuNav0OVjOHqjppLodaqHgo6
tOPLbTmMT34wqw66SSjeTnz+vaLpWLGzKMhitW0yTkvJSTHzt71KNXsR1PpgDizth6BvnnF8z/Fz
UsiM2ErNh+gPQHKbSnTsi34jqNf9If24EIZda7JoATFhUE5vHs3uQWUzepvy0sxZTYozjBK6WHvg
gHKgQIpTtUZVhQ7eb98ByLwJnTOtF/m9FMjdpwvUoFlShw8wgpU034Yhrbk2ULLwTJmx4BBfcUJh
0yZmgcksMP0BIrmW6tsnp/YOuph7fiJxwhOiFA==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
iPPBOeStzhPYsjByGmL0JUn9s476UE2WE6VDRcRhj5TTz/fI4D23vhRQcmhuc5u6nVqq71qqxGk2
vdPL6XN2iAk97pvkMY/57wUNV6LPyCELLuDL8TgSevVn/jQq7pIJ5+hRCpaFLEoCWYofvDK05yLy
TdQdJ2TOkmw9vEn7pzaFNQ1oJQkOvkn/k4446vL6LF+YQtiHfrYpGMnICiRV1t2TWbjvYympmAw5
wVo+DJ15RdAB+OI1xQu+1ZgIxk4PowBx7saTQRso2U4ukg1I5ZrmZYkntw/wk7c7K5caQCrvv5W5
WH59ProS39Webla9AEz0oaFXi2/FSHC8VgKFLA==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 1248)
`pragma protect data_block
VtUObiXXx97bOTBVTYthmlS5vbfi6b15PMrzJZqu+VM7Rz5drem3vnN4OVJF9MXROrOU3SMI4y7M
X09pJQrhHGutvSrx6dTeGQjAF3yOPBmEOs2mZ2iJ79gBWK1c2a/bsKPBAOxVvqc5L6vAZxwCs5lN
IGv4ojEs2ozz3wC7dRROzBIi6MvNHXbvdF140GpimyAuulcLhxBjz/saoLvZ3bl8LaoM7BYvoyYz
W9T0x9K4SCRyINdaPv/5TwmYgxWpC/1TAF93B1KGsV4H91oCLCHfO99joDuJzdWkGiJlO+SecmDb
lBKkPY/UdtfbV0Xgg/y6k+xnCpg4cd0Q04f8zrGh6vsNIqMAG6YbTxvbupVa2/CyVY1ignb6qidn
1YAqTyg/jvtwij8VfVWY0QiXRsODJUmsM3kK/rRePbXTpf6/7s6+UoeLrZDNrkHBLBEBScVFKzOH
SJXzCq2byF1mwbKn/nSN24fFE7wYVR2rtX4/RfSWYK1zjtz9N0PWHPchADZThjHVFUhskHQQ20H+
k8u6lue+y6Dc1+X1jZ9D6KhSqtkGzIhHrOSHTFbfrmVickfcs2UJNTTIQbQYmf9RoC5uYCwJ3gkG
hbBkUFLhFxseMhMAiOkerXmkIn0+H0v5bNFXU4g27ercTkXE5Jkw6XLWe85x7fJWYej1R0I3HF72
yqxtDPze6EWmRHpVwjwDDlJH1JhU4KxPisUrZgfmxcnomkQcuxpSgclkxc3IhZdl+o3SKW6mkyni
A1/C/euLEqqunBFADhuoWDyRCdXkuu+bCcDd1FOk4krFA2+0dSGWWh5XflwgQsKz8FjgdajuTCql
J5/WfcbtMYHtEhJLE28o3l9EFeuFdEl1QoeuxEhJ9JyxA1Iu86yCrSk09s9OX3eWZt6Cit/hnzUj
PIbEb2eb9CsWGrXGQizatOjdjr0YiwU9BdpRdQmF2Zq29DoQkyMpbi0K5XI6ZmU/T/a9xg4e1pIG
AkTAkljtR7YmNciXb2E7mhMgAWHd+SvFWdK6XEs+bR9h5T6a6sAVJavQuhaGmfbIc+tmWbAZlFNT
MnNz4CfBsQI7JR2UhcS5h2XFhIiwFgo5o9/KUSV0/ZgR2LVQlmHAVTfWBzzAzBAcfGGCk1dDTuNn
ounR0sLkfSeeiENx886ZWU0+DsdTZQVSRK7Fw4JlGb9d218uDmAY3Da2YahsosSn/sbK7oSdX4I6
mnIYVDzzzha+RmAVVF2R+tN1GOWqFP9PmncMnwV6RpnDg7mfNKwYjJ7CoXFbBKorVPqnwtw9CMgl
18unR769n8TsGV7Sl4AgtIfH4ze4KFtysXcDOsZydo6mx72RM1XixJUdHmfrrFhj1vta7tappnqz
gPGdaaDfvNFig4Jrs50E0J5HcKdDnqX2AvW4J4VfHSY0i0p0lvVIRaKSqWy0wGbHaAhT5ltdXnoA
lRnDyMxv3dPH6TyiFGaWbEf2bInmgpNtqPfCfzDupWN2ZPZpPP14glkFWPfJz+zCz9cUFu8qa2Fd
p7a9Su5tmyKv7x5G+vTIS6Ej2p6UtU+sZjsmO7BkfLqHi1lf6hmAIlTS/3oAV5kLGvv9FtcF1kvT
yoWteD9xNT2Wzm1PF3fUX4pLafOQ7HDgg7EyvsO20Q6zhyNytpr/gr3hn5SHr7OkFqZM
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (weak1, weak0) GSR = GSR_int;
    assign (weak1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
