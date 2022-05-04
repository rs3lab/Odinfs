#!/bin/bash

rm -rf config*.fio
rm -rf config_odinfs/config*.fio
rm -rf common.sh

mkdir config_odinfs

cp -a ../benchmark/fxmark/bin/cpupol.py .
./gen.py
