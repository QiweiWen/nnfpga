// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.4 (lin64) Build 1412921 Wed Nov 18 09:44:32 MST 2015
// Date        : Mon May  7 15:29:18 2018
// Host        : dave-H110M-S2H running 64-bit Ubuntu 16.04.4 LTS
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
HL73vkmIQtdxTLV2DtyMIUrw6Yo6uPEFHyzLvBft1Y1MyUachNbbUHvB7AzPazOQBh/GdqFJTrX/
EvV0XBlqdMYGJxPsGwIRcbxCEJ7BqCTJSyy0bU9IcjtJFuJo9H70ujzHtXHbYeEZel3iqk38MUrW
HQmrzvsZH4Dd16WurEsU1+FogQOEQ/THNgSBB5CL78UFE91dcO83OXpVmckqx9GWzDsVf9U4mOg3
wZELBVeTrgfcAhmUMt53kv8OYh6+Cv9X5AaNB7MMeDq/ok+o8q0W6fX3cJqqkY4kF6PhzI7JJ64O
HtqGMlQuUxcgkpv1Pl6hx0G3EyxZqs+QOokEjQ==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
rJT0cFjDDahk8o3r2sYA/C2lXK/oPivWdLGQdVugxYmQyjVqGXZ7ul/S69Mu1mp0o6jTfFaOIWYl
RQstrEHp42ELwM5hwxbY0b/8MwpoF6vI+ha1wvmTzXMnu5EwmlWj4VsyX52kTE47NaJRAPTLiqgg
WEQTBTZnWA6mgfDztsq4AnAyXq9rL32EFxyGNOUsZXs8IJsgAeVp1+Yq8u13JhXv0uXNSp1FdFW/
1nxYrET9kZLZuaNVb/1hJ1B/AUAcz2rjzX+XqbnK6ZysW9m3pyogsXGh11k/qWD4ijVG/wLKb2vg
f+WTm2/ye2Il0VhaH5iAjabNt9ifVqcGKt0GaQ==


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
HL73vkmIQtdxTLV2DtyMIUrw6Yo6uPEFHyzLvBft1Y1MyUachNbbUHvB7AzPazOQBh/GdqFJTrX/
EvV0XBlqdMYGJxPsGwIRcbxCEJ7BqCTJSyy0bU9IcjtJFuJo9H70ujzHtXHbYeEZel3iqk38MUrW
HQmrzvsZH4Dd16WurEsU1+FogQOEQ/THNgSBB5CL78UFE91dcO83OXpVmckqx9GWzDsVf9U4mOg3
wZELBVeTrgfcAhmUMt53kv8OYh6+Cv9X5AaNB7MMeDq/ok+o8q0W6fX3cJqqkY4kF6PhzI7JJ64O
HtqGMlQuUxcgkpv1Pl6hx0G3EyxZqs+QOokEjQ==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
rJT0cFjDDahk8o3r2sYA/C2lXK/oPivWdLGQdVugxYmQyjVqGXZ7ul/S69Mu1mp0o6jTfFaOIWYl
RQstrEHp42ELwM5hwxbY0b/8MwpoF6vI+ha1wvmTzXMnu5EwmlWj4VsyX52kTE47NaJRAPTLiqgg
WEQTBTZnWA6mgfDztsq4AnAyXq9rL32EFxyGNOUsZXs8IJsgAeVp1+Yq8u13JhXv0uXNSp1FdFW/
1nxYrET9kZLZuaNVb/1hJ1B/AUAcz2rjzX+XqbnK6ZysW9m3pyogsXGh11k/qWD4ijVG/wLKb2vg
f+WTm2/ye2Il0VhaH5iAjabNt9ifVqcGKt0GaQ==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 1776)
`pragma protect data_block
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
Qdc7tasLqY9T
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
HL73vkmIQtdxTLV2DtyMIUrw6Yo6uPEFHyzLvBft1Y1MyUachNbbUHvB7AzPazOQBh/GdqFJTrX/
EvV0XBlqdMYGJxPsGwIRcbxCEJ7BqCTJSyy0bU9IcjtJFuJo9H70ujzHtXHbYeEZel3iqk38MUrW
HQmrzvsZH4Dd16WurEsU1+FogQOEQ/THNgSBB5CL78UFE91dcO83OXpVmckqx9GWzDsVf9U4mOg3
wZELBVeTrgfcAhmUMt53kv8OYh6+Cv9X5AaNB7MMeDq/ok+o8q0W6fX3cJqqkY4kF6PhzI7JJ64O
HtqGMlQuUxcgkpv1Pl6hx0G3EyxZqs+QOokEjQ==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
rJT0cFjDDahk8o3r2sYA/C2lXK/oPivWdLGQdVugxYmQyjVqGXZ7ul/S69Mu1mp0o6jTfFaOIWYl
RQstrEHp42ELwM5hwxbY0b/8MwpoF6vI+ha1wvmTzXMnu5EwmlWj4VsyX52kTE47NaJRAPTLiqgg
WEQTBTZnWA6mgfDztsq4AnAyXq9rL32EFxyGNOUsZXs8IJsgAeVp1+Yq8u13JhXv0uXNSp1FdFW/
1nxYrET9kZLZuaNVb/1hJ1B/AUAcz2rjzX+XqbnK6ZysW9m3pyogsXGh11k/qWD4ijVG/wLKb2vg
f+WTm2/ye2Il0VhaH5iAjabNt9ifVqcGKt0GaQ==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 1248)
`pragma protect data_block
AghVfuUZjhKmWkvVLksxDHwzZmVqEezXkyh4JAZKrdvK1ZHPSUdM+MwvOs0lGhKQz0sMv0paGuU7
qTTRjqPD6fH/w+wzfil13VCbkOZ3OzyNuXfvfHB6m9ELv6kaKaEhtvXp3QywHW8fKuW71TAbNjLe
shogUmDLDbh18rPoXRV9EHKWkjynuDaz24ywFNcgkoRH/lN1E/CLLxx9zUPw0RrWhEtheoUodPGC
3A4X3B8zEuDFtJifUpHngotyRzq/MKgI8ehHZjinYhPaUyHSKlRY4mVt7AKAWwGjvJuG1V2tjdK9
9g2MBOdrWGagCsC/XpSbW/60l836hBe4GNRXJGlurctQ8G8bp9BakPgbV076vaginNrMK9DzHHF7
I00KGpUkp73M4d9i2TPOgwNqd9wir4eVBBkPVr32neOrKnW4Kbc7on+ZKEAvvpKj9EndZ1wXRhEr
rCLblN0sp9KFjEla5TSliCRxxp8Dr0YrxEZJCzRmZ1horpryAppKOO2LLTYpxObUxeyw2xaTLAYg
Vdq+cjurjsOmoqloGaIIWKKh7hL3S2/P1ExukBRv35adWzO4kiuUHqLa87Tp3DvDQO0HReLLx/5E
E+Heu+C18w5j/RaaODzEqFwmEljp3COnxvS1UeBM0vWlqmfKUVl0qiDL9da3wkILgr3IcXQOFZrK
YrY2aVWsMNOOn2BQPN0+bA4aXzJX3mRf3zqQsq8ywcZTcVIyGzffNZZuRZ13LdEAQUkwdwAtTxF9
TboHdr5B53sNScPvcvpRZnmbMF8ao8AiO7Lr1IAUy+wh0B8+s6Dd2rzgDLqOsZ5DghOd37+Zw81g
B6wkOsC61jhdosqqu8nozxP8AAZi3k2XXM/FjC8DrPrxuOpt5LEMsZnyzHFjjDJPwjZ6e1SrcSji
q41ix9ZuNmYTl8z1CgYQTXw3Kk2vDiVJ/9KbTuQHI7OGVDgPaLwbepuRmeiJdgctRiIOvSvhV8Au
vgPJW/3kzZOUfdKnENFnDQqWq2iNjbegLLghX1KEH28vzFj+mW6hqzV8ZcGIVhGWWPk8z+u6hOCg
CGmBvWhceKJaEyrO/nPsnptZK0k70iyi2COpG166FcZGHJJXQi0JajQ9QKxUtz7gw/wiBz8DKD2X
WaK7V3A9u/i8XtZx0afaxYVHCUj6Ed4+QXabmGx7LuNa9DESvuW9AYNQ/fzQwOx4jMlUaJgU1sQz
ohXa/Roafx7ROzTHi00IF1H1bu969XuaOGs9J6GhA6jfLnZ40zpbmNWNh4plM+cEI6FEiOxW2iIt
LrJmf5kGF59Y1M1Xj5Hcuhsv90iewBJ0406KiN4HfoaJFZH3HuQyvdP9Ip6C1ZdFBj7mpvtg2Zcy
a72axZkst09GW75owvVQTHrNK8URGmjM/2vsVRmK4Nn95ueOxqlBP0CEcyP5kLdDP2DDF/63hXmV
IWOWb3gAuVWA5u3kx0NkTAYrRc3+Tu0a98/g1AxB9oQhDrkFKwC/yebSBSNCxbkXlCWqn2dIv3PY
d67JARHmJwpw3EnxkNEpcm4UncfNVkKL4mEuX/su9XYlYguLcpWyNZRsQVqh1jbI1ofqRrBAADUo
A16I9h83Qw/fgP1XYRBS+hEnsm0dlhdiVZh2NT8/CE9rXKbBI9f/nQMUjmNW89VsecXZ
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
