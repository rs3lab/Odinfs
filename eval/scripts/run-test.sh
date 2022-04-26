#!/bin/bash

# Please disable hyperthreading in BIOS before running any workload

# Please replace the --ncore="^56$" with the number of cores in the 
# experimental machine. For example, for a two-socket machine, where each 
# socket has 18 cores, replace --ncore="^56$" with --ncore="^36$"

source common.sh

$FXMARK_BIN_PATH/run-fxmark.py --media='pmem-local' \
    --fs='^ext4$|^pmfs$|^nova$|^winefs$' \
    --workload='^fio_global_seq-read-4K$|^fio_global_seq-read-2M$' \
    --ncore='^56$' --iotype='bufferedio' --dthread='0' --dsocket='0' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="test-fio" --log_name="fs-read.log" --duration=10

$FXMARK_BIN_PATH/run-fxmark.py --media='pmem-local' \
    --fs='^ext4$|^pmfs$|^nova$|^winefs$' \
    --workload='^fio_global_seq-write-4K$|^fio_global_seq-write-2M$' \
    --ncore='^56$' --iotype='bufferedio' --dthread='0' --dsocket='0' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="test-fio" --log_name="fs-write.log" --duration=30

$FXMARK_BIN_PATH/run-fxmark.py --media='^dm-stripe$' --fs='^ext4$' \
    --workload='^fio_global_seq-read-4K$|^fio_global_seq-read-2M$' \
    --ncore='^56$' --iotype='bufferedio' --dthread='0' --dsocket='2' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="test-fio" --log_name="ext4-raid0-read.log" --duration=10

$FXMARK_BIN_PATH/run-fxmark.py --media='^dm-stripe$' --fs='^ext4$' \
    --workload='^fio_global_seq-write-4K$|^fio_global_seq-write-2M$' \
    --ncore='^56$' --iotype='bufferedio' --dthread='0' --dsocket='2' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="test-fio" --log_name="ext4-raid0-write.log" --duration=30

$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='^fio_global_seq-read-4K$' \
    --ncore='^56$' --iotype='bufferedio' --dthread='12' --dsocket='2' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="test-fio" --log_name="odinfs-read-4k.log" --duration=10

$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='^fio_global_seq-read-2M$' \
    --ncore='^56$' --iotype='bufferedio' --dthread='12' --dsocket='2' \
    --rcore='False' --delegate='True' --confirm='True' \
    --directory_name="test-fio" --log_name="odinfs-read-2m.log" --duration=10

$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='^fio_global_seq-write-4K$|^fio_global_seq-write-2M$' \
    --ncore='^56$' --iotype='bufferedio' --dthread='12' --dsocket='2' \
    --rcore='False' --delegate='True' --confirm='True' \
    --directory_name="test-fio" --log_name="odinfs-write.log" --duration=30

$FXMARK_BIN_PATH/run-fxmark.py --media='pmem-local' \
    --fs='^ext4$|^pmfs$|^nova$|^winefs$' \
    --workload='^DRBL$|^DRBM$|^DRBH$|^DWOL$|^DWOM$|^DWAL$' \
    --ncore='^56$' --iotype='bufferedio' --dthread='0' --dsocket='2' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="test-fxmark" --log_name="fs.log" --duration=30

$FXMARK_BIN_PATH/run-fxmark.py --media='^dm-stripe$' --fs='^ext4$' \
    --workload='^DRBL$|^DRBM$|^DRBH$|^DWOL$|^DWOM$ |^DWAL$' \
    --ncore='^56$' --iotype='bufferedio' --dthread='0' --dsocket='2' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="test-fxmark" --log_name="ext-raid0.log" --duration=30

$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='^DRBL$|^DRBM$|^DRBH$' \
    --ncore='^56$' --iotype='bufferedio' --dthread='12' --dsocket='2' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="test-fxmark" --log_name="odinfs-read.log" --duration=30

$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='^DWOL$|^DWOM$|^DWAL$' \
    --ncore='^56$' --iotype='bufferedio' --dthread='12' --dsocket='2' \
    --rcore='False' --delegate='True' --confirm='True' \
    --directory_name="test-fxmark" --log_name="odinfs-write.log" --duration=30

$FXMARK_BIN_PATH/run-fxmark.py --media='pmem-local' \
    --fs='^ext4$|^pmfs$|^nova$' \
    --workload='filebench_*' \
    --ncore='^56$' --iotype='bufferedio' --dthread='0' --dsocket='0' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="test-filebench" --log_name="fs.log" --duration=30

$FXMARK_BIN_PATH/run-fxmark.py --media='^dm-stripe$' --fs='^ext4$' \
    --workload='filebench_*' \
    --ncore='^56$' --iotype='bufferedio' --dthread='0' --dsocket='2' \
    --rcore='False' --delegate='False' --confirm='True' \
   --directory_name="test-filebench" --log_name="ext4-raid0.log" --duration=30

$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='filebench_*' \
    --ncore='^56$' --iotype='bufferedio' --dthread='12' --dsocket='2' \
    --rcore='False' --delegate='True' --confirm='True' \
    --directory_name="test-filebench" --log_name="odinfs.log" --duration=30



./parse-test.sh


