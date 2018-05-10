// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.4 (lin64) Build 1412921 Wed Nov 18 09:44:32 MST 2015
// Date        : Thu May 10 19:44:14 2018
// Host        : dave-H110M-S2H running 64-bit Ubuntu 16.04.4 LTS
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
eAk438FCm3+MnMxxgsFGD0A0svpCl8ImWOl/DC2XL2ITNhC+CjXcM5n/9XqKG2te6SehlEKj4w9M
JK1WTTRGSrSNR5bfuRoWhj64o/Om7nqAjWxxsubeyoU0R/UPlGD75/LVUJ+iNC3mJ6fNYvi2M+g7
u4lmRP/CaADwo9WwQku9moDpFNjGzg29yKooT0R4c0g0y7ebW1SrF/7U2WNIF3Qn/tCbxO/jbAXt
DduatgRZNvoVhwQPzsf07qmI4SMKD77+lGFKWWXYuo0Qo//ieY5IMJYvtZ1Q9B3q2jxBuaKnKf1P
lXIP5BmCpq5Z4wIkJh7HKh+Nqjtpoj4/KpFSpA==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
hf7zCDdc5CVrkTRJ5HVOxw8kqjzWETSkmoGGPh59DqVusWY+99sFqq0hr5CgypPz9DiII0XT1Dn1
3cDHKwlB8nyOE7s4cu3m4tUgOuq32TgC4esmguuLouImXpBSUSbg1wHVy1ETGB3V3A4QZE+hZpYM
47XStVfxxEF0a927TKqS7QdzQJAB2uAtk0wywHovMQi5BlOMMxPPUzrsNYzwKqbzJL/9dGs6Hw26
BYXDU3MSLqKPC3zNK9SjR3cbgIyP61tV07bDmFIrgnT5dmUAA6/3IzKiV5sxiPdRlphNCV23Q3Sx
2nDMXCibo7/HtSKeYgWUvn3YkfHJ7QzsRmNQ9w==


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
eAk438FCm3+MnMxxgsFGD0A0svpCl8ImWOl/DC2XL2ITNhC+CjXcM5n/9XqKG2te6SehlEKj4w9M
JK1WTTRGSrSNR5bfuRoWhj64o/Om7nqAjWxxsubeyoU0R/UPlGD75/LVUJ+iNC3mJ6fNYvi2M+g7
u4lmRP/CaADwo9WwQku9moDpFNjGzg29yKooT0R4c0g0y7ebW1SrF/7U2WNIF3Qn/tCbxO/jbAXt
DduatgRZNvoVhwQPzsf07qmI4SMKD77+lGFKWWXYuo0Qo//ieY5IMJYvtZ1Q9B3q2jxBuaKnKf1P
lXIP5BmCpq5Z4wIkJh7HKh+Nqjtpoj4/KpFSpA==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
hf7zCDdc5CVrkTRJ5HVOxw8kqjzWETSkmoGGPh59DqVusWY+99sFqq0hr5CgypPz9DiII0XT1Dn1
3cDHKwlB8nyOE7s4cu3m4tUgOuq32TgC4esmguuLouImXpBSUSbg1wHVy1ETGB3V3A4QZE+hZpYM
47XStVfxxEF0a927TKqS7QdzQJAB2uAtk0wywHovMQi5BlOMMxPPUzrsNYzwKqbzJL/9dGs6Hw26
BYXDU3MSLqKPC3zNK9SjR3cbgIyP61tV07bDmFIrgnT5dmUAA6/3IzKiV5sxiPdRlphNCV23Q3Sx
2nDMXCibo7/HtSKeYgWUvn3YkfHJ7QzsRmNQ9w==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 1776)
`pragma protect data_block
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
Zz0y+8kO+c3q
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
eAk438FCm3+MnMxxgsFGD0A0svpCl8ImWOl/DC2XL2ITNhC+CjXcM5n/9XqKG2te6SehlEKj4w9M
JK1WTTRGSrSNR5bfuRoWhj64o/Om7nqAjWxxsubeyoU0R/UPlGD75/LVUJ+iNC3mJ6fNYvi2M+g7
u4lmRP/CaADwo9WwQku9moDpFNjGzg29yKooT0R4c0g0y7ebW1SrF/7U2WNIF3Qn/tCbxO/jbAXt
DduatgRZNvoVhwQPzsf07qmI4SMKD77+lGFKWWXYuo0Qo//ieY5IMJYvtZ1Q9B3q2jxBuaKnKf1P
lXIP5BmCpq5Z4wIkJh7HKh+Nqjtpoj4/KpFSpA==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
hf7zCDdc5CVrkTRJ5HVOxw8kqjzWETSkmoGGPh59DqVusWY+99sFqq0hr5CgypPz9DiII0XT1Dn1
3cDHKwlB8nyOE7s4cu3m4tUgOuq32TgC4esmguuLouImXpBSUSbg1wHVy1ETGB3V3A4QZE+hZpYM
47XStVfxxEF0a927TKqS7QdzQJAB2uAtk0wywHovMQi5BlOMMxPPUzrsNYzwKqbzJL/9dGs6Hw26
BYXDU3MSLqKPC3zNK9SjR3cbgIyP61tV07bDmFIrgnT5dmUAA6/3IzKiV5sxiPdRlphNCV23Q3Sx
2nDMXCibo7/HtSKeYgWUvn3YkfHJ7QzsRmNQ9w==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 1248)
`pragma protect data_block
WFQkybhfmN2GtoDSKhkRi/4yaK0EBaR7RfnFB5sULcga9W6iDMfGlktnDoU3+53+wvuVtR7FJbOs
xepqVakL+ZV8choXxm6Hhb+2Lv/mI19IUAzoGzq/aJPFuwy8+Vr9sR94dPot22tKGAb7OB0pz7VY
07l6JEA5pmoZP70RoHfqwetZ6jd2aJHpMH8/I7UvIuf+dIbwcWZYM+kdcpYwogwgOF1NjA5J9miB
DT1Z6fxoS9CTphUfXlsfV+sVr7X4Q0uOpp3F9Yx+IQgGxJ215NRxNogEoalV+FDbMkybuu4x+6YD
fjODB0ljYj0VKx7TnQ6C9ibfFmsCIslL3ChKAoMN+uBtLSjs3ruOaJ2UXMXfyje0GsMEFciWo27I
ulXFGWnDI+Eo8zau+SK2YaJqaxG5MbKLSObd767CNePwdVk8MGwDkQgI/nQFMEfYzwyDulMSHUkW
UmUsQ+uSi1Cw5Dgku9urxdtQIvKYQWf9R0nnN3Y3juAJ4qC4+qE7qFDpNdp7Ahs/ATjsHN+Y8OQr
EIUNG151CtFc0Y8819/ds1cd23yrHM4UJxAK2wyM1NIagyrAotuTG4eLI09/bQvWC44XPxL9ocYU
wwN9vsOtkRAuJfrOEFNyY1o7IvWoy8doZzz3d8HFhzpcewLkf9F8KTc6xiCPoJ0oweGmDz1wgS2l
pg5tW0MuvRMc2k1wrtuup+ojjkEtq8THBVmFaPSNCYXsJYsX4tGvbhMgxEpnh9MPtXC0hwDvwN77
KU/NsWppFg/fJf6oFoZ2cYsLruPa/wlQHnrVLKpo0xK2hlERkUFP034/qUbpb+QhkttHpVoqtuRC
Xl97fHkPQsL9syUmHlAmBzA3Hn/bflGldESfzy8nGmcXh8wRscy/mLrNSUwfNk5ix8yZIBGh1949
zhSP+vJBJWa6uSbQv+ufBZLrvq/ep6YDhXRLmuiOcoNP2ewZet0z91FlIRFUBWdzjeaGZaJa33cU
T9qh/zZ9JnQd3JyuTOsJIVZoxXZpEsDxPZzy5H0dJ3MBPx/zwKEfgNbZusy8hfG+HQJ0cx9K16PJ
C8I3YSpEZUXsEyuQQlUcm6p+GUgtaeA57A5YBx8mBzyPrCPAM/pKpDG66k8rRGBUaPIsCvOtsPay
CX7EyV5GxMickPDl39eJkbCuAzYAzN6tpzUJn4UwKD5OqWnM/SP7SAAX8iwyEE4aEb7l095zEZ6B
0P7IpdBe50OH0OHuO6qA3sRl5J8ncy22jkGsHbTZxwbpcQDh6HyCOIOVfqxnRtwtWj0fODal0AHx
y3pqv313sWFeocpJebVFZD2vA7pAxN/v8W2iMR5G76hfwVjF0+f4XHPcP07g0qhYcCd+dBdhSG6a
X7CIuq3Ly3H22VbMUPTk41uWj5n6I4zirFy4ol4TH6pde0MrY1MzPdiFYZpF1RBzoxFeg7O4FrnS
0TTn0MIF0BYQvKBmnJU5joH2RdHjyKhnrado08dLhATYhvtcamp2SHK7LFS9JBO5chcmgJNvXFHY
GCXXKVK54b1DYUJs5I8qzfp09xgWQrXn/x6F3k1OioO78tB6PA56j7CXEug3T4jhRu2roV7iRHOh
4MglrTt1DOBTjEzy0J4NkpRtvG1amtfqooKBlLPrvccjlrE7EviaWO9nc12S2A1sTLKb
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
