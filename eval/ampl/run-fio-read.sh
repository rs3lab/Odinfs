#!/bin/bash

source common.sh

if [ $# -ne "2" ]; 
then
    echo "usage: $0 [fs] [block_size]"
    exit 1
fi


fs=$1
block_size=$2
dir=$fs-$block_size

script_dir=./
if [ $fs == "odinfs" ]
then
    script_dir=./config_odinfs/
fi

mkdir $dir


for c in ${cores[@]}
do
	echo "init " ${c}
	fio $script_dir/config-${block_size}-r-${c}.fio > /dev/null
	fio $script_dir/config-${block_size}-r-${c}.fio > /dev/null
	fio $script_dir/config-${block_size}-r-${c}.fio > /dev/null
	fio $script_dir/config-${block_size}-r-${c}.fio > /dev/null
	fio $script_dir/config-${block_size}-r-${c}.fio > /dev/null
	echo "init end" ${c}

    sudo pmwatch 1 > $dir/pmwatch-read-${c}.txt &
    sleep 15

	echo "starting " ${c}
	fio $script_dir/config-${block_size}-r-${c}.fio > $dir/fio-output-read-${c}.txt 
    sudo pkill -f "pmwatch"	
	echo "ending " ${c}
done


