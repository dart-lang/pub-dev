#!/bin/bash

# Fail fast
set -e

# Analyze
dartanalyzer --fatal-warnings lib/*dart lib/messages/*dart test/*dart

# Test
pub run test

# Check format
pub global activate dart_style
pub global run dart_style:format --set-exit-if-changed --dry-run lib/ test/
