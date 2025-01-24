#!/bin/bash
mkdir pana || true
current_dir_name=$(basename "$PWD")
OUT=$(pana . -j -l 120)
echo "$OUT" > ../../pana/${current_dir_name}.json