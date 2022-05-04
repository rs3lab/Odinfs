#!/bin/bash

sudo -v

if [ ! -f "../benchmark/fxmark/bin/cpupol.py" ]
then
    echo "Please compile fxmark!"
    exit 1
fi

if ! command -v pmwatch &> /dev/null 
then
    echo "Please install pmwatch"
    exit 1
fi

./gen.sh

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

