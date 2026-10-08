-- Create "package_version_assets" table
CREATE TABLE "package_version_assets" (
  "package" text NOT NULL,
  "version" text NOT NULL,
  "kind" text NOT NULL,
  "version_created_at" timestamptz NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "path" text NOT NULL,
  "text_content" text NOT NULL,
  PRIMARY KEY ("package", "version", "kind")
);
