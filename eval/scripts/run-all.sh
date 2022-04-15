#!/bin/bash

sudo -v

./fio.sh 
./fxmark.sh 
./filebench.sh 
./fio-odinfs-vd.sh 
./fio-odinfs-vn.sh 
./numa.sh
./ampl.sh
