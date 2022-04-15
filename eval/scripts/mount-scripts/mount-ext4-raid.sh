#!/bin/bash

set -euxo pipefail

# Two sockets
declare -a nodes=(0 1)

# Four sockets
#declare -a nodes=(0 1 2 3)

# Eight sockets
#declare -a nodes=(0 1 2 3 4 5 6 7)

stripes="${#nodes[@]}"
chunk_size="4096"
strip_length=0
devices=""

for i in "${nodes[@]}"; do
	size=$(sudo blockdev --getsz /dev/pmem"$i")
	strip_length=$((strip_length+size))
	devices+="/dev/pmem$i 0 "
done

# config format: start length striped #stripes chunk_size device1 offset1 ... deviceN offsetN
strip_config="0 $strip_length striped $stripes $chunk_size $devices"
echo "$strip_config" | sudo dmsetup create striped-pmem

sudo mkfs.ext4 -F /dev/mapper/striped-pmem
sudo mount -o dax /dev/mapper/striped-pmem /mnt/pmem_emul/
sudo chown $USER /mnt/pmem_emul/


