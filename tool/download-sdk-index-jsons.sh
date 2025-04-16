#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "$SCRIPT_DIR/../app/"
mkdir -p .dart_tool/pub-search-data
cd .dart_tool/pub-search-data

echo "Downloading Dart SDK index.json"
curl -o https-api.dart.dev-stable-latest-index.json https://api.dart.dev/stable/latest/index.json

echo "Downloading Flutter SDK index.json"
curl -o https-api.flutter.dev-flutter-index.json https://api.flutter.dev/flutter/index.json
