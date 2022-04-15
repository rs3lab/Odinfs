#!/bin/bash

sudo -v 
fs=(pmfs nova winefs odinfs)

for i in ${fs[@]}
do
    cd $i
    make clean && make -j
    sudo rmmod $i
    sudo insmod $i.ko
    sudo insmod build/$i.ko
    cd -
done

cd parradm
make clean && make -j
sudo make install
cd -

echo ""
echo "------------------------------------------------------------------"
echo "Checking"
for i in ${fs[@]}
do
    lsmod | grep $i > /dev/null
    if [ $? -eq 0 ]
    then
        echo $i installed successfully 
    else 
        echo $i *not* installed
        exit 1
    fi
done

echo ""

which parradm
ret=$?

if [ $ret -eq 0 ]
then
    echo "Parradm installed successfully!"

else
    echo "Parradm *not* installed"
    exit 1
fi

echo "All succeed!"
echo "------------------------------------------------------------------"
exit 0





