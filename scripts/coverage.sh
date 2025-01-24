#!/bin/bash

# Check if lcov is installed
if ! command -v lcov &> /dev/null
then
    echo "lcov could not be found, please install it first."
    exit
fi

# Run the tests with coverage
flutter test --coverage --coverage-path .coverage/

# Generate the LCOV report
lcov --capture --directory .coverage --output-file coverage/lcov.info

# Remove unnecessary files from the report
lcov --remove .coverage/lcov.info 'lib/*/*.g.dart' 'lib/*/*.freezed.dart' -o coverage/lcov.info

# Generate the HTML report
genhtml .coverage/lcov.info --output-directory .coverage/html

# Open the coverage report in the default browser
if [ "$(uname)" == "Darwin" ]; then
    open coverage/html/index.html
elif [ "$(uname)" == "Linux" ]; then
    xdg-open coverage/html/index.html
elif [ "$(uname)" == "CYGWIN" ] || [ "$(uname)" == "MINGW32" ] || [ "$(uname)" == "MINGW64" ]; then
    start coverage/html/index.html
fi

echo "Coverage report generated and opened in the default browser."
