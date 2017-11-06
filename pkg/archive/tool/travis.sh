#!/bin/bash

# Fast fail the script on failures.
set -e

# Analyze the code.
dartanalyzer --fatal-warnings \
  bin/tar.dart \
  example/decode_zip.dart \
  lib/archive.dart \
  test/archive_test.dart

# Run the tests.
dart -c test/archive_test.dart
