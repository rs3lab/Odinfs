#!/bin/bash

source common.sh

$FXMARK_BIN_PATH/run-fxmark.py --media='pmem-local' \
    --fs='^ext4$|^pmfs$|^nova$|^winefs$' \
    --workload='^DRBL$|^DRBM$|^DRBH$|^DWOL$|^DWOM$|^DWAL$' \
    --ncore='*' --iotype='bufferedio' --dthread='0' --dsocket='2' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="fxmark" --log_name="fs.log" --duration=30

$FXMARK_BIN_PATH/run-fxmark.py --media='^dm-stripe$' --fs='^ext4$' \
    --workload='^DRBL$|^DRBM$|^DRBH$|^DWOL$|^DWOM$ |^DWAL$' \
    --ncore='*' --iotype='bufferedio' --dthread='0' --dsocket='2' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="fxmark" --log_name="ext-raid0.log" --duration=30

$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='^DRBL$|^DRBM$|^DRBH$' \
    --ncore='*' --iotype='bufferedio' --dthread='12' --dsocket='2' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="fxmark" --log_name="odinfs-read.log" --duration=30

$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='^DWOL$|^DWOM$|^DWAL$' \
    --ncore='*' --iotype='bufferedio' --dthread='12' --dsocket='2' \
    --rcore='False' --delegate='True' --confirm='True' \
    --directory_name="fxmark" --log_name="odinfs-write.log" --duration=30



