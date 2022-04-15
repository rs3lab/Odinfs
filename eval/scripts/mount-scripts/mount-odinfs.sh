#!/usr/bin/bash

#Two sockets
sudo /home/diyu/spmfs/src/utils/parradm/parradm create /dev/pmem0 /dev/pmem1

#Four sockets
#sudo /home/diyu/spmfs/src/utils/parradm/parradm create /dev/pmem0 /dev/pmem1 /dev/pmem2 /dev/pmem3 

#Eight sockets
#sudo /home/diyu/spmfs/src/utils/parradm/parradm create /dev/pmem0 /dev/pmem1 /dev/pmem2 /dev/pmem3 /dev/pmem4 /dev/pmem5 /dev/pmem6 /dev/pmem7

sudo mount -t odinfs -o init,dele_thrds=12 /dev/pmem_ar0 /mnt/pmem_emul/
sudo chown $USER /mnt/pmem_emul/
