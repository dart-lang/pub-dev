#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo "Specify target URL as parameter. Example: "
    echo "  trace_curl.sh https://pub.dartlang.org/"
    exit 1
fi

tag=$(date -u +"%Y%m%da%H%M%S")
rnd=$(printf %017d $RANDOM)
tag=$tag$rnd
echo "Trace ID: $tag"

curl -v -H "X-Cloud-Trace-Context: $tag/0;o=1" "$@"

echo "Open URL:"
echo 'https://console.cloud.google.com/logs/viewer?project=dartlang-pub&advancedFilter=labels.%22appengine.googleapis.com/trace_id%22%3D%22'$tag"%22"
