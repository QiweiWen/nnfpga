// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.4 (lin64) Build 1412921 Wed Nov 18 09:44:32 MST 2015
// Date        : Mon May  7 07:28:49 2018
// Host        : dave-H110M-S2H running 64-bit Ubuntu 16.04.3 LTS
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
NND843PoBwedgZZyLKQpVg2jaNTV4sKbp6DrNDM+273j34kuh06iq6/N3X2LAKZPBkTTt9yV8HKB
oR0Ie2ZEdfScJnP0oOgJxT8AalHwvAC8WSxkRT5/q4QY7il4+SbcLcywBI/zxpz1eH5/TlJsx6z2
27av1X8uRNEJxlL7d96SwDmNzS/lbeJI8IWId9B983S+6NDa4lkeXLYTT5fqjC1Ltl04Lik/8gZ1
NJRwjm+DAnaj3wAlXMjk7d6sdWmXmniGvUaFZxRXNzQiTz7u2x/5+6RaFQsW3ijIHK/mn6W/buVc
lR5L8vJ1QSDZaqlACEoBKVJH7O9lx/d58F7r5w==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
gCD9O7QQf9LRSVaZzpRtVTeU899Tee8K9DEGEhNURFtf3jiFQGZgj37RRXxzehctAOro4p9W1LDM
Vv0LzxmQ9FgtuKkeOds1QVDQ79u1XPuOMNFKqfLWCqbe+b6FdDbgOEPBSho8WpHnqTa62VFCsC3N
aBHcUXfi2PjnSRJz9qu6Q0e2sen/0S+QbcsIM5ht8VyTqZ1ngln0C9ewZR9vRs63AaTYVhMugl89
mf93NiLxY6jw77yAE4AauWTbD5RY+arD++u94mKz2uTVUAL8D4AGdkSEyDcV4g3oL8cgH1B+c4PO
2gUzsoTRg4lRHWwSgFEG5T7zUCg48WMJAtazOA==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7824)
`pragma protect data_block
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
BB88sNYK7o5CKcpbLuVO
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
NND843PoBwedgZZyLKQpVg2jaNTV4sKbp6DrNDM+273j34kuh06iq6/N3X2LAKZPBkTTt9yV8HKB
oR0Ie2ZEdfScJnP0oOgJxT8AalHwvAC8WSxkRT5/q4QY7il4+SbcLcywBI/zxpz1eH5/TlJsx6z2
27av1X8uRNEJxlL7d96SwDmNzS/lbeJI8IWId9B983S+6NDa4lkeXLYTT5fqjC1Ltl04Lik/8gZ1
NJRwjm+DAnaj3wAlXMjk7d6sdWmXmniGvUaFZxRXNzQiTz7u2x/5+6RaFQsW3ijIHK/mn6W/buVc
lR5L8vJ1QSDZaqlACEoBKVJH7O9lx/d58F7r5w==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
gCD9O7QQf9LRSVaZzpRtVTeU899Tee8K9DEGEhNURFtf3jiFQGZgj37RRXxzehctAOro4p9W1LDM
Vv0LzxmQ9FgtuKkeOds1QVDQ79u1XPuOMNFKqfLWCqbe+b6FdDbgOEPBSho8WpHnqTa62VFCsC3N
aBHcUXfi2PjnSRJz9qu6Q0e2sen/0S+QbcsIM5ht8VyTqZ1ngln0C9ewZR9vRs63AaTYVhMugl89
mf93NiLxY6jw77yAE4AauWTbD5RY+arD++u94mKz2uTVUAL8D4AGdkSEyDcV4g3oL8cgH1B+c4PO
2gUzsoTRg4lRHWwSgFEG5T7zUCg48WMJAtazOA==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 1776)
`pragma protect data_block
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
vWDr8f4mLNzs
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
NND843PoBwedgZZyLKQpVg2jaNTV4sKbp6DrNDM+273j34kuh06iq6/N3X2LAKZPBkTTt9yV8HKB
oR0Ie2ZEdfScJnP0oOgJxT8AalHwvAC8WSxkRT5/q4QY7il4+SbcLcywBI/zxpz1eH5/TlJsx6z2
27av1X8uRNEJxlL7d96SwDmNzS/lbeJI8IWId9B983S+6NDa4lkeXLYTT5fqjC1Ltl04Lik/8gZ1
NJRwjm+DAnaj3wAlXMjk7d6sdWmXmniGvUaFZxRXNzQiTz7u2x/5+6RaFQsW3ijIHK/mn6W/buVc
lR5L8vJ1QSDZaqlACEoBKVJH7O9lx/d58F7r5w==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
gCD9O7QQf9LRSVaZzpRtVTeU899Tee8K9DEGEhNURFtf3jiFQGZgj37RRXxzehctAOro4p9W1LDM
Vv0LzxmQ9FgtuKkeOds1QVDQ79u1XPuOMNFKqfLWCqbe+b6FdDbgOEPBSho8WpHnqTa62VFCsC3N
aBHcUXfi2PjnSRJz9qu6Q0e2sen/0S+QbcsIM5ht8VyTqZ1ngln0C9ewZR9vRs63AaTYVhMugl89
mf93NiLxY6jw77yAE4AauWTbD5RY+arD++u94mKz2uTVUAL8D4AGdkSEyDcV4g3oL8cgH1B+c4PO
2gUzsoTRg4lRHWwSgFEG5T7zUCg48WMJAtazOA==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 1248)
`pragma protect data_block
FMarvBRNaU2DnVw7isfpDnlPH/VaP7dj64o3VvoFi5J6lMpLmiMLEG6dtwErSv/5dE+9N2WxpSrY
miZQEbEA+qYIoDDP1SHq3H9zv/qTgoGPKfgYMEQutLulCA3AK7Txg5YAm/eK7YYLANS3RSb30f08
COTSfbId4I+bncrYWzedP3bOjY3LH8Bjvb6fwR7Ra7ivjvqvuuOY0UT2kawdHjGO9Ja5a5KrmapZ
vEdJu8/S8gjLxFptjojzmOnZCbjhcfGkdm3DTagiwwWNDzba1WeQOWmbNYmYDkrDoCtLq/O1/Fym
heSFPnKZGo0KV1txlj95MowTxsNaU6dD5TUFNEncE7rd1pYgs31uBW11XVW61bXaIJCITwc4XOB/
7IyybnIsqRM/DXGeGDfYsiTF01CQYl35ZMxvyye6bus3iUL6l7zC+USNDWN+XoWpfvbajMZtW4ES
hBsZalQ8MSX6bo/Cfo0f/BwJ6ZVdAKKdEXnDAyY+h+WMg+Bz0zFbNrR/V+jIJVrr2UiQVITPKxIU
zZPEXg5O1ZPtQiJ5w4Hdouq1zw10CfFSQhH4muIbb06cz3Y40TeUb1bKh2rbwnvkSrwu/h8ValNm
zck5PQUFA4D2nYh+fEYL6+Sak6iXMRjTH1KLr2gMTgJjsHp7V8ejhE9vq49OwpOI4PPQjv9fu0B+
PV8xGoMvzkCFm6WM1CFimGfIvZy/a2sKOBp2UHAAuMXmajh7r6sJSr+Zp3m8N9tBJw0SHz/hi8Zw
t96TmHV/3UFQBxyv25cQdw1Xeax6odlUSKKvw5kbbuIzJ6pCMw5zO5mmC33c66YYGlqUxacVqzln
el91FZengk9+2Yutu8I7AxUCrjInaeQts82s1u+uexXgOTKMsWU+6mLJfkv8fY48jxzSWPC4yh+O
Gkpolce9aLXq/PBVGjFsW9tamDIfXswQxMPEY85NGiW1b6q79Rjs6yppaFzTdExPMakv5kTAweyz
YfFkYZv+ghnWZJhhb/9uUHKGtuH3nasZn/huPUgBjQ+NRYBJcv4XMwr7cq4NK8M8qNEnsxx0m3LN
6F7b26cZO/I8BPeCgH1El5tSSi1YUxcCjus/xUHQV9OxnTbPc0eeA7faOFluPnRtFgO0+nUmDOQC
PVHDJaHpvquHWg9N6BtBQfpgaAUl2EZQxa76BspUo1KGGksQKhnnromhRYvkosGHonbGGVw1I/8R
WfzulnUGaRegy01oF5Gn8DRAhqDuwIz9QxxhVhuxXj+RUMH5m4TH95D5D05BsFSkzc4nj4z16+s2
uO32ygTm2Uq9hPuQXKjPhkR+Dry603ZQyJ+IHuF5SkRNEkXm1nWNDr7go9ofcvIsakp8X8W5a+db
+3e8O+/t6fPb03D9jCcGqCyp9tCIR8wK+wZV4N4RR6TLknrlELozGl+gmeERlOJP1T/lWAADpUF4
F7Bb28KYPgsrsNc8HOW8h9xCBk4ske66LNrlukXmf+nddz8QJfzrxPKY0vnQ1rJ15u/iz3nB6h2R
V2p8e0Y/3feEzqvbISMbGI5hcuYC8agN8ZREccJeG96MgUCN6T2cjVV+Qx3cC9Uq5bgKAUCA+GpW
+mga+1Qv/MZKynqN2DoydRxcSAajwgMU3qXy6PoId8tSY7hxKVPAKDsIdYE5Gc15I+fo
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
