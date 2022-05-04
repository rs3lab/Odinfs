#!/usr/bin/env python3

import cpupol
import os

methods = ["read", "write"]

CUR_DIR = os.path.abspath(os.path.dirname(__file__))
READ_DIR = os.path.join(CUR_DIR, "config", "read")
WRITE_DIR = os.path.join(CUR_DIR, "config", "write")

READ_THREADS=cpupol.CORE_PER_CHIP
WRITE_THREADS=8

if __name__ == "__main__":


    local_cpus = "cpus_allowed=0-%d\n" % (cpupol.CORE_PER_CHIP - 1)
    remote_cpus = "cpus_allowed=%d-%d\n" % (cpupol.CORE_PER_CHIP, cpupol.CORE_PER_CHIP * 2 - 1)

    f = open(os.path.join(READ_DIR, "local.fio"), "w")
    f.write("numjobs=%d\n" % READ_THREADS)
    f.write(local_cpus)
    f.close()

    f = open(os.path.join(READ_DIR, "remote.fio"), "w")
    f.write("numjobs=%d\n" % READ_THREADS)
    f.write(remote_cpus)
    f.close()

    f = open(os.path.join(WRITE_DIR, "local.fio"), "w")
    f.write("numjobs=%d\n" % WRITE_THREADS)
    f.write(local_cpus)
    f.close()

    f = open(os.path.join(WRITE_DIR, "remote.fio"), "w")
    f.write("numjobs=%d\n" % WRITE_THREADS)
    f.write(remote_cpus)
    f.close()




        


    

