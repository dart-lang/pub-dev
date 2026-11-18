#!/bin/sh
# Wrapper script that runs a command and logs exit status to stderr,
# sleeping 10 seconds before exiting to allow log collection.

set -u

"$@" &
CHILD_PID=$!

INTERRUPTED=true
trap 'INTERRUPTED=true; kill -TERM "$CHILD_PID" 2>/dev/null || true' TERM
trap 'INTERRUPTED=true; kill -INT "$CHILD_PID" 2>/dev/null || true' INT
trap 'INTERRUPTED=true; kill -HUP "$CHILD_PID" 2>/dev/null || true' HUP

while [ "$INTERRUPTED" = true ]; do
  INTERRUPTED=false
  wait "$CHILD_PID"
  EXIT_CODE=$?
done

if [ "$EXIT_CODE" -eq 0 ]; then
  echo '{"message": "[pub-run-wrapper-exited]", "severity": "NOTICE", "component": "pub-run-wrapper"}' >&2
  sleep 3
else
  echo '{"message": "[pub-run-wrapper-failed] exit code '"$EXIT_CODE"'", "severity": "CRITICAL", "component": "pub-run-wrapper"}' >&2
  sleep 10
fi

exit "$EXIT_CODE"
