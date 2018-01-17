#!/bin/bash
TMPDIR="./.tmp"
rm -rf $TMPDIR
mkdir $TMPDIR
CSTAGE=$TMPDIR/config.h
PYSTAGE=$TMPDIR/config.py

CDST=./c/include/config/
PYDST=./python/config/

rm -rf $CDST; mkdir -p $CDST
rm -rf $PYDST; mkdir -p $PYDST

INCLUDEDST=./include.mk

rm $INCLUDEDST 2> /dev/null

touch $INCLUDEDST
touch $CSTAGE
touch $PYSTAGE

regex="^[ \t]*([^ \t]+)[ \t]*(.*)[ \t]*$"
emptyregex="^[ \t]*$"

while read line; do
    if [[ $line =~ $regex ]]; then 
        item=${BASH_REMATCH[1]}
        val=${BASH_REMATCH[2]}  
        echo "#define $item $val" >> $CSTAGE
		if [ -z $val ]; then
			echo "$item = \"y\"" >> $PYSTAGE
            echo "$item=\"y\"" >> $INCLUDEDST
		else	
			echo "$item = \"$val\"" >> $PYSTAGE
            echo "$item=$val" >> $INCLUDEDST
		fi
    fi
done < configs
cp $CSTAGE $CDST
cp $PYSTAGE $PYDST
