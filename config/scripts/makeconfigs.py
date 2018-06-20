import sys
import os


# entry point
libpath = os.path.join (os.getcwd(), os.pardir, os.pardir)
sys.path.insert (0, libpath)

import configs as cfg

# make bash include file
bash_config = os.path.join (os.getcwd(), os.pardir, "include", "config.sh") 
with open (bash_config, "w") as f:
    for k, v, dc, dc in cfg.configs:
        f.write ("%s=%s\n" % (k,v))

# make VHDL module file

vhdl_config = os.path.join (os.getcwd(), os.pardir, os.pardir, "zynq",
                            "neuralnet_ip", "neuralnet_ip.srcs",
                            "sources_1", "new", "helperpkg.vhd")

with open (vhdl_config, "w") as f:

    f.write("library IEEE;\n")
    f.write("use IEEE.STD_LOGIC_1164.ALL;\n")
    f.write("use ieee.math_real.all;\n")
    f.write("\n")
    f.write("package helperpkg is\n")
    for k, v, altk, vhdltype in cfg.configs:
        name = altk if altk else k;
        f.write ("constant %s: %s;\n" % (name,vhdltype)) 
    f.write ("end package;\n\n")
    f.write ("package body helperpkg is\n");
    for k, v, altk, vhdltype in cfg.configs:
        name = altk if altk else k;
        # make room for sign bit in ieee_proposed.sfixed
        v = str(int(v) + 1) if name == "PARAM_DEC" else v
        f.write ("constant %s: %s := %s;\n" % (name,vhdltype, v)) 
    f.write ("end package body;\n")

    
