#!/bin/bash

source common.sh


$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='^filebench_varmail$' \
    --ncore="^$MAX_CPUS$" --iotype='bufferedio' --dthread='12' --dsocket='2' \
    --rcore='False' --delegate='True' --confirm='True' \
    --directory_name="test-filebench-odinfs" --log_name="varmail.log" --duration=30

$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='^filebench_fileserver$' \
    --ncore="^$MAX_CPUS$" --iotype='bufferedio' --dthread='12' --dsocket='2' \
    --rcore='False' --delegate='True' --confirm='True' \
    --directory_name="test-filebench-odinfs" --log_name="fileserver.log" --duration=30

$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='^filebench_videoserver$' \
    --ncore="^$MAX_CPUS$" --iotype='bufferedio' --dthread='12' --dsocket='2' \
    --rcore='False' --delegate='True' --confirm='True' \
    --directory_name="test-filebench-odinfs" --log_name="videoserver.log" --duration=30


$FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='^filebench_webserver$' \
    --ncore="^$MAX_CPUS$" --iotype='bufferedio' --dthread='12' --dsocket='2' \
    --rcore='False' --delegate='True' --confirm='True' \
    --directory_name="test-filebench-odinfs" --log_name="webserver.log" --duration=30






