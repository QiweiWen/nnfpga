// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.4 (lin64) Build 1412921 Wed Nov 18 09:44:32 MST 2015
// Date        : Thu May 10 19:44:14 2018
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
l3LALetpCysr5qYW0EqbpvB55QWOsnJHohRpnkc9WhIH/0iVOi3QB6zfs8/iOg4bUcHTI1S222zO
2FcUt2VLSGqFfdCSx+r3tYdPkAAQKAVZM8OcoZHGwZZcwD8FFv+eBoxeNUOO2c69yOaP9tP/0+Ep
wMmttxwvtRQqWcEfttcN78YN1Og2/Ik1lD7d0z+XNOAc9A/Pwg377ZOUyZFEiN/jbjlb7sKqRQj0
FMnvEFPDph3OePxY3JJqO1F+kdQTntbrdDN/Cmjwou4GqHpiXf7n9xSUkJ6+BJNfhOiYgV1y6uni
XHjGJCXoQOHqsVYvbcxoLCggUbP7xC8fdKMWzg==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
rpxKq3C3HJF83IpcOwtIAeh90FnnijJXvEVziQFUt7unTj2ylUO5SCiefuaGEAPit0rzskoOQlru
Bcu4XkOLwq1BCF1k9m2cgsOBe42ZHWhYI5NDeUf6qDgFvfQztu2JPb1M4T+9P16LsxjVdYzyoYxF
7kiza9RIRfi1n31mlYCn6Y+AABH7GH7jZtpB3FYaPm30iMZ1Fkn/emwPthUP4y4A8nfEQ8dgkhxI
HRzSD2iNguc68LEm0dty+QJhHNnBP1EGmnKLDxhiixiniNc2Fc230cKtE8COArh9+tGQz5PMWWRq
BNApFTisBfQxTRyrECwzVZN3XZjGeP9VghNpqw==


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
l3LALetpCysr5qYW0EqbpvB55QWOsnJHohRpnkc9WhIH/0iVOi3QB6zfs8/iOg4bUcHTI1S222zO
2FcUt2VLSGqFfdCSx+r3tYdPkAAQKAVZM8OcoZHGwZZcwD8FFv+eBoxeNUOO2c69yOaP9tP/0+Ep
wMmttxwvtRQqWcEfttcN78YN1Og2/Ik1lD7d0z+XNOAc9A/Pwg377ZOUyZFEiN/jbjlb7sKqRQj0
FMnvEFPDph3OePxY3JJqO1F+kdQTntbrdDN/Cmjwou4GqHpiXf7n9xSUkJ6+BJNfhOiYgV1y6uni
XHjGJCXoQOHqsVYvbcxoLCggUbP7xC8fdKMWzg==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
rpxKq3C3HJF83IpcOwtIAeh90FnnijJXvEVziQFUt7unTj2ylUO5SCiefuaGEAPit0rzskoOQlru
Bcu4XkOLwq1BCF1k9m2cgsOBe42ZHWhYI5NDeUf6qDgFvfQztu2JPb1M4T+9P16LsxjVdYzyoYxF
7kiza9RIRfi1n31mlYCn6Y+AABH7GH7jZtpB3FYaPm30iMZ1Fkn/emwPthUP4y4A8nfEQ8dgkhxI
HRzSD2iNguc68LEm0dty+QJhHNnBP1EGmnKLDxhiixiniNc2Fc230cKtE8COArh9+tGQz5PMWWRq
BNApFTisBfQxTRyrECwzVZN3XZjGeP9VghNpqw==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 1776)
`pragma protect data_block
NfmSNP+Thn/h565G2fql/QaWGpGMmtpiIC+uhTZ5tJ5At8JQRAzlbqF/9b5B8JcjnGoeAZ5SvDlr
CRJRkYgQ2/kcBiDfRL7SGUFNASUeLeChhtpoGgHky2p8xscsUF1aCn18D2qf1KGozCd31hOfHHBK
FPEJjG80MxTgpBMmMTGsRgq41Y8mmJkYF/bQaCP2sE52E5a0eXZiiAskq7XRMQQ6XMMNXCG6aUos
dbm6jGCkfgMh849HAERhZw/0rPE7w2UvPKeuyQAo8XZPXvXsKmUpS491GKpKcuVMksBiv6A2UZBS
Lkmh6vErNVgRNR6mZxm5Sdy/C8mHi+T2/ap5DnMDVCS1wReks6DRCqupEDUocOWhiyJZFEMRfrBW
k2qUI+bjkgyZhEeTbFbG7wgOY0by532ASpf9mGNDAVsMMBUgFuw/onDqlZP+Qi6jGmgDvQ0Jw16o
JMCKL+hGWm00u40m67br8/Ndra/v5DTnCikc7REglUq2bzzFmcDZ1PwF5Q4jFN6t7O4YfQ3snV07
S2wK9uXEWbrupYRECqHvKLlhyoHQnLg31c2AfPS0OG0Ih/WFvbmM3dJtjT3JD82WJ7YFlzfKuXdq
JtXADhSJx87dDouFJoW05K0++bExh66ox4JUCjCT+W/AbDkHRY4qepiXHW+4slXrglE0E+tB2W0D
CsMOEIOuwyZhzII0Kph+gz4F165yGZjrRk+838Ehf/5NR8rnGG8zPpwb+P54lJdlgXs6kLdo4kZ8
17wJ5KR/Z+83HiSMPOfmA+tgKu/O7FXJe8/CeLXcE315fjTPsAz0NnWMY6w7DkUx2VGrnDB4b6lB
AuOSxKU99QwOkzH75qQulWhvMp3Ibw0YDWC9RerX8D7p+lMHOTwZS/dXU8MzQeyf+DNHPV3jScHq
H2apX/5PTmISZk009h5fcc9Y3IQ2dOvh98yA37H3KX7J6uxzc4DCdTZMMFNX+EB4zMlETeGBecdk
kkNJ5xEdoE557krzP6ouk3Q9N21cUH+86T6ieEteOW98re1/PDv23i4OG3BjxolzqaHzmhGGK/3Y
y8a8HEfufFGjbUoD0I8QeOf80RsULdagidLo8I6TrVnsbQrXQ/Q9k+NBHOkJwe25y15ztqb4heo1
FHtT5cDIeLZ/2hl6yzXzVidgAuNyojleJ7yFTK/nmN+kWnNQt0Qr0hAvObe32aZvI1ipT0lMFmRd
L2EWPRfDR1dsz+yamH0rJHqYBXqz/vcbSbW/pjG+XsRnUvRKS/1jUZdoszry1a/7qSN3oo3WKLqI
731r2gqu6Ap5NjvRcOEaviR6lMvpDiQSjaaUuFAHre0ouahflaVqayIJF8dk0tpeGrZ8CSpPl5oJ
bP5WeOZK8UeTUuBweMgGXO9Em2KjM80nyCX0CumWWp6bfneoDkdkAGlfIWY8vkW66T+ycZ0CIDAO
PCuIt1KrcW000ZfTJSEIYR/cj2+jA/pTd+3hNuqjn+JMfrsiu1TTrvHUJsdDS3PNWCIMnZnD2f3J
XXLix8CxeahSQ5E2N0WnGGQZUZOLr+cVwiYKoHwPyai5s6bCs/cSI1ohtYTMz0clLowSmh7ZskqZ
YOtxJVP2kHKHM8Gy2hvWw7LUYm8+3BldEHJvFe9MeVkPXm/cxdDXW5W8/yupJDSTIcEP0ODM5WIx
zpbdfkRyBo7mwcaLKFaN+vKsobVAsCtExPaulfpqWECVIfkc22uY9/KQoJrYVZD2LSe+fbxORxOO
nqMRpY0L68UsD3/oeaxtkjFe2ff4ZUvg3d21wEzmXoJmwzkZCRnCWAwWiSCLmfPRo+j2iyOzlB7x
myeIUiW7BZ6eTM+nJGZUBswE2nvbb+URzDjNglIW6L3/pF6bGvqQfYYopkTMz27zgKPAKIREqIp5
bxw7HVOrys29Q/WqHlAaBbAUhmMr0NLLTuBQwSBqfCxHj0IxE1lsuqeKLm4wUjhhEmi8AQg2LoR7
ElZxhaYii5dw/nFkAPpVP57Un1/QYMjhhmiVFQBX5uAPtWa8HLRJZhoxVxelLJyVWikq5v5yUeI0
69ed9MEwvRf8nL80ef1C+cgYGbJuCvoSkHa0NWtaifDW+KYnXsSjvRX61dRkgK5BSg1LmbiAS2Yb
gInG2YDrM2/6VA6nkuSXbzSiibQiswKyD9x4Qfz9O6NO5u3Ax+ubOkYRk7f8kd5iC+FCzX+a0gYT
z1yCccnnoQYGpcX5g4BxhXyqVrVGDPsQJzyDPVrTioXE1yMn8fdBV/vt9DMHTxzPhk1mM0WqCsk8
I4cqwzVhkH0X+Iu+ivq2UNkLpSONb0nswDNYIvB7bOX4Ov8wH3xtM2xo+usGQRhkOOb8Rz3PFN7C
vEal7DLl2VVV
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
l3LALetpCysr5qYW0EqbpvB55QWOsnJHohRpnkc9WhIH/0iVOi3QB6zfs8/iOg4bUcHTI1S222zO
2FcUt2VLSGqFfdCSx+r3tYdPkAAQKAVZM8OcoZHGwZZcwD8FFv+eBoxeNUOO2c69yOaP9tP/0+Ep
wMmttxwvtRQqWcEfttcN78YN1Og2/Ik1lD7d0z+XNOAc9A/Pwg377ZOUyZFEiN/jbjlb7sKqRQj0
FMnvEFPDph3OePxY3JJqO1F+kdQTntbrdDN/Cmjwou4GqHpiXf7n9xSUkJ6+BJNfhOiYgV1y6uni
XHjGJCXoQOHqsVYvbcxoLCggUbP7xC8fdKMWzg==


`pragma protect key_keyowner = "Synplicity", key_keyname= "SYNP05_001", key_method = "rsa"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 256)
`pragma protect key_block
rpxKq3C3HJF83IpcOwtIAeh90FnnijJXvEVziQFUt7unTj2ylUO5SCiefuaGEAPit0rzskoOQlru
Bcu4XkOLwq1BCF1k9m2cgsOBe42ZHWhYI5NDeUf6qDgFvfQztu2JPb1M4T+9P16LsxjVdYzyoYxF
7kiza9RIRfi1n31mlYCn6Y+AABH7GH7jZtpB3FYaPm30iMZ1Fkn/emwPthUP4y4A8nfEQ8dgkhxI
HRzSD2iNguc68LEm0dty+QJhHNnBP1EGmnKLDxhiixiniNc2Fc230cKtE8COArh9+tGQz5PMWWRq
BNApFTisBfQxTRyrECwzVZN3XZjGeP9VghNpqw==


`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 1248)
`pragma protect data_block
NfmSNP+Thn/h565G2fql/QaWGpGMmtpiIC+uhTZ5tJ6AtEgszQ3EkTnnwtL2rxO4DtKiQyEhkUYL
6adnPpR3AOjDTWvSdFI02Nm2QBrSjLc5MYRPWN5Svhvv1BGfiT4VVj5oodgPJj4LVWsZwMX+oQP+
6MHiripUDqRUoSYyUpgTb4hM/AfNi8pxCn3kk+gG0gRDq7+5n89AzVZ1pShwmIL/r07k0nDpnU8t
84vi5VDViRSiCdhnwRmY0e+bOlA34zuJf8pVprTWzsn/1tDVdtf1XgErht/F+gsYQNe04LbuS3gR
qA3WqEYSxvANnhyzmKXvBEdYFH+dnDK481javuCevAn10VEsIgu28X5U+pxGM7z5jtqxJlDjUJ5L
A/+AZoNiU4M1FCJDB44YD/p+yjIaRQIs10yuGhm0Csz96dWIzhwqvOdCcEENISee6PT6W9jbgcaV
6k1qCvCpX6Lz1jrMEx0LfnDg1dvFFVZdZH+78Tu+B/WXBuxTSm2aFIM46tOzLgvd1R5ih15ZeBNk
PY1rsflNJF0ZHc6hM94pIAnE3bFaYxFH71pKwoteKPNROL4QBIdJlwo3PeqfR1J7uRvB3aazJ+Ne
j1E2S+86iOcXZnZd40Rg+YLu9UDOeSucfqSguLX7d3TiFJK1d0QRAPRpnK7W3bGi4qxhwm75P0xo
u9bUebsGy0zfayktpebRa7k1RNaQ9g11cemIUpcMaH9JvZTTsi39zc+xh5AE5MJ4l/poi7wYJGwl
3qGMW46xmTTjuhCTrGaFVwB6i8BClToHt+bXAx2GePQ0vFZwB6CTO21FyYr5QR7muvcBf5Mb9H8B
IPmoUYeyigiGHnXHfFayDnCSS6F9R1+A6FELySqFEEyUudxR6tEnmFzkLjZf5ipP7+0aNeM2GVsV
Imy6NVCE+AZJ7GEe9wB5G65j2thBdxi1r6Svb9piGJLgURdG3eHc/8ITNAlVbn95oVs+zzy0GQdV
JY2v6ak/xMzSPwQ7PTmzXaMTGX30avcXZ9k3ByyuTJ86JJkwwhw4b/O9G5bmDBhnWVjxozKTvDXB
K858r+L28+Ts9Q6mebS8yfRWPgLEVHYjzfVCsiyHzt+Y9+77SFjQvTDoOt/i9OlkfslAEu3twH7I
YpEeymM8riP9FQJTBQUbX7KDhlLihiKT9DwBHvYhm8b5N775zEIrrBxxT5r4ktcWCEiTkyHAhQjA
xHnztYOuHLO8DFlKF1hWleRhoM79ipgU1EIO8wWQ5ZKUqoHbfr/xgJarzqGNVioMqCC+9MiOkj4P
A4bnDBXp4+cP5+CdIAowfeTq+mBGEI2Qs/YhL01hpPvN6XtdkBElwgRqPL6MwemlJ6KBmOqy27/p
t/QU8MYFY6eZrjnuyZ2mzhzk0QBV6YpjIi2U8vuMDU+gGYCiF490NgCu0g1nyHYZEJYHJdIjDkFj
XAWtw42Cpk8gDMybdlfyBkCR/yBEE9q5hNBQEm2ko0AA81d5AVqZsEvvWdSQOX2mAl3b+ijxGUSq
pv9oJxhaPHNZw1GkQlfClCnqrV5+ok1ppQL6T15LbP5IcqciFw9zZoX5cxUptGbpnbDrdoq9Uk3n
phbm8fmqrVTrxtBvzTCRhs0QjHkU3lmQcSvrcUHu1HNRVEyo5+YyW7f4SEVM5ACV3lTk
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
