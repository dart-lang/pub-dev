#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "$SCRIPT_DIR/.."

build() {
  pushd "$1"
  dart run build_runner build --delete-conflicting-outputs
  popd  
}

build pkg/api_builder
build pkg/pub_dartdoc_data
build pkg/pub_worker
build pkg/_pub_shared
build app

cp app/lib/frontend/handlers/pubapi.client.dart pkg/_pub_shared/lib/src/pubapi.client.dart
