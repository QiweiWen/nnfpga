// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.4 (lin64) Build 1412921 Wed Nov 18 09:44:32 MST 2015
// Date        : Mon May  7 15:39:52 2018
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
Snhml8x8WJsf5C1KCQiaT5PMdhYUCVCDMzQMkTo1U+nbzLin/xivGXncczGIEPps0GwJJuz4bfGm
m7b5UtONRWNYH22i8+xYPVzg5Oxq2Ym9/+m4Ch1LDTFCowv9EUb5VmY9c1ZhvBjgsCRqsku9C9+K
CMLH0Yba7dKp/7tnAXXB+GoKfGLPWPfkx+sRGt4yskMH6/0dzfbkAGXGbXW8nUvoS+tONVRgPg47
x5eAQEFUhTeE/DVyK3Vfl0eIfFdbwQgNzf+POqH5kjxoTAVLT7BMiA1bsR+XlsCUC8EaKa+Y7jWW
CsIN80eMwJ5zSaZ8iqoZey0bNtJqizzYIqntzQ==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
lcJqfEwVyJdFRO9TJWG8V0CJhLPHRQ/bi1RbnThiHqL6jzyt1mY673kTLtRKqHhi3U14sIFTclxf
RSY6juek2kAxXyhgRpfUuJv4V3M6zE4gzdB9aIs1drklwzYCjPd32Yo1kdHogImfd9TgNl77cvU8
/Tp86KdXh/ulcCAwKYdbKmhRCB1hw57p1qXKtCNlF8GsqW9obloo+4MgEvCwJjKA6cjq7vBizdCX
o/XV+kSKssHbr3LT+pLms9GGTzqOYOxVp2VbsFjEhRrqR8hiCkDJLaXHr3v/Bn1dtmJBIuBBuXp5
jIH0IfbibfumdJdaE7pysuIJA5hDBilTNWdQ/w==


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
Snhml8x8WJsf5C1KCQiaT5PMdhYUCVCDMzQMkTo1U+nbzLin/xivGXncczGIEPps0GwJJuz4bfGm
m7b5UtONRWNYH22i8+xYPVzg5Oxq2Ym9/+m4Ch1LDTFCowv9EUb5VmY9c1ZhvBjgsCRqsku9C9+K
CMLH0Yba7dKp/7tnAXXB+GoKfGLPWPfkx+sRGt4yskMH6/0dzfbkAGXGbXW8nUvoS+tONVRgPg47
x5eAQEFUhTeE/DVyK3Vfl0eIfFdbwQgNzf+POqH5kjxoTAVLT7BMiA1bsR+XlsCUC8EaKa+Y7jWW
CsIN80eMwJ5zSaZ8iqoZey0bNtJqizzYIqntzQ==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
lcJqfEwVyJdFRO9TJWG8V0CJhLPHRQ/bi1RbnThiHqL6jzyt1mY673kTLtRKqHhi3U14sIFTclxf
RSY6juek2kAxXyhgRpfUuJv4V3M6zE4gzdB9aIs1drklwzYCjPd32Yo1kdHogImfd9TgNl77cvU8
/Tp86KdXh/ulcCAwKYdbKmhRCB1hw57p1qXKtCNlF8GsqW9obloo+4MgEvCwJjKA6cjq7vBizdCX
o/XV+kSKssHbr3LT+pLms9GGTzqOYOxVp2VbsFjEhRrqR8hiCkDJLaXHr3v/Bn1dtmJBIuBBuXp5
jIH0IfbibfumdJdaE7pysuIJA5hDBilTNWdQ/w==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 1776)
`pragma protect data_block
2saDBTEBOf71i+bi99Rt7/P9wipRaQeR7RGleWjDz5QQpAipxn+9NdUPDCO/SzZNik3YG20sebHI
RaGI0RQGgYzRyJJitEEufzK7MI13kbxnJ0tOzOtCnZBVHFZSNzIPjzP96x3VC3zYP5UwHaqtCHsQ
QcnHQN/JiKaI8Ys1aqksVHqdjL1f6kC0braFRk4dZh75X3M23Cfdjx7n0a+iTkuWg7is6XCTEzGT
qWUehaS5sr7C9965WExDKByLt5+8jniC/HQVqICl0hOIV8eEwtp7/oJ0z2+Imiq6WUGO9QSvyO5a
tTrRxFRtqJJVB8/mjqCuyZXvoDFMGGgBM6xoErCECurRVeqFZXr0oewBfXrjm+g/PJOvntvhNh0+
d2PLQ6/i4jK3yQRmSt0qbiLKBczxqzvvGIRvVykoEJfNPnb1hLre5FDcrss/Z/aSKbSGTvEZqgbs
uVX1ZDrmMKBiGKdgtpYvSrJhMd6N1E2Zm4f228YYfOIuMQKIo4WvjI0A4JUiawP+JLPvdNPQo56e
gT0Kg5l/hEyDJW/3R15pI1kKnwmDpmTCQOmnP+qxq/yPJ+Uc1dzvjrXFQkEYp6WGkURsM0VxTJeJ
8GyCG2Ki/XQc/JDE7coGY22nIsZ5TdQNnX+FTjzuTD1F8HwXqsHKJ/YajStdXtjugbgXKfPM4ft3
Zx8mGMrbBvKw+TChAzb9r23M9+Yh5dUzZPFZBxwjcNJgGk2C0kTC2mPoPb0FrWH1TWGO/2JSKbrI
+HFOKNYM3aztYJ+lVNfpAM13cPtheMtin+JlArw5Z90qRmpm0PN71uvFyEYJ+v4seDnDuowzbEOT
rKl7mb4+6W/ReI22SCs+1B5gakOgfeZo/AfjtnpG3ArDbLL4zkS+IXVQkw0gJ+ef0NYRxzcY1vjm
lx447rk3W4imGiQx3jdVynPun2ty6PjKq9DVgUUb5cnyXOCWQlVAYkP4M764CaJ1eA/FP8w0NgaM
IYv9B+O0x0s5KSJU4T0wHv1QiMba0wLQcDbwLVe5zUFOrZhcLFrdJC7zdybgDSDIV6gRzB2NDy8Z
4JyYed4U6FSzaYRkZVAq4EdwWv5YdWkDe3XxV/+JzxW6F3d9KG8AbE81CvNuTc/79H1bl+meueJW
HWVeIIoDgV78iy0DssqxvzwnSh3q8QeMSFy8Nd8gSilBEMQtRcxV6xILfH+jN2qSSnhUz60nmWp7
s2x+mhRygpeQ/TXMA58sEqA1OKxurMA/4/UfhjNvEMxBSmZovAwasdqlUkIcf/EAXGSsQ5VWodnh
FAwzFbyIu4CFGuwg9Ja84cir+d5qLKeeE9CWayjfO5Clha0akoQDSBQE54OgDUHU3yBi5uFp5+lv
Gx2dX3GxcpNm/jicSXtgU0zKF94qyU+hBsZK5+FEqy8csCbPAzVY6ZaV3JFJN74rW/RSlSwpmrL3
S65vdk6eannPDIACBdQDyRG5Bslsfh01e+QjO2l/JSfAUDwQ8APXuVHOqBYTL9H9WRYFT10F5FY9
MGls5b5hqXdjjNxjqJPy5FROuFe4H3iEFCPie0eYuJrbcQmvI9B/WXueQVAC+19NsrzCu9q6ZfYR
8Mg+y60ImXoewr5YTHK3bo8LqW3ACXHnsd+uQCQvoQeD/ksArlgOjzNy/bPKBbHiHF2N5bY1Vv2u
6FF7EsfhULHN2mPg5Hi3f2Dv6f3MZm/cJjlty+589gihM5yaA6tA62UvFWBH/XueQWmegFoPxg5x
g3jiBIj1iRJOwdBWqE0mro00A4GKSvgQlB2t7tw3Ni2obibuKi3ypWtMECwMu67HXB8znWajEsBW
uypuXIj2FrsI2l7tTr+JtMlk4R1l2A1+0/19z/tUnAoB9x+/2fEClIIF5xq4+H8r5urOF24ZDrns
xfokfZo4bDSCsEzJ7aFoPi4Tokdxq8234V31Ook6REm1LNlJfWKdrRIOZ8FEg238FsvEXLJzYHiO
+pHg+3HobEGQEuTKKNmiUSCqnlrZZ2/St3Fsknm40Vso0sq88ePq5kdxxMOl5mLZbcWYJJPlzltl
abAhRone2NyZEGoa3ncRQt4vWYD2bZZCZC8JY53RE69uD5QMnY8aD7bCXWLx6zbcw1r/i3mrb7fZ
PXy4mBMFcLuDosq9JrAvsOD2xKw2LYLirjQpvmCdgRxo8Xz0MytjIy1XjUthSuh2YFxdjSX9v3md
wq/oT0f6JywCjDM0anFVZIxhj+y2JK2MidaiUwGff9ALiDOMtoZQIu3rUGsEV972f43cW/cEFet8
WDfATAr8gNG5LGc2fS3Sy+m59hP5//iGRC5Gt5zm+h0CVnzfQYIWV3dmAdO/42vSL8Raxy/IXMpf
5t9p2xBfyaws
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
Snhml8x8WJsf5C1KCQiaT5PMdhYUCVCDMzQMkTo1U+nbzLin/xivGXncczGIEPps0GwJJuz4bfGm
m7b5UtONRWNYH22i8+xYPVzg5Oxq2Ym9/+m4Ch1LDTFCowv9EUb5VmY9c1ZhvBjgsCRqsku9C9+K
CMLH0Yba7dKp/7tnAXXB+GoKfGLPWPfkx+sRGt4yskMH6/0dzfbkAGXGbXW8nUvoS+tONVRgPg47
x5eAQEFUhTeE/DVyK3Vfl0eIfFdbwQgNzf+POqH5kjxoTAVLT7BMiA1bsR+XlsCUC8EaKa+Y7jWW
CsIN80eMwJ5zSaZ8iqoZey0bNtJqizzYIqntzQ==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
lcJqfEwVyJdFRO9TJWG8V0CJhLPHRQ/bi1RbnThiHqL6jzyt1mY673kTLtRKqHhi3U14sIFTclxf
RSY6juek2kAxXyhgRpfUuJv4V3M6zE4gzdB9aIs1drklwzYCjPd32Yo1kdHogImfd9TgNl77cvU8
/Tp86KdXh/ulcCAwKYdbKmhRCB1hw57p1qXKtCNlF8GsqW9obloo+4MgEvCwJjKA6cjq7vBizdCX
o/XV+kSKssHbr3LT+pLms9GGTzqOYOxVp2VbsFjEhRrqR8hiCkDJLaXHr3v/Bn1dtmJBIuBBuXp5
jIH0IfbibfumdJdaE7pysuIJA5hDBilTNWdQ/w==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 1248)
`pragma protect data_block
2saDBTEBOf71i+bi99Rt7/P9wipRaQeR7RGleWjDz5Tmw1ZFdbfDOdHmkCPlvsjRGLbMsYdyO+Mh
hzPA44+Yz1V5b2TylXaDcU2W9xCJAoznj6ZSVsfXTNkL9+qWm7uqcDwiU1ysRA+P89gO1/A/fwkv
56HYMi7KlV0tMzNkBtohAGfGIpoHyzWctNgyfsb/JTZKbCSM3W09VZ3JG5F8uvrMX9siIUDHXn3a
ny1bcILdUkp2OXRvBL4lh7oywxKNwSjwj8Fuz0EzIpTG8fuuzMMGvyh2tIvNnep6ONBaNHgCFlsv
nIYVg1nNHtwviXsUOCfpu7eMr5UdO9IdL/qJMpL+0cftY5Wyiyr0NM8jquL49m7ffOul7EOq8og+
QFZEFHkevwTyg4rCSpZyQzPjFs1TgQQCaF5zhVZ+xoX+11K8aNRH1NojeQvUipSiym0FdvIUir5O
7F3BFu5fTvQUIO7KAZZWcGJG8X0O+s63Vkt/IlHoDT/NWe2BJcDa59YtKfxH23R9Wy1wXGXDX/1k
Cc1Yq4pnZmGWFeWJnVEnSF0VTGvpwfiR6E2mU2XjmT8wqlA0qNENGLErSTG3DvfrP3qa9sGvgOLW
PVQR7ePvxlbpmFGGG3bcOTj2Ba12aMzLi1b47eSonFQt5b6K1ViRVP/Wk3XGbIDD+MJrjRY5JJ7K
Bvjp9fOpBkmdxSvugvtHn/Euj5qTKTqywHJX3fP8mMZ5SNHXG6iM/gaUrzrJTSqv3PUT9c6nSiTK
0kgm6QjU60VlguhhVQTk3N2iFy85m23lYwq9/z0yEs64bdw3SAOTltpTFZok9A95/2ZUPBuvtGdu
ei4ByCQ2Gtlt3AYXbjdt0K9FNenXOD597BJerzFFC9W9wVCXaJKmy9iRxVeFGcBoBELLguAziauE
FACrO9liekGDSgNmkVRQXNc+iJ5VY0DGSrNGXi4pXxc4GXiNUAf26ObOroErfjCeabYipuXUV0DV
MDsnE4C8fD4a1ukmjKhDDoEDIymfCO8GC+zaleWwZVdJx+hHERqvHMx5BGzfLjuyDbDzyjVdRUEK
NKakDQkZ7/PmdKmMoKbzu1HbVHTL9s9X6qJjajzB2SgzfVyEgNsVgXQL6GJRSMsqyDYZfAjcmfbY
xci1k1Z7Ns+TCYLlf3eDSDShrR1ZSWcg1rtytUgivB+ecQyItJUGHplgXo9rdfkTOzY44m4wKRyb
oyijFLVsrP1ZfpVLMWyTQQ6wBB6L1oBNDUxUKbV2we+F0sfbXIjOn0wTmZBY9O2f9HYgJ2BpZAcT
4zhkCND0AYnQv3CTkN39Skh8ATsIyWMpm20AQRfu1utj2CYamd1JHgKQsicebqGyTyZeQYspWJ76
tVsFzYOwEgZYFNI2JLAazXyYU5+sKfPruOpugIiZIWDiXtzIhvkkmFcVhAVvlmwXeBihENuav4lk
wXZikbPUiXdegzYuRGIna4ZXTrxKQ/a1lc2MxNHvK90Q66N33wMO1Fe9Nj9eZn36G1L21gTS9giO
tG5P0dL26mthbfu9aQjwhAcvnfu49K1TXpMdWDfFhf2P2FHvm2I600nCR/q3222KzGPaodpt5x3V
IBEVqI9ntYWMArjcXp097ZyUvmjXSH6ImB89x5cZqvSE7faV+JkRaaTmi4+JDIhj01vi
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
