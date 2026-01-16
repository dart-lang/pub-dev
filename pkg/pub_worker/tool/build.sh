#!/bin/bash

set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )


OUT="$DIR/../build";
SRC="$DIR/..";

rm -rf "$OUT"
mkdir -p "$OUT"

dart compile exe -o "$OUT/pub_worker" "$SRC/bin/pub_worker.dart"
