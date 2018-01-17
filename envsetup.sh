new_lib_path=`pwd`/lib
if [ -z $LD_LIBRARY_PATH ]; then
    export LD_LIBRARY_PATH=$new_lib_path   
else
    export LD_LIBRARY_PATH=$new_lib_path:$LD_LIBRARY_PATH
fi

