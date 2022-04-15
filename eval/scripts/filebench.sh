#!/bin/bash

source common.sh

$FXMARK_BIN_PATH/run-fxmark.py --media='pmem-local' \
    --fs='^ext4$|^pmfs$|^nova$|^winefs$' \
    --workload='filebench_*' \
    --ncore='*' --iotype='bufferedio' --dthread='0' --dsocket='0' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="filebench" --log_name="fs.log" --duration=30

$FXMARK_BIN_PATH/run-fxmark.py --media='^dm-stripe$' --fs='^ext4$' \
    --workload='filebench_*' \
    --ncore='*' --iotype='bufferedio' --dthread='0' --dsocket='2' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="filebench" --log_name="ext4-raid0.log" --duration=30

$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='filebench_*' \
    --ncore='*' --iotype='bufferedio' --dthread='12' --dsocket='2' \
    --rcore='False' --delegate='True' --confirm='True' \
    --directory_name="filebench" --log_name="odinfs.log" --duration=30
