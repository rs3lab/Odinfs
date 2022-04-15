#!/bin/bash


fs=(ext4 pmfs nova winefs odinfs)
size=(2m)

rm -rf ../data/ampl_data/
mkdir -p ../data/ampl_data/


for i in ${fs[@]}
do
    for j in ${size[@]}
    do
        ./sub-extract-result.sh $i-$j ../data/ampl_data/
    done
done

