# Database Migrations

This directory contains sequential SQL migration files.
The files are forward-only, can be hand-written, but for
the default use case can be generated with [Atlas](https://atlasgo.io/).

## File conventions

- Migration files use zero-padded sequential numbering: `NNNNNN_name.sql`.
- `sha256sum.txt` contains SHA-256 checksums of all `.sql` files.

## Creating a new migration

The files can be created by hand, or automatically by using Atlas.

To generate them automatically:

1. Update the schema with `typed_sql`.
2. Run `dart run build_runner build` to update the generated `typed_sql` files.
3. Run `tool/create-migration.sh <migration_name>` to generate a new migrations SQL file.

### What the script does

1. Starts a temporary PostgreSQL in a docker container (`atlas-dev-postgres`)
   for Atlas to use as a dev database.
2. Generates the desired database schema by running
   `dart tool/print_schema_sql.dart`.
3. Uses Atlas docker image to compute the diff between the current
   migrations and the desired schema, producing a new migration SQL file.
4. Renames the Atlas-generated timestamped file (e.g. `20260317..._name.sql`)
   to a sequential format (`000001_name.sql`, `000002_name.sql`, ...).
5. Formats the SQL file using the `sql-formatter` docker image.
6. Updates `sha256sum.txt` with checksums of all migration files.
7. Cleans up the Docker container and temporary files on exit.
