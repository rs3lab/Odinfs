#!/bin/bash

source common.sh

$FXMARK_BIN_PATH/run-fxmark.py --media='pmem-local' \
    --fs='^ext4$|^pmfs$|^nova$|^winefs$' \
    --workload='^fio_global_seq-read-4K$|^fio_global_seq-read-2M$' \
    --ncore='*' --iotype='bufferedio' --dthread='0' --dsocket='0' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="fio" --log_name="fs-read.log" --duration=10

$FXMARK_BIN_PATH/run-fxmark.py --media='pmem-local' \
    --fs='^ext4$|^pmfs$|^nova$|^winefs$' \
    --workload='^fio_global_seq-write-4K$|^fio_global_seq-write-2M$' \
    --ncore='*' --iotype='bufferedio' --dthread='0' --dsocket='0' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="fio" --log_name="fs-write.log" --duration=30


$FXMARK_BIN_PATH/run-fxmark.py --media='^dm-stripe$' --fs='^ext4$' \
    --workload='^fio_global_seq-read-4K$|^fio_global_seq-read-2M$' \
    --ncore='*' --iotype='bufferedio' --dthread='0' --dsocket='2' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="fio" --log_name="ext4-raid0-read.log" --duration=10

$FXMARK_BIN_PATH/run-fxmark.py --media='^dm-stripe$' --fs='^ext4$' \
    --workload='^fio_global_seq-write-4K$|^fio_global_seq-write-2M$' \
    --ncore='*' --iotype='bufferedio' --dthread='0' --dsocket='2' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="fio" --log_name="ext4-raid0-write.log" --duration=30

$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='^fio_global_seq-read-4K$' \
    --ncore='*' --iotype='bufferedio' --dthread='20' --dsocket='2' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="fio" --log_name="odinfs-read-4k.log" --duration=10

$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='^fio_global_seq-read-2M$' \
    --ncore='*' --iotype='bufferedio' --dthread='20' --dsocket='2' \
    --rcore='False' --delegate='True' --confirm='True' \
    --directory_name="fio" --log_name="odinfs-read-2m.log" --duration=10

$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='^fio_global_seq-write-4K$|^fio_global_seq-write-2M$' \
    --ncore='*' --iotype='bufferedio' --dthread='20' --dsocket='2' \
    --rcore='False' --delegate='True' --confirm='True' \
    --directory_name="fio" --log_name="odinfs-write.log" --duration=30
