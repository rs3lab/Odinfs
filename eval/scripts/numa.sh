#!/bin/bash

cd ../numa/
./run.sh
cd -

echo "Parsing NUMA results"
./parse-numa.sh
echo ""
