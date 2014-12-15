#!/bin/bash

# Abort if non-zero code returned.
set -e

dartanalyzer test/mustache_test.dart

dart --checked test/mustache_test.dart

