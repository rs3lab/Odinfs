#!/bin/bash

source common.sh

DATA_PATH=../data/

echo "Parsing fio results"
for i in `ls $FXMARK_LOG_PATH/fio/`
do
    echo "On $i"
    $FXMARK_PARSER_PATH/pdata.py --log="$FXMARK_LOG_PATH/test-fio/$i" \
    --type='fio' --out="$DATA_PATH/test-fio"

    if [ $? -ne 0 ]
    then
        echo "Errors"
        exit 1
    fi
done
echo ""

echo "Parsing fxmark results"
for i in `ls $FXMARK_LOG_PATH/fxmark/`
do
    echo "On $i"
    $FXMARK_PARSER_PATH/pdata.py --log="$FXMARK_LOG_PATH/test-fxmark/$i" \
    --type='fxmark' --out="$DATA_PATH/test-fxmark"

    if [ $? -ne 0 ]
    then
        echo "Errors"
        exit 1
    fi

done
echo ""

echo "Parsing filebench results"
for i in `ls $FXMARK_LOG_PATH/filebench/`
do
    echo "On $i"
    $FXMARK_PARSER_PATH/pdata.py --log="$FXMARK_LOG_PATH/test-filebench/$i" \
    --type='filebench' --out="$DATA_PATH/test-filebench"

    if [ $? -ne 0 ]
    then
        echo "Errors"
        exit 1
    fi

done

echo "----------------------------------------------------------"
echo "Looks good! Please manually execute the following commands:"
echo "$ sudo modprobe msr"
echo "$ ulimit -n 10000"
echo "$ sudo pmwatch 1"
echo "$ sudo pcm"
echo "To ensure pmwatch and pcm can function correctly"
echo "----------------------------------------------------------"
