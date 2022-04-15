#!/bin/bash

sudo -v

script_dir=../scripts/mount-scripts/
sudo mkdir -p /mnt/pmem_emul


fs=(ext4 pmfs nova winefs odinfs)

for i in ${fs[@]}
do
    $script_dir/mount-$i.sh
    ./run-fio-read.sh $i 2m
    $script_dir/umount-$i.sh

   $script_dir/mount-$i.sh
    ./run-fio-write.sh $i 2m
    $script_dir/umount-$i.sh
done

