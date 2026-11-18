-- Create "package_tombstones" table
CREATE TABLE "package_tombstones" (
  "name" text NOT NULL,
  "moderated_at" timestamptz NOT NULL,
  "publisher_id" text NULL,
  "uploaders_json" jsonb NOT NULL,
  "versions_json" jsonb NOT NULL,
  PRIMARY KEY ("name")
);
