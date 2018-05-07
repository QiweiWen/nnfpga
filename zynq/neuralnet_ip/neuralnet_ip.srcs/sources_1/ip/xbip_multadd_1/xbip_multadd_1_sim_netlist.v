// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.4 (lin64) Build 1412921 Wed Nov 18 09:44:32 MST 2015
// Date        : Mon May  7 10:22:26 2018
// Host        : dave-H110M-S2H running 64-bit Ubuntu 16.04.3 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/dave/workspace/nnfpga/zynq/neuralnet_ip/neuralnet_ip.srcs/sources_1/ip/xbip_multadd_1/xbip_multadd_1_sim_netlist.v
// Design      : xbip_multadd_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "xbip_multadd_1,xbip_multadd_v3_0_8,{}" *) (* core_generation_info = "xbip_multadd_1,xbip_multadd_v3_0_8,{x_ipProduct=Vivado 2015.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=xbip_multadd,x_ipVersion=3.0,x_ipCoreRevision=8,x_ipLanguage=VHDL,x_ipSimLanguage=VHDL,C_VERBOSITY=0,C_XDEVICEFAMILY=zynq,C_A_WIDTH=16,C_B_WIDTH=16,C_C_WIDTH=48,C_A_TYPE=0,C_B_TYPE=0,C_C_TYPE=0,C_CE_OVERRIDES_SCLR=0,C_AB_LATENCY=0,C_C_LATENCY=0,C_OUT_HIGH=0,C_OUT_LOW=0,C_USE_PCIN=1,C_TEST_CORE=0}" *) (* downgradeipidentifiedwarnings = "yes" *) 
(* x_core_info = "xbip_multadd_v3_0_8,Vivado 2015.4" *) 
(* NotValidForBitStream *)
module xbip_multadd_1
   (A,
    B,
    C,
    PCIN,
    SUBTRACT,
    P,
    PCOUT);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) input [15:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) input [15:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 c_intf DATA" *) input [47:0]C;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcin_intf DATA" *) input [47:0]PCIN;
  (* x_interface_info = "xilinx.com:signal:data:1.0 subtract_intf DATA" *) input SUBTRACT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) output [0:0]P;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcout_intf DATA" *) output [47:0]PCOUT;

  wire [15:0]A;
  wire [15:0]B;
  wire [47:0]C;
  wire [0:0]P;
  wire [47:0]PCIN;
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
  (* C_OUT_HIGH = "0" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_USE_PCIN = "1" *) 
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
        .PCIN(PCIN),
        .PCOUT(PCOUT),
        .SCLR(1'b0),
        .SUBTRACT(SUBTRACT));
endmodule

(* C_AB_LATENCY = "0" *) (* C_A_TYPE = "0" *) (* C_A_WIDTH = "16" *) 
(* C_B_TYPE = "0" *) (* C_B_WIDTH = "16" *) (* C_CE_OVERRIDES_SCLR = "0" *) 
(* C_C_LATENCY = "0" *) (* C_C_TYPE = "0" *) (* C_C_WIDTH = "48" *) 
(* C_OUT_HIGH = "0" *) (* C_OUT_LOW = "0" *) (* C_TEST_CORE = "0" *) 
(* C_USE_PCIN = "1" *) (* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "zynq" *) 
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
  output [0:0]P;
  output [47:0]PCOUT;

  wire [15:0]A;
  wire [15:0]B;
  wire [47:0]C;
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
  (* C_C_WIDTH = "48" *) 
  (* C_OUT_HIGH = "0" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_TEST_CORE = "0" *) 
  (* C_USE_PCIN = "1" *) 
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
nLbJID86l8uT+fuHbVjxRLXILtSt6EgXG9wZXQM9uMjnSvkC+air8fLeI74wLQjh8sOzS0/eUvdJ
WR7kyrwDIqeDEfewU8BpyYxDMzX7q4aZBGX62BgP3LmpzwF3fCTjNXMGzb2mOke4y57hvYua+dIy
axhJHUmCtlyrZyHjsdnHMeN4bJlAZUZzEF7sfYqv77gpaoU8yo1NFiu9B7c19N6M8WVOJp7xTcBJ
nN5AylVpBnWKJkyuoXzyN8NflUT5p7DxCU4HqizGK9xJ4BKi5pwqB2B+cUHxsZ0UkgSu9eQrfRrD
s33Pbo8NPB4i4RUh0YShkDcRL/ko4kbvtFT+yQ==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
xroS4mzy7chKVWMTrlz8lRjEoOGbJLgSzRgQrokLEN1989GQTvUtUcsBsVHheEEwlUr1v4VnTChq
HDJYvEgwN2FOtUG2JanX8o7B2u2jE90M8biJxUeR2SoE9iuNLKcusWhgTO+LdhvScfZgS1L+iwSz
4GLAGV41zf8xEGvnG50Sew2HIqjwHzMih48K4xJxN5/rWSmMyBbOjHBBjG1SdddjD+tZ0R14K4ss
VF7rA8eWoZ69xgy+EWtIIlqHVXQPC2mP3NmcuFleCJqK2/J/xp6hR9IlMFj1fmxcT0lwdkJlZRtM
wW8NJ+aQ7squZY+zQckEliLCTNbmqdI+bIWxJw==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7728)
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
nLbJID86l8uT+fuHbVjxRLXILtSt6EgXG9wZXQM9uMjnSvkC+air8fLeI74wLQjh8sOzS0/eUvdJ
WR7kyrwDIqeDEfewU8BpyYxDMzX7q4aZBGX62BgP3LmpzwF3fCTjNXMGzb2mOke4y57hvYua+dIy
axhJHUmCtlyrZyHjsdnHMeN4bJlAZUZzEF7sfYqv77gpaoU8yo1NFiu9B7c19N6M8WVOJp7xTcBJ
nN5AylVpBnWKJkyuoXzyN8NflUT5p7DxCU4HqizGK9xJ4BKi5pwqB2B+cUHxsZ0UkgSu9eQrfRrD
s33Pbo8NPB4i4RUh0YShkDcRL/ko4kbvtFT+yQ==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
xroS4mzy7chKVWMTrlz8lRjEoOGbJLgSzRgQrokLEN1989GQTvUtUcsBsVHheEEwlUr1v4VnTChq
HDJYvEgwN2FOtUG2JanX8o7B2u2jE90M8biJxUeR2SoE9iuNLKcusWhgTO+LdhvScfZgS1L+iwSz
4GLAGV41zf8xEGvnG50Sew2HIqjwHzMih48K4xJxN5/rWSmMyBbOjHBBjG1SdddjD+tZ0R14K4ss
VF7rA8eWoZ69xgy+EWtIIlqHVXQPC2mP3NmcuFleCJqK2/J/xp6hR9IlMFj1fmxcT0lwdkJlZRtM
wW8NJ+aQ7squZY+zQckEliLCTNbmqdI+bIWxJw==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 1792)
`pragma protect data_block
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
9rhfvOHQLjuYkmoN1KEtaZtIsXFru8ap6A==
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
nLbJID86l8uT+fuHbVjxRLXILtSt6EgXG9wZXQM9uMjnSvkC+air8fLeI74wLQjh8sOzS0/eUvdJ
WR7kyrwDIqeDEfewU8BpyYxDMzX7q4aZBGX62BgP3LmpzwF3fCTjNXMGzb2mOke4y57hvYua+dIy
axhJHUmCtlyrZyHjsdnHMeN4bJlAZUZzEF7sfYqv77gpaoU8yo1NFiu9B7c19N6M8WVOJp7xTcBJ
nN5AylVpBnWKJkyuoXzyN8NflUT5p7DxCU4HqizGK9xJ4BKi5pwqB2B+cUHxsZ0UkgSu9eQrfRrD
s33Pbo8NPB4i4RUh0YShkDcRL/ko4kbvtFT+yQ==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
xroS4mzy7chKVWMTrlz8lRjEoOGbJLgSzRgQrokLEN1989GQTvUtUcsBsVHheEEwlUr1v4VnTChq
HDJYvEgwN2FOtUG2JanX8o7B2u2jE90M8biJxUeR2SoE9iuNLKcusWhgTO+LdhvScfZgS1L+iwSz
4GLAGV41zf8xEGvnG50Sew2HIqjwHzMih48K4xJxN5/rWSmMyBbOjHBBjG1SdddjD+tZ0R14K4ss
VF7rA8eWoZ69xgy+EWtIIlqHVXQPC2mP3NmcuFleCJqK2/J/xp6hR9IlMFj1fmxcT0lwdkJlZRtM
wW8NJ+aQ7squZY+zQckEliLCTNbmqdI+bIWxJw==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 1280)
`pragma protect data_block
DXQRtUJQaB/Dw1bqBNrLSMiyAcxsVnH+th/uPD3Grg0ofSx+zJXr1LPICy3CLynUjBP7BpSowxsU
J4t19NS+wrLUDp/q9t/mvrCWtidJQWzuln+W5a3bK6kNzNgD24cqQI2BDyLKbUVx3DRGc9x6Kuzr
8zH+uEs/pR/eM1IndOLTwibXiLdVQEDTaVWVnFi3SbDJ6IaLak+3ZMSVUjf5cZTJwo+7y/JgCp/X
/JqpJKUJEW6UIrJXtELhn9yYN0S8NFJ2C3hy9cmecsClAOrs4m9VsFJKDgLhwuuuUJww3bUkJKS5
QRJURgfOKOM+ypt5xRiwaBToEYzgvmMtp7r35/ecA2kDnCE/UMPcnIPu+fwkhDnZezXnixO7WiEx
5E3YD1b7ZnEZndyarf2Oo5voE3gzsWt48qX7xCsEAx37DDxIZ9xlnPLyoII2/zJrnpOTk5sX+lns
qfJT6yfmCedYHOiB0oveHDVYunRrAf6rC16YXkzioUCNFNj2dC712lKL1HfqWoc9osWmnIKTgIeY
wmxpFRTBydTMFTnphUIw0+NG0Gon2CXkUgupH+HOjLLA5lGzJpGlKKoMrpA8lz1ni9CsYv5ru/Yu
ZjjWVUHKbwTZZD5dbqLX5c8BQPPe5AoQRDiWkmSyiv0kbL4Vo5Sczty/NNa44Cd+xmpWz3q1quqM
NkIOHWTRqlwIrelWG8xnFJjWgT4P3D5b06zV3UKUI+/Wzc1tAB5Qe7s71VjBJ3dqKWch4VLZiQrB
T1uAC6BtB8+foTJhjQogvcxEo4h4ehOV3iIbQCmaR2yn5/AHrZOupQyzKWwbetGn9dhnppOGoVHz
ob7fotHuEn6ZGiwglS0x+EJcj/W3RqFUzvNYRsmq1174FkpFOuPS/s0jFj7acShWzyPBWg7sPtpd
phbkdLcJOou51HpMQ8h1WtFCJM0/jd+ut5A9H+wFLb6cR5yKkVZfaafdRAqkHOivE4DSiC+JXxPD
qh96jymTd71hCGRjEHILUdSRteCoCBxQlR6h0KZWd636jzxg6B23euhzU56hor1SN9B1rIcODhhS
yfzAw5/mibU0cyVF5lg3vWFz66f5mX4qqTPxiGGUV+LYh1oJ4FL1BZyaSTdtkr1gEd27KVkHdSZM
jAZago5o7pjT73nF3b0uxCuWyGeTGxDojB8EAmhNRxcKY4rENt6SWLsrrdb1BT4w+cKFC4gsGKcV
KtdCUqexd4nPOhiqQuO79qYAPaVkBYGEym43xshEvH1Lsjk0DaUAMJVRMfzlx+sA3vm2LpBlZpBb
ULYiomoO7giv6w9w3HnjZdCT6NoMLP0Va2uZoL6s7JNv32a8ZIJ7JuCSx63bVm5pyT9oZJORnJ4o
PkhbZRiXi4V7YXLlkvosIswye2/YJFeGyELfEtej5VUIflO81WCHBl+2vf1X/a+PRZdcCkhiiO+i
bboqgAyrINVLoQ4VuBHUScwAJe378QgvLXSu/iLprc4F2hwthnoJsEMR/QbLi6A/KHIMvSXrQ+IB
v4uDwfPhOyo/fviD5x7/O7phyjNGIH5K3FLmrydv+OsPmAP9iDTVOUYY5qE1emxYwDqEO4C1rVPo
LQTAiBHRxk8U3CmRF8WOEhKxqtZrH0diNwWqOCUnSA88X81voOKp5hqs01BzYRYzdmNa01KUM+jf
i2o8sZqZxKBDqkiMKZBmGXJtbuc9p3iFlPM=
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
