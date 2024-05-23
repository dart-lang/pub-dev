#!/bin/bash
set -e

# Find location of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Download everything into $ROOT/task-logs/
ROOT="$DIR/.."
export ROOT

# Show usage
if [ $# -ne 0 ]; then
  echo 'Usage: ./fetch-task-logs.sh'
  echo 'Will download all task-logs into:'
  echo "  $ROOT/task-logs/"
  echo 'And print list of missing logs to:'
  echo "  $ROOT/missing-task-logs.txt"
  echo ''
  echo 'Use PUB_HOSTED_URL to specify a different server'
  exit 1;
fi

# Find the pub server
PUB_HOSTED_URL='https://jonasfj-dot-dartlang-pub-dev.appspot.com'
if [ -z "$VAR" ]; then
  PUB_HOSTED_URL='https://pub.dev'
fi
export PUB_HOSTED_URL

fetch_package_names() { 
  curl --retry 5 -Ls --compressed "$PUB_HOSTED_URL/api/package-names" | jq -r '.packages[]'
}

latest_version() {
  curl --retry 5 -Ls "$PUB_HOSTED_URL/api/packages/$1" | jq -r '.latest.version'
}
export -f latest_version

fetch_task_log() {
  curl --retry 5 --fail -Ls "$PUB_HOSTED_URL/experimental/task-log/$1/$2/"
}
export -f fetch_task_log

download_log() {
  P="$1"
  V=$(latest_version "$P")
  if ! fetch_task_log "$P" "$V" > "$ROOT/task-logs/$P-$V.log"; then
    rm "$ROOT/task-logs/$P-$V.log"
    echo "$P $V" >> "$ROOT/missing-task-logs.txt";
  fi
}
export -f download_log


rm -rf "$ROOT/task-logs"
rm -f "$ROOT/missing-task-logs.txt"
mkdir -p "$ROOT/task-logs"

fetch_package_names | parallel -j 50 --bar download_log
