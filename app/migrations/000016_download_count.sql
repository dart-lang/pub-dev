-- Create "download_counts" table
CREATE TABLE "download_counts" (
  "package" text NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "count_data_json" jsonb NOT NULL,
  PRIMARY KEY ("package")
);
