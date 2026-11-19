-- Create "migration_phases" table
CREATE TABLE "migration_phases" (
  "entity" text NOT NULL,
  "phase" text NOT NULL,
  "updated_at" timestamptz NOT NULL,
  PRIMARY KEY ("entity")
);
