#!/bin/bash

# save first input arg as package
package=$1

# check that package is not 'zeta_flutter'
if [ "$package" = "zeta_flutter" ]; then
    pubspec="packages/zeta_flutter/pubspec.yaml"
    version=$(grep "^version:" "$pubspec" | sed 's/version: //' | tr -d '[:space:]')

    # filesToChange=($(jq -r '.["extra-files"][]' "./release-please-config.json"))
    readarray -t filesToChange < <(jq -r '.["extra-files"][]' "./release-please-config.json")

    for file in "${filesToChange[@]}"; do
        echo "Updating version in $file"
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS uses BSD sed
            sed -i '' -E "s/v[0-9.]+/v$version/g" "$file"
        else
            # Linux uses GNU sed
            sed -i -E "s/v[0-9.]+/v$version/g" "$file"
        fi
    done

    exit 0
fi

# Get the version from packages/$packagse/pubspec.yaml
package_pubspec="packages/$package/pubspec.yaml"
if [ ! -f "$package_pubspec" ]; then
    echo "Package pubspec file not found at $package_pubspec"
    exit 1
fi

# Extract the version from the pubspec.yaml file
version=$(grep "^version:" "$package_pubspec" | sed 's/version: //' | tr -d '[:space:]')
if [ -z "$version" ]; then
    echo "Could not find version in $package_pubspec"
    exit 1
fi

echo "Found version $version for package $package"

# load packages/zeta_flutter/pubspec.yaml file
file_path="packages/zeta_flutter/pubspec.yaml"

# update the line that starts with $package, change the version to $version
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS uses BSD sed which requires a different syntax
    sed -i '' "s/\($package: \).*$/\1^$version/g" "$file_path"
else
    # Linux uses GNU sed
    sed -i "s/\($package: \).*$/\1^$version/g" "$file_path"
fi

echo "Updated $package to version ^$version in pubspec.yaml"
