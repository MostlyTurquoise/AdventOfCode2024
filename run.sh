#!/bin/sh
echo "Day $1"
echo "Running part $2:"
cd ./day$1/
bash ./run.sh $2
cd ..
echo ""
echo "Done!"