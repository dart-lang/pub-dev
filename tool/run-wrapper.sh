#!/bin/sh
# Wrapper script that runs a command and logs exit status to stderr,
# sleeping 10 seconds before exiting to allow log collection.

set -u

"$@"
EXIT_CODE=$?

if [ "$EXIT_CODE" -eq 0 ]; then
  echo "[pub-run-wrapper-exited]" >&2
else
  echo "[pub-run-wrapper-failed] (exit code $EXIT_CODE)." >&2
fi

sleep 10
exit "$EXIT_CODE"
