#!/bin/bash
rm -rf ../../pana
mkdir -p ../../pana
current_dir_name=$(basename "$PWD")
OUT=$(pana . -j)
echo "$OUT" > ../../pana/${current_dir_name}.json