// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.4 (lin64) Build 1412921 Wed Nov 18 09:44:32 MST 2015
// Date        : Sun May  6 20:13:31 2018
// Host        : dave-MS-7A37 running 64-bit Ubuntu 17.10
// Command     : write_verilog -force -mode funcsim
//               /home/dave/workspace/nnfpga/zynq/neuralnet_ip/neuralnet_ip.srcs/sources_1/ip/xbip_multadd_0/xbip_multadd_0_sim_netlist.v
// Design      : xbip_multadd_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "xbip_multadd_0,xbip_multadd_v3_0_8,{}" *) (* core_generation_info = "xbip_multadd_0,xbip_multadd_v3_0_8,{x_ipProduct=Vivado 2015.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=xbip_multadd,x_ipVersion=3.0,x_ipCoreRevision=8,x_ipLanguage=VHDL,x_ipSimLanguage=VHDL,C_VERBOSITY=0,C_XDEVICEFAMILY=zynq,C_A_WIDTH=16,C_B_WIDTH=16,C_C_WIDTH=32,C_A_TYPE=0,C_B_TYPE=0,C_C_TYPE=0,C_CE_OVERRIDES_SCLR=0,C_AB_LATENCY=0,C_C_LATENCY=0,C_OUT_HIGH=0,C_OUT_LOW=0,C_USE_PCIN=0,C_TEST_CORE=0}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "xbip_multadd_v3_0_8,Vivado 2015.4" *) 
(* NotValidForBitStream *)
module xbip_multadd_0
   (A,
    B,
    C,
    SUBTRACT,
    P,
    PCOUT);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 c_intf DATA" *) input [31:0]C;
  (* x_interface_info = "xilinx.com:signal:data:1.0 subtract_intf DATA" *) input SUBTRACT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) output [0:0]P;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcout_intf DATA" *) output [47:0]PCOUT;

  wire [15:0]A;
  wire [15:0]B;
  wire [31:0]C;
  wire [0:0]P;
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
  (* C_C_WIDTH = "32" *) 
  (* C_OUT_HIGH = "0" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_USE_PCIN = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* DONT_TOUCH *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  xbip_multadd_0_xbip_multadd_v3_0_8 U0
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
(* C_C_LATENCY = "0" *) (* C_C_TYPE = "0" *) (* C_C_WIDTH = "32" *) 
(* C_OUT_HIGH = "0" *) (* C_OUT_LOW = "0" *) (* C_TEST_CORE = "0" *) 
(* C_USE_PCIN = "0" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "zynq" *) 
(* ORIG_REF_NAME = "xbip_multadd_v3_0_8" *) (* downgradeipidentifiedwarnings = "yes" *) 
module xbip_multadd_0_xbip_multadd_v3_0_8
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
  input [31:0]C;
  input [47:0]PCIN;
  input SUBTRACT;
  output [0:0]P;
  output [47:0]PCOUT;

  wire [15:0]A;
  wire [15:0]B;
  wire [31:0]C;
  wire CE;
  wire CLK;
  wire [0:0]P;
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
  (* C_C_WIDTH = "32" *) 
  (* C_OUT_HIGH = "0" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_USE_PCIN = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  xbip_multadd_0_xbip_multadd_v3_0_8_viv i_synth
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
H6K2C0AF8/dz0ybqaSzhEP9fGry2sJBzlcNH/a5BR/5r8JBRyW9bY7ARKt2PCPrG+7qgD/HX5AuJ
hN0WXgmhM0CTwkMGGwcl72BJIP086ScScLrvDRslHtEWmpsGlpqAW1surOvXHlh0k9byI9cp0e24
8fYDOZaTStTu1ue3ehApn+CIcS54W6DDSVC6hmvEWdMe0mF+G3QoEAhiLemKJR2iZVSAp87xnpba
XtqEJ4cZWSdxsdf30QKv9k1FLyxiH0kxy4mQYNctMes+zBWH4V3FrTDPDDFCgko3izwdZrxCOFzf
/0aZNH8/ofb5wCUXzuS+/aFaUCHk1hz4ZpzccQ==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
eJAHH5tM9De2gvqOlWulsScCGjYlQDjy9i+FSr+XL9yJr7ANmlLhGXwWxiDXiDw4zJ6Yjz1syjNw
VX6pgVARNvwZO6yt2Fb9QtV0H0izAZjnuP/nROgjvhhdVJAm30bfGNDSwEJY+bRcL05mDx9qft3P
sLNBmMl4puM7TyAWNB3xpS3xnLxL/qGf0oT1fgTxD1KniiSxtcEHhHBNbmmUCc2/Vto9SXAZGqFR
mGOYMuJmpJ/ZTPXeByt8a4p6I/qTnH80UAbUPNbOvC/f9tY3uYW6P/LHOJyQu4aIZzsDYZHr7RpL
6lU6XbynY9vwoolqdOYPDQf2NtqUo+i+IHXXzA==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7824)
`pragma protect data_block
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
9BCXJYUVgfUYBkehHoS2
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
H6K2C0AF8/dz0ybqaSzhEP9fGry2sJBzlcNH/a5BR/5r8JBRyW9bY7ARKt2PCPrG+7qgD/HX5AuJ
hN0WXgmhM0CTwkMGGwcl72BJIP086ScScLrvDRslHtEWmpsGlpqAW1surOvXHlh0k9byI9cp0e24
8fYDOZaTStTu1ue3ehApn+CIcS54W6DDSVC6hmvEWdMe0mF+G3QoEAhiLemKJR2iZVSAp87xnpba
XtqEJ4cZWSdxsdf30QKv9k1FLyxiH0kxy4mQYNctMes+zBWH4V3FrTDPDDFCgko3izwdZrxCOFzf
/0aZNH8/ofb5wCUXzuS+/aFaUCHk1hz4ZpzccQ==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
eJAHH5tM9De2gvqOlWulsScCGjYlQDjy9i+FSr+XL9yJr7ANmlLhGXwWxiDXiDw4zJ6Yjz1syjNw
VX6pgVARNvwZO6yt2Fb9QtV0H0izAZjnuP/nROgjvhhdVJAm30bfGNDSwEJY+bRcL05mDx9qft3P
sLNBmMl4puM7TyAWNB3xpS3xnLxL/qGf0oT1fgTxD1KniiSxtcEHhHBNbmmUCc2/Vto9SXAZGqFR
mGOYMuJmpJ/ZTPXeByt8a4p6I/qTnH80UAbUPNbOvC/f9tY3uYW6P/LHOJyQu4aIZzsDYZHr7RpL
6lU6XbynY9vwoolqdOYPDQf2NtqUo+i+IHXXzA==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 1776)
`pragma protect data_block
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
atbMQct7nmCb
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
H6K2C0AF8/dz0ybqaSzhEP9fGry2sJBzlcNH/a5BR/5r8JBRyW9bY7ARKt2PCPrG+7qgD/HX5AuJ
hN0WXgmhM0CTwkMGGwcl72BJIP086ScScLrvDRslHtEWmpsGlpqAW1surOvXHlh0k9byI9cp0e24
8fYDOZaTStTu1ue3ehApn+CIcS54W6DDSVC6hmvEWdMe0mF+G3QoEAhiLemKJR2iZVSAp87xnpba
XtqEJ4cZWSdxsdf30QKv9k1FLyxiH0kxy4mQYNctMes+zBWH4V3FrTDPDDFCgko3izwdZrxCOFzf
/0aZNH8/ofb5wCUXzuS+/aFaUCHk1hz4ZpzccQ==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
eJAHH5tM9De2gvqOlWulsScCGjYlQDjy9i+FSr+XL9yJr7ANmlLhGXwWxiDXiDw4zJ6Yjz1syjNw
VX6pgVARNvwZO6yt2Fb9QtV0H0izAZjnuP/nROgjvhhdVJAm30bfGNDSwEJY+bRcL05mDx9qft3P
sLNBmMl4puM7TyAWNB3xpS3xnLxL/qGf0oT1fgTxD1KniiSxtcEHhHBNbmmUCc2/Vto9SXAZGqFR
mGOYMuJmpJ/ZTPXeByt8a4p6I/qTnH80UAbUPNbOvC/f9tY3uYW6P/LHOJyQu4aIZzsDYZHr7RpL
6lU6XbynY9vwoolqdOYPDQf2NtqUo+i+IHXXzA==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 1248)
`pragma protect data_block
ECZifjjHJ7P/YwlCopxv4Zayd2DorK4iLs7nJj0YDxTFFtVmp8jjM4L4Ym1rA+OGBZEejShCvd5l
xpsiEDv7fS8Hnr9Bube+0z7P+Ckh7cbacEFQep2HHuqJX3LYWbA4LLBnrJE6ZQj95yb/QvxhkV4u
qeMLx8oVt8EmC9eumwpcCLADCKS9EXaXA+4x/WGfXif365f5KkMvuFQWyS3eGs+n1aPGJ68CPJZJ
x7Bj9xZqr7TLOT41rDVMT1MqhoeNcLGS4ZhDYdClLWbsAELhhqExOuM04ubfgiGI/f/83epYsM0o
K1hZ0gAXtg51zfPCcMnDxY132yHtAOSCNnk0Wlc3I0JUl2641ubL7edmmuFuRtgHQJ6jH6htkgbz
bTgniZ1k/eRlNERxf6I0Vw8dIWR8y/OIme4N3MJoSSS39XJUUxBf0ZIXV8k4NDB4jp0tPm9FsfHC
9qMax9i+9Wi7Isb0QFz/EqGt7FW4FT7vX9Ga5BxN3sMF4Sk1OoaOGegOG5p0O7AqpvytZ3JktNtI
UhprJ/CUXcMrEaqy6d7r010ErsepS+Q5bHpqbrw74T6f1LD/mqXqBF+w4NVrXYjvibFHNG1k/HMa
V931mpjaqTysFcz0TJZZrcBPCcPYHcMvuBh+6DBe8/VTDrY0tsN8EDjgvbMDUVsl2zwhy957spmk
xTdeAIzK9g0ItgtfUPLQlu/HODICl2l7adkT5RRfl2g1vbMNI8u6KMK5u5VKPMpT5EquWkymt5qA
7BbiJUw6NnYom7PMr2m23oj/1xRuC3SeXlRLIgmO/rrMGGGds4SkvDA9vlM38XBPpc1OuMn0ERg9
jaCNZy1JD+kIC2PkxVlfR6LcZrIUIiSG0rBeDx8YoR1CZ35cnsxi7MxCPYu8MymQfRxevnVtoBNa
smhs6zC7mWM6ShE93qofRvJuarARL8+dkfn/h5r6vSOhDX3PcL5AG4yHha8as6pi86rMNoggwLg1
iwKna5AQkDL05OSzc81jduWB1odY+UJdO9t+Nh4OtOCyS7jRYeybrXa1B3aFAy4M0KUl7LH3cd/m
Fx+r4TWnSg1YuuzSDN6zymVMh3d5kq6mmUSGbTEaZqPfGvrCfmQo/pfrhE2/e653WuDTvkk9PPYl
Rtp5m0lf6SV/ysztFjJmCLEMUx4KdBlYXrlIUROvlI6E6WAwoH8MNWSGiS4i98Y1dppSCc2TNsve
hL6wZ7BWq9peJzzIJt5gn0D7aryn75MGaaT24kEhOJ7yplIRkKCjLZfTMi3HXterfW/9SKZtNR+P
rcR25JQrZ17ClAbXAJZeTIwD0/V+6E/w5cyQOHAerauv068X1xDaik35eaJB8g5FGoNmJik/01gw
F7ahD0ojJUI5FjA4gm4dBCj2CGmZbMiey5zzohm3PDnQFV5QdhzZzR7gu7sfxT4tpAQMYtczl9EJ
4zk4XZhGX28QQG99D0I3o4QQT2Pw22sCHvfnwZCuQIbCVuhBJ6Wlqb32Zd3szu0VI7u3BDqynSph
6WtcyJvBqltK/Atwgu1tR9NCn9wBelRUiIV68CaxcgpqJcg6E8QbgWU7aMlnWc9qI1lxd29C1voM
9QwS/M+eM00udxpIdq86OXAr2cp+rD0Jdhcksr7XTWsPZePnOrkvFc9W7ubZEUIaapIF
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
