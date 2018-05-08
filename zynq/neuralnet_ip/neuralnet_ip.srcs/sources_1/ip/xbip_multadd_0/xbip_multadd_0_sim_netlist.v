// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.4 (lin64) Build 1412921 Wed Nov 18 09:44:32 MST 2015
// Date        : Tue May  8 22:30:39 2018
// Host        : dave-MS-7A37 running 64-bit Ubuntu 17.10
// Command     : write_verilog -force -mode funcsim
//               /home/dave/workspace/nnfpga/zynq/neuralnet_ip/neuralnet_ip.srcs/sources_1/ip/xbip_multadd_0/xbip_multadd_0_sim_netlist.v
// Design      : xbip_multadd_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "xbip_multadd_0,xbip_multadd_v3_0_8,{}" *) (* core_generation_info = "xbip_multadd_0,xbip_multadd_v3_0_8,{x_ipProduct=Vivado 2015.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=xbip_multadd,x_ipVersion=3.0,x_ipCoreRevision=8,x_ipLanguage=VHDL,x_ipSimLanguage=VHDL,C_VERBOSITY=0,C_XDEVICEFAMILY=zynq,C_A_WIDTH=16,C_B_WIDTH=16,C_C_WIDTH=48,C_A_TYPE=0,C_B_TYPE=0,C_C_TYPE=0,C_CE_OVERRIDES_SCLR=0,C_AB_LATENCY=0,C_C_LATENCY=0,C_OUT_HIGH=47,C_OUT_LOW=0,C_USE_PCIN=0,C_TEST_CORE=0}" *) (* downgradeipidentifiedwarnings = "yes" *) 
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
(* C_C_LATENCY = "0" *) (* C_C_TYPE = "0" *) (* C_C_WIDTH = "48" *) 
(* C_OUT_HIGH = "47" *) (* C_OUT_LOW = "0" *) (* C_TEST_CORE = "0" *) 
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
NtDnsbehcQjf+0BxHUqe5/8eopriE80MxeR2afRPK39wND02DHkLjFCDO5bJgopzDgBH1KGPOO+k
6F30fn8qytY0yAyBNSRyowQPY/QmVsymX3A7qfRC2Sr2xHq32CCujZfYclc2B1rRd1AApkVhZtzi
XKqKApaWcOLV7K05h8B/D4K6VN+IMXft2KPAWLuJARG5DcSlovejffgexrOJ4Sx5w1ED2aP/O1IO
6lAnoU7nEsa4gTr4SfyRjU6PsGIwN+FGMDdfDpw4ul1bvrVAXH1lbr9y2XNF3T18jnvtxijpxchs
G1ZO3Ha+5RyIvjt0A6a3PA7F12BCvB5XrE3wuw==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
uaUOB44bntNB3VUCR5cqBL5VVX6EeYRZSt+xfTPld0/KK1UyYd+waOCnR6evZhfHfluPBR4iccKC
BdBYsou6tMuzkOsa4I5v5k4eozohIMqjvwk22wAPVvmUXvks8/5HYz+iQtGMOVSk6/TE1dFmH38R
q2khrurlD5wxN4J6lWIINZ5slgkFnxX7WUpcLnqLUUhjyYWWMqbaduS+YeTmcAF57+CjpBQ9pWVW
osR1c/sh/izVH9y/ileEJKbRtLEKjgrA23p6M04f1oijRiaQzfcCdj/xIqZ53stdwofIk1kc++L+
dRck0EXJZc+ImCCg1zkUnP4eVlSvHCxWrdCJpg==


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
NtDnsbehcQjf+0BxHUqe5/8eopriE80MxeR2afRPK39wND02DHkLjFCDO5bJgopzDgBH1KGPOO+k
6F30fn8qytY0yAyBNSRyowQPY/QmVsymX3A7qfRC2Sr2xHq32CCujZfYclc2B1rRd1AApkVhZtzi
XKqKApaWcOLV7K05h8B/D4K6VN+IMXft2KPAWLuJARG5DcSlovejffgexrOJ4Sx5w1ED2aP/O1IO
6lAnoU7nEsa4gTr4SfyRjU6PsGIwN+FGMDdfDpw4ul1bvrVAXH1lbr9y2XNF3T18jnvtxijpxchs
G1ZO3Ha+5RyIvjt0A6a3PA7F12BCvB5XrE3wuw==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
uaUOB44bntNB3VUCR5cqBL5VVX6EeYRZSt+xfTPld0/KK1UyYd+waOCnR6evZhfHfluPBR4iccKC
BdBYsou6tMuzkOsa4I5v5k4eozohIMqjvwk22wAPVvmUXvks8/5HYz+iQtGMOVSk6/TE1dFmH38R
q2khrurlD5wxN4J6lWIINZ5slgkFnxX7WUpcLnqLUUhjyYWWMqbaduS+YeTmcAF57+CjpBQ9pWVW
osR1c/sh/izVH9y/ileEJKbRtLEKjgrA23p6M04f1oijRiaQzfcCdj/xIqZ53stdwofIk1kc++L+
dRck0EXJZc+ImCCg1zkUnP4eVlSvHCxWrdCJpg==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 1776)
`pragma protect data_block
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
I58HLYQxyZil
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
NtDnsbehcQjf+0BxHUqe5/8eopriE80MxeR2afRPK39wND02DHkLjFCDO5bJgopzDgBH1KGPOO+k
6F30fn8qytY0yAyBNSRyowQPY/QmVsymX3A7qfRC2Sr2xHq32CCujZfYclc2B1rRd1AApkVhZtzi
XKqKApaWcOLV7K05h8B/D4K6VN+IMXft2KPAWLuJARG5DcSlovejffgexrOJ4Sx5w1ED2aP/O1IO
6lAnoU7nEsa4gTr4SfyRjU6PsGIwN+FGMDdfDpw4ul1bvrVAXH1lbr9y2XNF3T18jnvtxijpxchs
G1ZO3Ha+5RyIvjt0A6a3PA7F12BCvB5XrE3wuw==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
uaUOB44bntNB3VUCR5cqBL5VVX6EeYRZSt+xfTPld0/KK1UyYd+waOCnR6evZhfHfluPBR4iccKC
BdBYsou6tMuzkOsa4I5v5k4eozohIMqjvwk22wAPVvmUXvks8/5HYz+iQtGMOVSk6/TE1dFmH38R
q2khrurlD5wxN4J6lWIINZ5slgkFnxX7WUpcLnqLUUhjyYWWMqbaduS+YeTmcAF57+CjpBQ9pWVW
osR1c/sh/izVH9y/ileEJKbRtLEKjgrA23p6M04f1oijRiaQzfcCdj/xIqZ53stdwofIk1kc++L+
dRck0EXJZc+ImCCg1zkUnP4eVlSvHCxWrdCJpg==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 1248)
`pragma protect data_block
oAYQurIWDa47+HYJ6tWFO/uz9RB2bv7WSS3Q0Q/BmvcVtNfhNffK0k9dJqwMfJZ9sIutlsikkeX3
ql0VyaMZiDNDReS5hUcMFDeVg60Qu8RwHrDgGehoHvKx7eto1TcAxRp1yoZNawrp0qgV4tclK2EW
ydAMqIwdFjj3/p2K1q+YPsXZpGEXsL9SKNX4EDzavwtxYfkaPohbMOGGaSPYtra1R8B46oyunlmV
y6dcz5IwqosmT8GHFoeu0T+JxgVDFWkvE71AM1SUk1IbDLqnk0TLjlpGmeCkyZkQxQVv3etrvKGM
hu2nvS6MJGQioljaeLyemIdYoJGZ4uu2S1qZ2FKeyDtwjCytkDVfQahUjiSqQq1YNaELAN2fPVgr
eYxDJiNJ0Q3IMSnLUGTcgvPMiOvbBiEwecKgBjt8wvZjwpKCo1gX/y6BFCewHUvoN9nHiGbd3uli
uJqdOrWiiST9aYA04c0IkSpUL9O6HqOXBZbMbEzz9hmuA6JM9Sih5VbjuiA1s5LC8eBoHTfRenwc
gpqi2kTMcNFCNDwWIquQPdfF9KE8f74JAjgEjtPz0AxJttl9TXg4gamlZLVWSb4PC0QCL80OTFQY
KtmlwExOiyUdLazggkeCkvBRSR4sAEGKugxR9aeN1LZiKTJb/8pVy96rT/rb9wAnaQFzwLxU9c5V
BaNd16qQG+ZFA2w1ij2VlOUxEo6JmhmvqIMFXsdpX28TbrRDD8K/ezcPZOlPKOdO3PDZTruPk8UC
A9YRxdlb5fStmXCyIew4SxtRJePFuI/wU7gfTixktXyrIWqWQBMXgmIG0HqmWjmFGiuk9g5oSUT5
iOs9WM/61MDQOyTl9l4iNsA1fXa8y1XZzzKj/POn5UsBTFNZ1rPl+bT9CYqCkVvlnwdyThqN2V+D
j7OuNxrVm31HLm0pBlB1KggLbJcNdKxeOKTqExD5u+I3fxIPdF1RtGkndQAHcq0Q+3W1HSWV3x3b
c50tFrK3XYBw7X+wpEHtPKJLtKlLn6b2urOxkrWPTY9UnDZaYU0R9+MLYaz3tYg6WF/SSIfC7+nc
732B6b8X3/2oaZtatybFFBgzy9Vy33z6eMoy4REJK87qPVmvB22EaRcFY4T/fWFn7IYAi3U9BEYM
KBI+YFUWY9wMnm9cNYFA4Fe2F0X8tabfg+9/rFFIQcEEh1B4VqJJA9ucUDLQRRngtju6HpX1NwN6
oUOAQENj5UTSCMa1DbuhNyZlCNEie1vhiTzDctkcZNnOaQRwyCRVKNho7a7TcjurBA2VN+8Gaopr
+sqXwSHpM/S1vBKK3DU4fQLrP8sS17Eekrhdnl2JabVFzAGjfMXfvqIm+tfYKbYz8uSQPxh4CrtH
l4IssfXiVYVEXcIOIbb3hF7zKwg8UY5vZUcc7LRR6aITQX73SAes5sIiRfhYOAgFzSE4LwEI6nde
MEhL9qkMGITt+SmT1GmMNEsBoqdkDIdsijQWilP5Ghr/aI2g15Xf8JKZvPilP4AqfyQf205pw7xT
o6eJwNfsvILFhyTv0mqjMwMDA6L3n9y7z0wjjXJzjiyTqRXcI+gOjVo4RdI8ocgk8x1lfBlq17BJ
yKjQ91OuO7asHS6VLT1oezil/rrH93kF8nR8LrJRFYZIcMt77rKmWwzcp4JgWwwrxzl8
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
