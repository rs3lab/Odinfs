#!/bin/bash

source common.sh

for i in 4 8 14 20 
do
    $FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='^fio_global_seq-read-4K$' \
    --ncore='*' --iotype='bufferedio' --dthread="$i" --dsocket='2' \
    --rcore='False' --delegate='False' --confirm='True' \
    --directory_name="fio-vd" --log_name="odinfs-read-$i-4k.log" --duration=10

    $FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='^fio_global_seq-read-2M$' \
    --ncore='*' --iotype='bufferedio' --dthread="$i" --dsocket='2' \
    --rcore='False' --delegate='True' --confirm='True' \
    --directory_name="fio-vd" --log_name="odinfs-read-$i-2m.log" --duration=10

    $FXMARK_BIN_PATH/run-fxmark.py --media='pm-array' --fs='odinfs' \
    --workload='^fio_global_seq-write-4K$|^fio_global_seq-write-2M$' \
    --ncore='*' --iotype='bufferedio' --dthread="$i" --dsocket='2' \
    --rcore='False' --delegate='True' --confirm='True' \
    --directory_name="fio-vd" --log_name="odinfs-write-$i.log" --duration=30

done

echo "Parsing fio results for odinfs with varying delegation threads"
for i in `ls $FXMARK_LOG_PATH/fio-vd/`
do
    echo "On $i"
    threads=`echo $i | cut -d '-' -f 3 | tr -dc '0-9'`
    $FXMARK_PARSER_PATH/pdata.py --log="$FXMARK_LOG_PATH/fio-vd/$i" \
    --type='fio' --out="$DATA_PATH/odinfs-$threads-threads"
done
echo ""
