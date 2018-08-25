new_lib_path=`pwd`/sw_prototype/libs
if [ -z $LD_LIBRARY_PATH ]; then
    export LD_LIBRARY_PATH=$new_lib_path   
else
    export LD_LIBRARY_PATH=$new_lib_path:$LD_LIBRARY_PATH
fi

# install stuff

archs=`sudo dpkg --print-foreign-architectures`
{ echo "$archs"|grep "i386"; } || {
    sudo dpkg --add-architecture i386
    sudo apt-get update
    sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386
    sudo apt-get install multiarch-support
}

# make libraries 
chmod a+x sw_prototype/libs/makeall
sw_prototype/libs/makeall clean
sw_prototype/libs/makeall 

# make configuration files
( cd config/scripts/ && python makeconfigs.py )

# metaprogram
chmod a+x metaprogramming/makeall
metaprogramming/makeall clean
metaprogramming/makeall

# copy metaprogrammed files into vivado project
cp metaprogramming/sigmoidgen/vhdl/*.vhd zynq/neuralnet_ip/hdl/source
# TODO: do the same here for metaprogrammed top-level neural net design
#       when the software is there

cat << EOF
++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Project set up complete! Run the tcl scripts under zynq
in vivado to create the projects.

++++++++++++++++++++++++++++++++++++++++++++++++++++++++
EOF
