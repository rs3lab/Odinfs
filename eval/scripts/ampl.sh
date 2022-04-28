#!/bin/bash

cd ../ampl/
./run.sh
cd -

echo "Parsing amplification results"
./parse-ampl.sh

