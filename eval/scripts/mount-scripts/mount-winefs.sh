#!/usr/bin/bash

sudo insmod /home/diyu/winefs/winefs.ko 
sudo mount -t winefs -o init /dev/pmem0 /mnt/pmem_emul/
sudo chown diyu:diyu /mnt/pmem_emul/
