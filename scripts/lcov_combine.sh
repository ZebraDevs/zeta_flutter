#!/bin/bash

echo 'Removing old coverage data'
rm .coverage/lcov.info || true

if ! command -v lcov &> /dev/null
then
    echo "lcov could not be found, please install it first."
    exit
fi
 

array=()
while IFS= read -r -d '' dir; do
    array+=("$(basename "$dir")")
done < tmpfile

echo "Combining coverage data for the following packages: ${array[@]}"

find .coverage -mindepth 1 -maxdepth 1 -type d -name 'z*' -print0 > tmpfile
com="lcov" 
for dir in "${array[@]}"; do
    if [ -f ".coverage/$dir/lcov.info" ]; then
    echo "Fixing file  $dir"
    cp ".coverage/$dir/lcov.info" ".coverage/$dir/lcov_combined.info"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s|SF:|SF:packages/$dir/|" ".coverage/$dir/lcov_combined.info"
    else
        sed -i "s|SF:|SF:packages/$dir/|" ".coverage/$dir/lcov_combined.info"
    fi
    com="$com -a .coverage/$dir/lcov_combined.info"
    fi
done

echo 'Done fixing file paths'

echo "Listing all files in .coverage directory:"
find .coverage -type f


echo 'Combining coverage data'
exec $com -o .coverage/lcov.info --ignore-errors empty || true

echo "Combined coverage data is stored in .coverage/lcov.info"
echo cat .coverage/lcov.info
echo "Removing temporary files"

rm tmpfile