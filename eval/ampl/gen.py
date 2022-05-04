#!/usr/bin/env python3

import cpupol
import os

methods = ["read", "write"]

CUR_DIR = os.path.abspath(os.path.dirname(__file__))
ODINFS_DIR = os.path.join(CUR_DIR, "config_odinfs")
DELEGATION_THREADS=12

def get_ncores():

    ncores = []
    for socket in range(1, cpupol.PHYSICAL_CHIPS + 1):
        if socket == 1:
            n = 0
            while (2 ** n) < cpupol.CORE_PER_CHIP:
                ncores.append((2 ** n))
                n += 1
            ncores.append(socket * (cpupol.CORE_PER_CHIP))
        else:
            ncores.append(socket * (cpupol.CORE_PER_CHIP))

    ncores.sort()
    return ncores

def gen_odinfs_cpus_allowed():
    ret="cpus_allowed="
    for i in range(1, cpupol.PHYSICAL_CHIPS + 1):
        start = cpupol.CORE_PER_CHIP * (i - 1) + DELEGATION_THREADS 
        end = cpupol.CORE_PER_CHIP * i - 1
        # leave one CPU for pmwatch
        if i == cpupol.PHYSICAL_CHIPS + 1:
            end -= 1

        if i != 1:
            ret +=','
        ret += '%d-%d' % (start, end)
    return (ret + "\n")
        

def gen_config_py(ncores, odinfs):
    tcore = cpupol.PHYSICAL_CHIPS * cpupol.CORE_PER_CHIP

    for i in ncores: 
        for j in methods:
            file_path = "config-2m-%s-%s.fio" % (j[0], i) 
            if odinfs:
                file_path = os.path.join(ODINFS_DIR, file_path)
                
            f = open(file_path, "w")
            f.write("[global]\n")
            f.write("include common.fio\n\n")
            f.write("[seq-%s-2m]\n" % j)
            if odinfs:
                f.write(gen_odinfs_cpus_allowed())
            else:
                # leave one CPU for pmwatch
                f.write("cpus_allowed=0-%d\n" % (tcore - 1))

            f.write("numjobs=%d\n" % i)
            f.write("rw=%s\n" % j)
            f.write("stonewall\n")
            f.close()


if __name__ == "__main__":

    ncores = get_ncores()

    cores_str = 'cores=(' 
    for i in ncores:
        cores_str += str(i) 
        if i != ncores[-1]:
            cores_str += ' '

    cores_str += ')'

    
    f = open("common.sh", "w")
    f.write('sudo -v\n')
    f.write(cores_str)
    f.close()

    gen_config_py(ncores, False)
    gen_config_py(ncores, True)

        


    

