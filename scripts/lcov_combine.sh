#!/bin/bash

array=()
while IFS= read -r -d '' dir; do
    array+=("$(basename "$dir")")
done < tmpfile

echo "Combining coverage data for the following packages: ${array[@]}"

find .coverage -mindepth 1 -maxdepth 1 -type d -name 'z*' -print0 > tmpfile
com="lcov" 
for dir in "${array[@]}"; do
    if [ -f ".coverage/$dir/lcov.info" ]; then
    echo Combining $dir
    cp ".coverage/$dir/lcov.info" ".coverage/$dir/lcov_combined.info"
    sed -i '' "s|SF:|SF:packages/$dir/|" ".coverage/$dir/lcov_combined.info"
    com="$com -a .coverage/$dir/lcov_combined.info"
    fi
done

if [ "$(uname)" == "Linux" ]; then
    exec sudo apt -y install lcov
fi
 

exec $com -o .coverage/lcov.info --ignore-errors empty || true

echo "Combined coverage data is stored in .coverage/lcov.info"
echo cat .coverage/lcov.info
echo "Removing temporary files"

rm tmpfile