import sys
import os


# entry point
libpath = os.path.join (os.getcwd(), os.pardir, os.pardir)
sys.path.insert (0, libpath)

import configs as cfg

# make bash include file
bash_config = os.path.join (os.getcwd(), os.pardir, "include", "config.sh") 
with open (bash_config, "w") as f:
    for k, v in cfg.configs:
        f.write ("%s=%s\n" % (k,v))

# make VHDL module file
