#!/bin/bash

if [ $# -ne "2" ];
then
    echo "usage: $0 [dir] [output_dir]"
    exit 1
fi

dir=$1
output_dir=$2
cores=(1 2 4 8 16 28 56)


echo "On $dir"

for c in ${cores[@]}
do

    media_ops=`cat $dir/pmwatch-read-${c}.txt | awk -F ';' BEGIN'{sum=0}'' $7 ~ /^[0-9]+$/ {sum = sum + ($9+$19+$29+$39+$49+$59+$69+$79+$89+$99+$109+$119); }'END'{OFMT="%f"; print (sum)}'`

    cpu_ops=`cat $dir/pmwatch-read-${c}.txt | awk -F ';' BEGIN'{sum=0}'' $7 ~ /^[0-9]+$/ {sum = sum + ($11+$21+$31+$41+$51+$61+$71+$81+$91+$101+$111+$121); }'END'{OFMT="%f"; print (sum)}'`

    amp=`echo "scale=3; $media_ops/$cpu_ops" | bc -l`

    echo ${c} ${amp} >> $output_dir/$dir-read.log
done


for c in ${cores[@]}
do
    media_ops=`cat $dir/pmwatch-write-${c}.txt | awk -F ';' BEGIN'{sum=0}'' $7 ~ /^[0-9]+$/ {sum = sum + ($10+$20+$30+$40+$50+$60+$70+$80+$90+$100+$110+$120); }'END'{OFMT="%f"; print (sum)}'`

    cpu_ops=`cat $dir/pmwatch-write-${c}.txt | awk -F ';' BEGIN'{sum=0}'' $7 ~ /^[0-9]+$/ {sum = sum + ($12+$22+$32+$42+$52+$62+$72+$82+$92+$102+$112+$122); }'END'{OFMT="%f"; print (sum)}'`

    amp=`echo "scale=3; $media_ops/$cpu_ops" | bc -l`

    echo ${c} ${amp} >> $output_dir/$dir-write.log

done

