sudo -v
./autogen.sh
./configure
make 
sudo make -j install 

which pmwatch 
ret=$?

echo ""
echo ""
if [ $ret -eq 0 ]
then
    echo "----------------------------------------------------------------"
    echo "Pmwatch installed successfully!"
    echo "----------------------------------------------------------------"
    exit 0

else
    echo "----------------------------------------------------------------"
    echo "Pmwatch *not* installed"
    echo "----------------------------------------------------------------"
    exit 1
fi
