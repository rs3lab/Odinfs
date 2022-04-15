#!/usr/bin/bash

sudo mkfs.ext4 -F /dev/pmem0
sudo mount -o dax /dev/pmem0 /mnt/pmem_emul/
sudo chown $USER /mnt/pmem_emul/
