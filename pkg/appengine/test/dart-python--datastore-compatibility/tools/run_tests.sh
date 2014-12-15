#!/bin/bash

REPO_ROOT=$( cd $(dirname $(dirname "${BASH_SOURCE[0]}" )) && pwd )

# Source utility functions
source "$REPO_ROOT/tools/utils.sh"

# Check that the necessary environment variables are set.
check_env_variable "DART_SDK"
check_env_variable "APPENGINE_DEVAPPSERVER"
check_env_variable "APPENGINE_API_SERVER"

export PY_BOOTSTRAP_APP="$REPO_ROOT/python/bootstrap.py"
export PATH="$PATH:$DART_SDK/bin"
export RETURN_VALUE=0


start_phase "Analyzing"
analyze_file "$REPO_ROOT/dart/bin/main.dart"
RETURN_VALUE=$(expr $RETURN_VALUE + $?)


##############################################################
# Phase 1: Python => Dart
##############################################################

start_phase "Testing Python => Dart"

"$APPENGINE_API_SERVER" -A 'dev~test-application' \
  --api_port 4444 --high_replication &
API_SERVER_PID=$!
sleep 3



"$PY_BOOTSTRAP_APP" "write"
RETURN_VALUE=$(expr $RETURN_VALUE + $?)


test_file "$REPO_ROOT/dart/bin/main.dart" "read"
RETURN_VALUE=$(expr $RETURN_VALUE + $?)


kill $API_SERVER_PID &> /dev/null


# Wait until background jobs are done.
wait
echo
echo
echo


##############################################################
# Phase 2: Python => Python
##############################################################

start_phase "Testing Python => Python"

"$APPENGINE_API_SERVER" -A 'dev~test-application' \
  --api_port 4444 --high_replication &
API_SERVER_PID=$!
sleep 3


"$PY_BOOTSTRAP_APP" "write"
RETURN_VALUE=$(expr $RETURN_VALUE + $?)


"$PY_BOOTSTRAP_APP" "read"
RETURN_VALUE=$(expr $RETURN_VALUE + $?)


kill $API_SERVER_PID &> /dev/null


# Wait until background jobs are done.
wait
echo
echo
echo

##############################################################
# Phase 3: Dart => Python
##############################################################

start_phase "Testing Dart => Python"

"$APPENGINE_API_SERVER" -A 'dev~test-application' \
  --api_port 4444 --high_replication &
API_SERVER_PID=$!
sleep 3


test_file "$REPO_ROOT/dart/bin/main.dart" "write"
RETURN_VALUE=$(expr $RETURN_VALUE + $?)


"$PY_BOOTSTRAP_APP" "read"
RETURN_VALUE=$(expr $RETURN_VALUE + $?)


kill $API_SERVER_PID &> /dev/null


# Wait until background jobs are done.
wait
echo
echo
echo


##############################################################
# Phase 4: Dart => Dart
##############################################################

start_phase "Testing Dart => Dart"

"$APPENGINE_API_SERVER" -A 'dev~test-application' \
  --api_port 4444 --high_replication &
API_SERVER_PID=$!
sleep 3


test_file "$REPO_ROOT/dart/bin/main.dart" "write"
RETURN_VALUE=$(expr $RETURN_VALUE + $?)


test_file "$REPO_ROOT/dart/bin/main.dart" "read"
RETURN_VALUE=$(expr $RETURN_VALUE + $?)


kill $API_SERVER_PID &> /dev/null


# Wait until background jobs are done.
wait
echo
echo
echo

exit $RETURN_VALUE
