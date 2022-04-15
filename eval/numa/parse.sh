#!/bin/bash

write_config="all-local pm-local pm-remote"
read_config="all-local pm-local pm-remote pm-remote-2nd"

output_dir=../data/numa_data/

write_dir=./write-log/
read_dir=./read-log/

rm -rf $output_dir
mkdir -p $output_dir

for i in $write_config
do
    pcm_output_read=`cat $write_dir/pcm-$i.txt | grep '*' | awk 'NR % 3 == 0' | cut -f 1 | tr -s ' ' | cut -d ' ' -f 7`
    pcm_output_write=`cat $write_dir/pcm-$i.txt | grep '*' | awk 'NR % 3 == 0' | cut -f 1 | tr -s ' ' | cut -d ' ' -f 8`

    #get avg
    pcm_output_read=`echo "$pcm_output_read" | awk '{ total += $1; count++ } END { print total/count }'`
    pcm_output_write=`echo "$pcm_output_write" | awk '{ total += $1; count++ } END { print total/count }'`
    # convert from GB/s to GiB/s 
    pcm_output_read=`echo "scale=3; $pcm_output_read * 1000 * 1000 * 1000 / 1024.0 / 1024.0 / 1024.0" | bc -l`
    pcm_output_write=`echo "scale=3; $pcm_output_write * 1000 * 1000 * 1000 / 1024.0 / 1024.0 / 1024.0" | bc -l`

    fio_output=`grep ' WRITE: bw' $write_dir/fio-output-$i.txt | awk '{print $2}'`
    echo $fio_output | grep "Mi" > /dev/null
    is_m=`echo $?`
    #Extract the number
    fio_output=`echo $fio_output | tr -dc '0-9.'`

    #convert to GiB/s
    if [ $is_m -eq 0 ]
    then
        fio_output=`echo "scale=3; $fio_output / 1024.0" | bc -l`
    fi

    echo $i $fio_output $pcm_output_read $pcm_output_write >> $output_dir/write.dat
done


for i in $read_config
do
    pcm_output_read=`cat $read_dir/pcm-$i.txt | grep '*' | awk 'NR % 3 == 0' | cut -f 1 | tr -s ' ' | cut -d ' ' -f 7`
    pcm_output_write=`cat $read_dir/pcm-$i.txt | grep '*' | awk 'NR % 3 == 0' | cut -f 1 | tr -s ' ' | cut -d ' ' -f 8`

    #get avg
    pcm_output_read=`echo "$pcm_output_read" | awk '{ total += $1; count++ } END { print total/count }'`
    pcm_output_write=`echo "$pcm_output_write" | awk '{ total += $1; count++ } END { print total/count }'`
    # convert from GB/s to GiB/s 
    pcm_output_read=`echo "scale=3; $pcm_output_read * 1000 * 1000 * 1000 / 1024.0 / 1024.0 / 1024.0" | bc -l`
    pcm_output_write=`echo "scale=3; $pcm_output_write * 1000 * 1000 * 1000 / 1024.0 / 1024.0 / 1024.0" | bc -l`

    fio_output=`grep ' READ: bw' $read_dir/fio-output-$i.txt | awk '{print $2}'`
    echo $fio_output | grep "Mi" > /dev/null
    is_m=`echo $?`
    #Extract the number
    fio_output=`echo $fio_output | tr -dc '0-9.'`

    #convert to GiB/s
    if [ $is_m -eq 0 ]
    then
        fio_output=`echo "scale=3; $fio_output / 1024.0" | bc -l`
    fi

    echo $i $fio_output $pcm_output_read $pcm_output_write >> $output_dir/read.dat
done




