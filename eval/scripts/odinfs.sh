#!/bin/bash

source common.sh

$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='^fio_global_seq-read-4K$' \
    --ncore='*' --iotype='bufferedio' --dthread='12' --dsocket='2' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="fio" --log_name="odinfs-read-4k.log" --duration=10

$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='^fio_global_seq-read-2M$' \
    --ncore='*' --iotype='bufferedio' --dthread='12' --dsocket='2' \
    --rcore='False' --delegate='True' --confirm='True' \
    --directory_name="fio" --log_name="odinfs-read-2m.log" --duration=10

$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='^fio_global_seq-write-4K$|^fio_global_seq-write-2M$' \
    --ncore='*' --iotype='bufferedio' --dthread='12' --dsocket='2' \
    --rcore='False' --delegate='True' --confirm='True' \
    --directory_name="fio" --log_name="odinfs-write.log" --duration=30

$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='^odinfs$' \
    --workload='^DRBL$|^DRBM$|^DRBH$' \
    --ncore='*' --iotype='bufferedio' --dthread='12' --dsocket='2' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="fxmark" --log_name="odinfs-read.log" --duration=30

$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='^odinfs$' \
    --workload='^DWOL$|^DWOM$|^DWAL$' \
    --ncore='*' --iotype='bufferedio' --dthread='12' --dsocket='2' \
    --rcore='False' --delegate='True' --confirm='True' \
    --directory_name="fxmark" --log_name="odinfs-write.log" --duration=30

$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='filebench_*' \
    --ncore='*' --iotype='bufferedio' --dthread='12' --dsocket='2' \
    --rcore='False' --delegate='True' --confirm='True' \
    --directory_name="filebench" --log_name="odinfs.log" --duration=30
