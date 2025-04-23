#!/bin/bash

current_dir_name=$(basename "$PWD")
echo "Running tests for $current_dir_name"

flutter test --coverage --reporter json --coverage-path ../../.coverage/$current_dir_name/lcov.info
test_exit_code=$?
exit $test_exit_code
