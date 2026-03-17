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

# Temporary files to keep the desired database schema and to configure atlas.
TEMP_SQL=$(mktemp ./tmp_schema.XXXXXX.sql)
TEMP_CONFIG=$(mktemp ./tmp_config.XXXXXX.hcl)
trap 'docker rm -f $DEV_DB_NAME >/dev/null 2>&1; rm -f "$TEMP_SQL" "$TEMP_CONFIG"' EXIT

# Developer postgres instance that atlas will use.
echo "Starting dev postgres instance: ${DEV_DB_NAME}"
docker run --rm -d \
  --name $DEV_DB_NAME \
  -e POSTGRES_PASSWORD=pass \
  -p 5432:5432 \
  postgres:17-alpine > /dev/null
sleep 3

cat >$TEMP_CONFIG <<EOF
env "local" {
  migration {
    dir                 = "file://migrations"
  }
  src = "file://schema.sql"
  dev = "postgres://postgres:pass@localhost:5432/postgres?sslmode=disable"
}
EOF

# Generating the desired schema.
echo "Creating $TEMP_SQL with the current desired schema..."
dart tool/print_schema_sql.dart >"${TEMP_SQL}"
if [ ! -s "$TEMP_SQL" ]; then
    echo "Error: ${TEMP_SQL} is empty."
    exit 1
fi

# Clearing and re-creating atlas.sum
rm -f "${MIGRATIONS_DIR}/atlas.sum"
docker run --rm \
  --name atlas-migrator \
  --network host \
  -u $(id -u):$(id -g) \
  -v $(pwd)/migrations:/migrations \
  -v $(pwd)/${TEMP_SQL}:/schema.sql \
  -v $(pwd)/${TEMP_CONFIG}:/atlas.hcl \
  arigaio/atlas:latest-community \
  migrate hash \
  --config "file:///atlas.hcl" \
  --env local

# Generating the new migration SQL.
echo "Creating migration: $MIGRATION_NAME..."
docker run --rm \
  --name atlas-migrator \
  --network host \
  -u $(id -u):$(id -g) \
  -v $(pwd)/migrations:/migrations \
  -v $(pwd)/${TEMP_SQL}:/schema.sql \
  -v $(pwd)/${TEMP_CONFIG}:/atlas.hcl \
  arigaio/atlas:latest-community \
  migrate diff "${MIGRATION_NAME}" \
  --config "file:///atlas.hcl" \
  --env local

echo "Migration created successfully."

rm -f "${MIGRATIONS_DIR}/atlas.sum"

# Find the newly created timestamped file (e.g., 20260317..._name.sql)
LATEST_FILE=$(ls -t ${MIGRATIONS_DIR}/*.sql | head -n 1)
LATEST_FILE_NAME=$(basename "$LATEST_FILE")

# Check if the filename already starts with 6 digits (000001_)
# If it DOES NOT start with 6 digits, we rename it.
if [[ ! "$LATEST_FILE_NAME" =~ ^[0-9]{6}_ ]]; then
  echo "Timestamp detected. Renaming to sequential format..."
  

  # Determine the next number (e.g., if no files exist, start at 000001)
  COUNT=$(ls -1 ${MIGRATIONS_DIR}/*.sql 2>/dev/null | wc -l)
  NEXT_VAL=$(printf "%06d" $COUNT)

  # Rename the file to your desired format
  NEW_NAME="${MIGRATIONS_DIR}/${NEXT_VAL}_${MIGRATION_NAME}.sql"
  mv "$LATEST_FILE" "$NEW_NAME"

  # Remove the "public". schema prefix
  sed -i 's/"public"\.//g' $NEW_NAME

  FORMAT_FILE_NAME=$(basename "$NEW_NAME")
  docker run --rm \
    -u $(id -u):$(id -g) \
    -v ${MIGRATIONS_DIR}:/work \
    -w /work \
    backplane/sql-formatter \
    --config '{"language": "postgresql", "uppercase": true, "indent": "  "}' \
  --fix \
    "$FORMAT_FILE_NAME"
else
  echo "File already follows sequential format ($LATEST_FILE_NAME). Skipping rename."
fi

cd "${MIGRATIONS_DIR}"
ls *.sql | sort | xargs -n 1 sha256sum >sha256sum.txt


# need to go to the original directory, otherwise the trap command won't delete the temp files
cd "${APP_DIR}"
