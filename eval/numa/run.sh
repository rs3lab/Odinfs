#!/bin/bash
script_dir=../scripts/mount-scripts/

sudo -v 

./gen.sh

mkdir -p /mnt/pmem_emul/

fs=(pmfs)

#need for pcm
sudo modprobe msr
ulimit -n 10000

for i in ${fs[@]}
do
    $script_dir/mount-$i.sh
    ./run-write.sh
    $script_dir/umount-$i.sh

    $script_dir/mount-$i.sh
    ./run-read.sh
    $script_dir/umount-$i.sh
done


