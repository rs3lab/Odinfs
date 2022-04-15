#!/bin/bash

config_dir=./config/read/
config="all-local pm-local pm-remote"

echo "init"
fio $config_dir/config-2m-all-local.fio > /dev/null
echo "init done"

log_dir=./read-log/
mkdir $log_dir

for i in $config
do
    echo start $i
    sudo pcm 1> $log_dir/pcm-$i.txt &

    fio $config_dir/config-2m-$i.fio > $log_dir/fio-output-$i.txt

    sudo pkill -f "pcm"
    echo end $i
done

echo "init 2nd"
fio $config_dir/config-2m-pm-remote.fio > /dev/null
echo "init done"

echo start remote-2nd

sudo pcm 1> $log_dir/pcm-pm-remote-2nd.txt &

fio $config_dir/config-2m-pm-remote.fio > $log_dir/fio-output-pm-remote-2nd.txt

sudo pkill -f "pcm"
echo end remote-2nd

