echo "Day $1"
echo "Running part $2:"
if [ -z "$3" ]; then
    python3 load-input.py $1
fi
OLLOC=$(pwd)
echo $OLLOC
cd ./day$1/
if [ $(pwd) != $OLLOC ]; then
    bash ./run.sh $2
else
    exit 1
fi
cd ..
echo ""
echo "Done!"