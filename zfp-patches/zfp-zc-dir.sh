#!/bin/bash

if [[ $# < 3 ]]
then
	echo Usage: $0 [error bound] [data directory] [dimension sizes....]
	echo Example: $0 1E-4 /home/fti/SZ_C_version/CESM-testdata/1800x3600 3600 1800
	exit
fi

absErrBound=$1
dataDir="$2"
dim1=$3
dim2=$4
dim3=$5
dim4=$6

fileList=`cd "$dataDir";ls *.dat`
for file in $fileList
do
	echo ./zfp-zc.sh ${dataDir}/${file} ${file} $absErrBound $dim1 $dim2 $dim3 $dim4
	./zfp-zc.sh "${dataDir}/${file}" ${file} $absErrBound $dim1 $dim2 $dim3 $dim4
done

echo "complete"

