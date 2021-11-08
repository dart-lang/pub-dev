#!/usr/bin/env bash

set -e

if [[ -z "$1" ]];
then
  echo "Target directory argument is missing."
  exit 1
fi

if [[ -z "$2" ]];
then
  echo "URL argument is missing."
  exit 1
fi

mkdir -p "$1"
cd "$1"
curl -sS "$2" >dartsdk.zip
unzip -q dartsdk.zip
rm -f dartsdk.zip
