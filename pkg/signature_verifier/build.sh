#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

CGO_ENABLED=0 go build \
  -ldflags="-w -s" \
  -o ./signature_verifier ./main.go
