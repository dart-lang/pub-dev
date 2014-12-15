#!/bin/bash

function start_phase {
  echo "==============================================="
  echo "= Phase: $1"
  echo "==============================================="
}

function error {
  echo "==============================================="
  echo "= Error: $1"
  echo "==============================================="
}

function die {
  echo "$1"
  exit 1
}

function check_env_variable {
  NAME="$1"
  env | grep "$NAME" &> /dev/null
  if [ $? -ne 0 ]; then
    die "Couldn't find environment variable '$NAME'!"
  fi
}

function analyze_file {
  echo "Analyzing file '$1'."
  # Hack because dartanalyzer doesn't look into packages/ directory next to
  # entry point (if pacakges are nested).
  PACKAGE_ROOT="$(dirname $1)/packages"

  "$DART_SDK/bin/dartanalyzer" "--package-root=$PACKAGE_ROOT" --fatal-warnings "$1"
  if [ $? -ne 0 ]; then
    error "Analyzer failed on file '$1'."
    return 1
  fi
  return 0
}

function test_file {
  echo "Testing file '$1'."
  "$DART_SDK/bin/dart" --checked "$@"
  if [ $? -ne 0 ]; then
    error "Running tests in '$1' failed."
    return 1
  fi
  return 0
}

