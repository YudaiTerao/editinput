#!/bin/bash

Py_PATH=$(cd $(dirname $0); pwd)/AFMconvert.py
DIR_PATH=$(cd $(dirname $1); pwd)

if [ ${1: -1:1} == "/" ]; then
    FM_DIR_NAME=${1%/*}
    FM_DIR_NAME=${FM_DIR_NAME##*/}
fi
if [[ $( echo $FM_DIR_NAME | grep FM ) == "" ]]; then
    AFM_DIR_NAME="AFM_${FM_DIR_NAME}"
else AFM_DIR_NAME=${FM_DIR_NAME//FM/AFM}
fi
AP=$DIR_PATH/$AFM_DIR_NAME
FP=$DIR_PATH/$FM_DIR_NAME

if [ ! -e $AP ]; then
    mkdir $AP
else
echo "AFM_convert.sh: $AP already exist"; exit 1; fi

while read MN; do
    if [ ! -e $AP/$MN ]; then 
        mkdir $AP/$MN; fi
    while read FN; do
        if [[ $( echo $FN | grep scf.in ) == "" ]]; then
            cp $FP/$MN/$FN $AP/$MN/
        else
            python3 $Py_PATH $FP/$MN/$FN $AP/$MN/$FN
        fi
    done < <(ls -1 -F $FP/$MN | grep -v /)
done < <(ls -1 -F $FP | grep / | sed -e "s/\///")

ls







