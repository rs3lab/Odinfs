#!/bin/bash

rm -rf config/read/remote.fio config/read/local.fio

rm -rf config/write/remote.fio config/write/local.fio

cp -a ../benchmark/fxmark/bin/cpupol.py .
./gen.py
