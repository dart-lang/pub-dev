-- Create "reserved_packages" table
CREATE TABLE "reserved_packages" (
  "name" text NOT NULL,
  "created_at" timestamptz NOT NULL,
  "emails_json" jsonb NOT NULL,
  PRIMARY KEY ("name")
);
