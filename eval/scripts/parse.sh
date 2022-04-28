#!/bin/bash

source common.sh


echo "Parsing fio results"
for i in `ls $FXMARK_LOG_PATH/fio/`
do
    echo "On $i"
    $FXMARK_PARSER_PATH/pdata.py --log="$FXMARK_LOG_PATH/fio/$i" \
    --type='fio' --out="$DATA_PATH/fio"
done
echo ""

echo "Parsing fxmark results"
for i in `ls $FXMARK_LOG_PATH/fxmark/`
do
    echo "On $i"
    $FXMARK_PARSER_PATH/pdata.py --log="$FXMARK_LOG_PATH/fxmark/$i" \
    --type='fxmark' --out="$DATA_PATH/fxmark"
done
echo ""

echo "Parsing filebench results"
for i in `ls $FXMARK_LOG_PATH/filebench/`
do
    echo "On $i"
    $FXMARK_PARSER_PATH/pdata.py --log="$FXMARK_LOG_PATH/filebench/$i" \
    --type='filebench' --out="$DATA_PATH/filebench"
done
echo ""

echo "Parsing fio results for odinfs with varying delegation threads"
for i in `ls $FXMARK_LOG_PATH/fio-vd/`
do
    echo "On $i"
    threads=`echo $i | cut -d '-' -f 3 | tr -dc '0-9'`
    $FXMARK_PARSER_PATH/pdata.py --log="$FXMARK_LOG_PATH/fio-vd/$i" \
    --type='fio' --out="$DATA_PATH/odinfs-$threads-threads"
done
echo ""


echo "Parsing fio results for odinfs with varying NUMA nodes"
for i in `ls $FXMARK_LOG_PATH/fio-vn/`
do
    echo "On $i"
    sockets=`echo $i | cut -d '-' -f 3 | tr -dc '0-9'`
    $FXMARK_PARSER_PATH/pdata.py --log="$FXMARK_LOG_PATH/fio-vn/$i" \
    --type='fio' --out="$DATA_PATH/odinfs-$sockets-sockets"
done
echo ""

echo "Parsing NUMA results"
./parse-numa.sh
echo ""

echo "Parsing amplification results"
./parse-ampl.sh


echo ""
echo "All done!"

