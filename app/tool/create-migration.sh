#!/usr/bin/env bash

# Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

set -e

MIGRATION_NAME=${1:-"new_migration"}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
APP_DIR="$( cd ${SCRIPT_DIR}/.. && pwd )"
MIGRATIONS_DIR="${APP_DIR}/migrations"
DEV_DB_NAME="atlas-dev-postgres"

mkdir -p "${MIGRATIONS_DIR}"
cd "${APP_DIR}";

# Temporary file to keep the desired database schema.
TEMP_SQL=$(mktemp ./tmp_schema.XXXXXX.sql)
trap 'docker rm -f $DEV_DB_NAME >/dev/null 2>&1; rm -f "$TEMP_SQL"' EXIT

# Developer postgres instance that atlas will use.
echo "Starting dev postgres instance: ${DEV_DB_NAME}"
docker run --rm -d \
  --name $DEV_DB_NAME \
  -e POSTGRES_PASSWORD=pass \
  -p 5432:5432 \
  postgres:17-alpine > /dev/null
sleep 3

# Generating the desired schema.
echo "Creating $TEMP_SQL with the current desired schema..."
dart tool/print_schema_sql.dart >"${TEMP_SQL}"
if [ ! -s "$TEMP_SQL" ]; then
    echo "Error: ${TEMP_SQL} is empty."
    exit 1
fi

# Generating the new migration SQL.
echo "Creating migration: $MIGRATION_NAME..."
docker run --rm \
  --name atlas-migrator \
  --network host \
  -v $(pwd)/migrations:/migrations \
  -v $(pwd)/${TEMP_SQL}:/schema.sql \
  arigaio/atlas:latest-community \
  migrate diff "${MIGRATION_NAME}" \
  --dir "file:///migrations" \
  --to "file:///schema.sql" \
  --dev-url "postgres://postgres:pass@localhost:5432/postgres?sslmode=disable"

echo "Migration created successfully."
