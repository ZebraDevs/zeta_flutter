#!/bin/bash

array=()
while IFS= read -r -d '' dir; do
    array+=("$(basename "$dir")")
done < tmpfile

find .coverage -mindepth 1 -maxdepth 1 -type d -name 'z*' -print0 > tmpfile
com="lcov" 

for dir in "${array[@]}"; do
    if [ -f ".coverage/$dir/lcov.info" ]; then
    cp ".coverage/$dir/lcov.info" ".coverage/$dir/lcov_combined.info"
    sed -i '' "s|SF:|SF:packages/$dir/|" ".coverage/$dir/lcov_combined.info"
    com="$com -a .coverage/$dir/lcov_combined.info"
    fi
done

exec $com -o .coverage/lcov.info --ignore-errors empty