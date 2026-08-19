#!/bin/bash

# Unlike $0, $BASH_SOURCE points to the absolute path of this file.
ROOT="$(dirname $(dirname $BASH_SOURCE))"
DIR="$ROOT/lib/src/grpc_api"

export PROTOBUF_DIR=tmp/protobuf-dir
export GOOGLEAPIS_DIR=tmp/googleapis-dir
mkdir -p $ROOT/tmp

function run {
  echo "Running $@"
  $@

  EXITCODE=$?
  if [ $EXITCODE -ne 0 ]; then
    echo "  -> Command failed with exitcode $EXITCODE. Aborting ..."
    exit $EXITCODE
  fi
}

# Clone the two repositories to tmp/ if they don't exist
[ ! -d "$PROTOBUF_DIR" ] && run git clone https://github.com/google/protobuf.git $PROTOBUF_DIR
[ ! -d "$GOOGLEAPIS_DIR" ] && run git clone https://github.com/googleapis/googleapis.git $GOOGLEAPIS_DIR

# Bring both repositories up to date
for repo in "$GOOGLEAPIS_DIR" "$PROTOBUF_DIR"; do
  FIRST_REMOTE=$(git -C "$repo" remote | grep origin || git remote | head -n 1)
  # https://stackoverflow.com/a/62397081
  DEFAULT_BRANCH=$(git -C "$repo" rev-parse --abbrev-ref $FIRST_REMOTE/HEAD)
  run git -C "$repo" fetch $FIRST_REMOTE
  run git -C "$repo" checkout $DEFAULT_BRANCH
  run git -C "$repo" reset --hard
done

# Get rid of all old proto files & fetch new ones from protobuf/googleapis
# repositories.
run rm -rf $DIR/protos
run mkdir -p $DIR/protos/google/protobuf
run cp $PROTOBUF_DIR/src/google/protobuf/*.proto $DIR/protos/google/protobuf
# Note we only use protos from some subfolders, so we copy those in here.
run cp -R $GOOGLEAPIS_DIR/google/appengine $DIR/protos/google
run cp -R $GOOGLEAPIS_DIR/google/datastore $DIR/protos/google
run cp -R $GOOGLEAPIS_DIR/google/logging $DIR/protos/google
run cp -R $GOOGLEAPIS_DIR/google/api $DIR/protos/google
run cp -R $GOOGLEAPIS_DIR/google/iam $DIR/protos/google
run cp -R $GOOGLEAPIS_DIR/google/rpc $DIR/protos/google
run cp -R $GOOGLEAPIS_DIR/google/type $DIR/protos/google
run cp -R $GOOGLEAPIS_DIR/google/longrunning $DIR/protos/google

# Generate the dart code.
run rm -rf $DIR/dart
run mkdir -p $DIR/dart

FILES=$(find $DIR/protos -name '*proto' | grep -v unittest | grep -v 'sample_messages_edition\.proto')
PROTOC_PLUGIN=tool/protoc-gen-dart

run protoc "-I$DIR/protos" "--dart_out=grpc:$DIR/dart" "$FILES" --plugin=$PROTOC_PLUGIN

dart format $DIR
