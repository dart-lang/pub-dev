#!/bin/bash

# Unlike $0, $BASH_SOURCE points to the absolute path of this file.
DIR="$(dirname $BASH_SOURCE)"

export PROTOBUF_DIR=/tmp/protobuf-dir
export GOOGLEAPIS_DIR=/tmp/googleapis-dir

# Do a quick validation that we have the protoc plugin in PATH.
PROTOC_PLUGIN=$(which protoc-gen-dart)
if [ ! -f "$PROTOC_PLUGIN" ]; then
  echo -en "Could not find Dart plugin for protoc! \nMake sure \$PATH includes "
  echo     "the protoc compiler plugin for Dart (named \"protoc-gen-dart\")!"
  exit 1
fi

function run {
  echo "Running $@"
  $@

  EXITCODE=$?
  if [ $EXITCODE -ne 0 ]; then
    echo "  -> Command failed with exitcode $EXITCODE. Aborting ..."
    exit $EXITCODE
  fi
}

# Clone the two repositories to /tmp
run rm -rf $PROTOBUF_DIR
run git clone https://github.com/google/protobuf.git $PROTOBUF_DIR
run rm -rf $GOOGLEAPIS_DIR
run git clone https://github.com/google/googleapis.git $GOOGLEAPIS_DIR

# Get rid of all old proto files & fetch new ones from protobuf/googleapis
# repositories.
run rm -rf $DIR/protos
run mkdir -p $DIR/protos/google/protobuf
run cp $PROTOBUF_DIR/src/google/protobuf/*.proto $DIR/protos/google/protobuf
run cp -R $GOOGLEAPIS_DIR/google/* $DIR/protos/google

# Generate the dart code.
run rm -rf $
run mkdir -p $DIR/dart
for file in $(find protos -name '*proto' | grep -v unittest); do
  echo -e "\nCompiling $file"
  run protoc -I$DIR/protos --dart_out=$DIR/dart $file
  echo
done

run rm -rf $PROTOBUF_DIR
run rm -rf $GOOGLEAPIS_DIR
