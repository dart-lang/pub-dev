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

function test_file {
  echo "Testing file '$1'."
  "$DART_SDK/bin/dart" --checked "$1"
  if [ $? -ne 0 ]; then
    cd ..
    error "Running tests in '$1' failed."
    return 1
  fi
  cd ..
  return 0
}

