#!/bin/bash

current_dir_name=$(basename "$PWD")

exec flutter test --coverage --reporter json --coverage-path ../../.coverage/$current_dir_name/lcov.info
