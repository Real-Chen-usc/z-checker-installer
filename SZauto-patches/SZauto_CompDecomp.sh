#!/bin/bash

zc_cfgFile=$1
cmpCase=$2
datatype=$3
varName=$4
ErrBound=$5
filePath=$6
dim1=$7
dim2=${8}
dim3=${9}
dim4=${10}

if [[ $datatype == "-f" ]];then
	echo processing sz_autofloat_CompDecomp on "$filePath"
	./SZautofloat_CompDecomp $zc_cfgFile $cmpCase $varName $ErrBound "$filePath" $dim1 $dim2 $dim3
	echo done
else
	echo processing sz_autodouble_CompDecomp on "$filePath"
	./SZautodouble_CompDecomp $zc_cfgFile $cmpCase $varName $ErrBound "$filePath" $dim1 $dim2 $dim3
	echo done
fi
