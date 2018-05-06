// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.4 (lin64) Build 1412921 Wed Nov 18 09:44:32 MST 2015
// Date        : Sun May  6 17:37:25 2018
// Host        : dave-MS-7A37 running 64-bit Ubuntu 17.10
// Command     : write_verilog -force -mode funcsim
//               /home/dave/workspace/nnfpga/zynq/neuralnet_ip/neuralnet_ip.srcs/sources_1/ip/xbip_multadd_0/xbip_multadd_0_sim_netlist.v
// Design      : xbip_multadd_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "xbip_multadd_0,xbip_multadd_v3_0_8,{}" *) (* core_generation_info = "xbip_multadd_0,xbip_multadd_v3_0_8,{x_ipProduct=Vivado 2015.4,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=xbip_multadd,x_ipVersion=3.0,x_ipCoreRevision=8,x_ipLanguage=VHDL,x_ipSimLanguage=VHDL,C_VERBOSITY=0,C_XDEVICEFAMILY=zynq,C_A_WIDTH=16,C_B_WIDTH=16,C_C_WIDTH=16,C_A_TYPE=0,C_B_TYPE=0,C_C_TYPE=0,C_CE_OVERRIDES_SCLR=0,C_AB_LATENCY=0,C_C_LATENCY=0,C_OUT_HIGH=15,C_OUT_LOW=0,C_USE_PCIN=0,C_TEST_CORE=0}" *) (* downgradeipidentifiedwarnings = "yes" *) 
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
  (* x_interface_info = "xilinx.com:signal:data:1.0 c_intf DATA" *) input [15:0]C;
  (* x_interface_info = "xilinx.com:signal:data:1.0 subtract_intf DATA" *) input SUBTRACT;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) output [15:0]P;
  (* x_interface_info = "xilinx.com:signal:data:1.0 pcout_intf DATA" *) output [47:0]PCOUT;

  wire [15:0]A;
  wire [15:0]B;
  wire [15:0]C;
  wire [15:0]P;
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
  (* C_C_WIDTH = "16" *) 
  (* C_OUT_HIGH = "15" *) 
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
(* C_C_LATENCY = "0" *) (* C_C_TYPE = "0" *) (* C_C_WIDTH = "16" *) 
(* C_OUT_HIGH = "15" *) (* C_OUT_LOW = "0" *) (* C_TEST_CORE = "0" *) 
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
  input [15:0]C;
  input [47:0]PCIN;
  input SUBTRACT;
  output [15:0]P;
  output [47:0]PCOUT;

  wire [15:0]A;
  wire [15:0]B;
  wire [15:0]C;
  wire CE;
  wire CLK;
  wire [15:0]P;
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
  (* C_C_WIDTH = "16" *) 
  (* C_OUT_HIGH = "15" *) 
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
qxCBBdrOvkNBoVvBi9+lOdRQey3naSR5CGxoCPlXrn87eqlGOdrM3/FT37CwqCH4WvWDFCXQfqMG
hiRoKvs7NRJoTEx25yexJBsLje/yppyOrVzgXH/7rN2hpM1I9Im4STbZW6GEb7OvKlwg7Flcg4FK
Ptazp5vSS6MtMPo8zbcPe0n73AcxJzLFkAKnkkoElWzGLTpqXpni0KHEVRzKRbuBT0uO04yRrzz6
zwLR252SU0qfNkNYHT+TL+uRnd/88SumjFdgDas7vXgURn14BlaF9y8GZXV+od6dmGegNoGpzecR
aq98hnGv00dOR4uArxfTsVVxQWm3gvfXAd8Y8A==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
Mso3hrw0ATC48OUErqPlJUjzwy+SwZ7e9yMocUYJw8sm8+3Lhp3LEPYrzIeY1VBvlfGpkOeYFWmh
BUeeoJS5Q5x+RRNwkxAivHCnOjGnJSweKTFNvUYdlfEP7eZfjgWxZQ/BKe9q9it1KbqymMfMwBOx
Me8ezj+JOaICcPfdPr/KdLpHYWVcV3MFW0bc/A9LQzuruftu+q6wvOkUuoKLIeMx+Rktywz71tsO
+lzBLSFLAwOxPYGxAFVNs1EWJNwW9yMyPGEIMGjdF5CUEY7Zbb459NtfKLugL5+TQsrF6RLKLst5
DlDKjSkeAdAlkqIAAtWzjPCHumU08aBJETQe9A==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7280)
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
qxCBBdrOvkNBoVvBi9+lOdRQey3naSR5CGxoCPlXrn87eqlGOdrM3/FT37CwqCH4WvWDFCXQfqMG
hiRoKvs7NRJoTEx25yexJBsLje/yppyOrVzgXH/7rN2hpM1I9Im4STbZW6GEb7OvKlwg7Flcg4FK
Ptazp5vSS6MtMPo8zbcPe0n73AcxJzLFkAKnkkoElWzGLTpqXpni0KHEVRzKRbuBT0uO04yRrzz6
zwLR252SU0qfNkNYHT+TL+uRnd/88SumjFdgDas7vXgURn14BlaF9y8GZXV+od6dmGegNoGpzecR
aq98hnGv00dOR4uArxfTsVVxQWm3gvfXAd8Y8A==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
Mso3hrw0ATC48OUErqPlJUjzwy+SwZ7e9yMocUYJw8sm8+3Lhp3LEPYrzIeY1VBvlfGpkOeYFWmh
BUeeoJS5Q5x+RRNwkxAivHCnOjGnJSweKTFNvUYdlfEP7eZfjgWxZQ/BKe9q9it1KbqymMfMwBOx
Me8ezj+JOaICcPfdPr/KdLpHYWVcV3MFW0bc/A9LQzuruftu+q6wvOkUuoKLIeMx+Rktywz71tsO
+lzBLSFLAwOxPYGxAFVNs1EWJNwW9yMyPGEIMGjdF5CUEY7Zbb459NtfKLugL5+TQsrF6RLKLst5
DlDKjSkeAdAlkqIAAtWzjPCHumU08aBJETQe9A==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 1776)
`pragma protect data_block
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
h40Md/uh68qy
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
qxCBBdrOvkNBoVvBi9+lOdRQey3naSR5CGxoCPlXrn87eqlGOdrM3/FT37CwqCH4WvWDFCXQfqMG
hiRoKvs7NRJoTEx25yexJBsLje/yppyOrVzgXH/7rN2hpM1I9Im4STbZW6GEb7OvKlwg7Flcg4FK
Ptazp5vSS6MtMPo8zbcPe0n73AcxJzLFkAKnkkoElWzGLTpqXpni0KHEVRzKRbuBT0uO04yRrzz6
zwLR252SU0qfNkNYHT+TL+uRnd/88SumjFdgDas7vXgURn14BlaF9y8GZXV+od6dmGegNoGpzecR
aq98hnGv00dOR4uArxfTsVVxQWm3gvfXAd8Y8A==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
Mso3hrw0ATC48OUErqPlJUjzwy+SwZ7e9yMocUYJw8sm8+3Lhp3LEPYrzIeY1VBvlfGpkOeYFWmh
BUeeoJS5Q5x+RRNwkxAivHCnOjGnJSweKTFNvUYdlfEP7eZfjgWxZQ/BKe9q9it1KbqymMfMwBOx
Me8ezj+JOaICcPfdPr/KdLpHYWVcV3MFW0bc/A9LQzuruftu+q6wvOkUuoKLIeMx+Rktywz71tsO
+lzBLSFLAwOxPYGxAFVNs1EWJNwW9yMyPGEIMGjdF5CUEY7Zbb459NtfKLugL5+TQsrF6RLKLst5
DlDKjSkeAdAlkqIAAtWzjPCHumU08aBJETQe9A==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 1248)
`pragma protect data_block
kvdZjHHVi4FrUMrtW5iVHSFNueD7J6pN9RqAbbKjLdQLFryN4LClUEolXBY4D6y5kIAGLaN3u4Pe
Wg9AYnuZH4HqLTRHbLwFwu0PRIF08IEIbE/b5Uu9Cl28u+XSvpA/NOdglIihbFfMf5EHWbOuTqUu
+c8PnUOCtSpLwp8URGw/qaZJo+s9DzKBWzoGSfK3NhUakOLaiYbzdXSdH8MO33K5tDH7ZGrz/saE
neir8FCd3QGYCqe/dFzRp6+hXW1lj8WaPDzjgLK2C00MdQ7bJa12wFgJkhZ1qwEB/H6vyhXjlCtw
Ad8vl9mUJduN/cn8BktcakLvJnJOlYbs41dTeAGKy6d4XZ6FgKFgRkFlgum/ReCqZFg+mKsDUihu
EgqwraodXDk7qPfQHmA5ns+DQ5RRpDsqog8hUgG+1DMzjNIewISneAF9cQQwU+YK4RZulEqXq+iW
yGkcjYXuAJhVeIigScVx8GRrCfvc1Tnd4sD7ZsjmvLHvvWFhH5RlD6eqWLUOQ1Y/CCMP3+euz1cC
crwdK0eCY4WgfHNBE6z8xTqXDvBBa7acJ7A3dgbeNuu59x6WygVSW3wRP0kUSfLGDpD7zaJAXa0+
O46Yu7YXD595hBlEMW4Cuvvb01w35NhTUyljq/0/bW9bRUGEU+/Jtj4lsAncs0AysSIf8i0Bql5C
976jMKGVKz1Ojl18wXwlRq0qL3dGokwcqQtCTGy9PhjVOwQXmJiRkSkfWMeO9f+02nujt+bL9aKc
iliEE1ZqHfQZWNURWYxo+R1S8BSrMOM4hwpKhJzmyS6/py2Dluro3MtKGB6o3wMqg1vEevNSwQ8C
bTmDFiESZUX985WUot3n+cpYebmjfi5IWPdx2hkMV/B96FuPh1+6k4o+SdFY8L+/UYe5Hbp46Z2q
WMxlyFA8Iv0UH6zmho2ojvW5zl0bgvVg2tXUGjce4LsnJiKw8u6WigXmbXKRLhUsNsurtMfUXlhB
vXX3Y4hsOFoRsLktlhNik2q1AnNDXYZmzyWfejmdbLfupB5V4tjUmOasHywHghFzYOf+wHavBbrx
j5Ct2uP62SRxTuEynLRL+pkhGy/MkFTfNR4UAHCwNLc0j2OP3Mg3LAVJBqFuf5xM1aZPPkVckn1+
kbYgmi7P797Pter3I3KZ9yTltx4Q6y0gvMvj3kK1MYsGbX/EUWIzwZ7XxPx3cx7Vo+gr8VtKFj9Q
JmPaAw6ucr7gcog4zrfSDWay/yxb87guUK4QFuY/5CP8T9QtdB5aGLKlSDEngedOk5GaHLgu2Ih8
4NxEvKuMblAxrjTVlF7OCfHv2/v0+lL+ur7P9+//4S1Nddp7HlKyG6cjIKdj0cT23Gef+0qquSUj
ZsJ9x8YP6mavuQAmn0S4ez2byAfLYN33bE9pjjJxitDovFGIDicdG/4SDcJasvqyTaomB/0zXp1Y
OojTx89lgJrkbK4y3BK+wQc+YFUWkPcQMOog1NqBiZeY1b/5e1TNUJyDnFUZ84bh1G3EcznDCaWq
C+O3KORnf3Xe9emrOgwokiLhyZC9XU7gO1mGym57+O5dpmfVtVRTiH0EpaLbG1hhOmVa94jHhDTz
hcccDWtDcHa/IWNNDXQQXA5/vzbnkWWcxLU2QBgheuh39akldINwIHyrdTVc3duquocg
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
