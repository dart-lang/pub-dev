#!/bin/bash

REPO_ROOT=$( cd $(dirname $(dirname "${BASH_SOURCE[0]}" )) && pwd )

# Source utility functions
source "$REPO_ROOT/tool/utils.sh"

# Check that the necessary environment variables are set.
check_env_variable "DART_SDK"

# You must have gcloud tools installed
#   https://cloud.google.com/sdk/gcloud/
# Running `gcloud info` will display the Installation Root
#   e.g. /Users/alice/google-cloud-sdk
# The API server – api_server.py – should be at
# [Installation Root]/platform/google_appengine/api_server.py
check_env_variable "APPENGINE_API_SERVER"

export PATH="$PATH:$DART_SDK/bin"
export RETURN_VALUE=0

start_phase "Analyzing"
analyze_files $(find $REPO_ROOT/lib -name "*.dart")
RETURN_VALUE=$(expr $RETURN_VALUE + $?)

analyze_files $(find $REPO_ROOT/test -name '*.dart')
RETURN_VALUE=$(expr $RETURN_VALUE + $?)

start_phase "Starting API server"
"$APPENGINE_API_SERVER" -A 'dev~test-application' \
  --api_port 4444 --high_replication &
API_SERVER_PID=$!
sleep 3


start_phase "Testing"
pub run test
RETURN_VALUE=$(expr $RETURN_VALUE + $?)

start_phase "Killing API server"
kill $API_SERVER_PID &> /dev/null


# Wait until background jobs are done.
wait
echo
echo

test $RETURN_VALUE -ne 0 && exit 1
exit 0
