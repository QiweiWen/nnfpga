#!/bin/bash
targets="matmul sigmoidgen"


opt=$1
if [ -z $1 ]; then
    echo $1
    opt="all"
fi

for t in $targets; do
    make -C $t $opt
done
