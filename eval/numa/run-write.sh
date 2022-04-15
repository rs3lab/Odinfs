#!/bin/bash

config_dir=./config/write
config="all-local pm-local pm-remote"

echo "init"
fio $config_dir/config-2m-all-local.fio > /dev/null
echo "init done"

log_dir=./write-log/
mkdir $log_dir

for i in $config
do
    echo start $i
    sudo pcm 1> $log_dir/pcm-$i.txt &

    fio $config_dir/config-2m-$i.fio > $log_dir/fio-output-$i.txt

    sudo pkill -f "pcm"
    echo end $i
done


