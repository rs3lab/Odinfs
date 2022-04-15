#!/usr/bin/bash

sudo mount -t NOVA -o init /dev/pmem0 /mnt/pmem_emul/
sudo chown $USER /mnt/pmem_emul/
