-- Create "security_advisories" table
CREATE TABLE "security_advisories" (
  "advisory_id" text NOT NULL,
  "published_at" timestamptz NOT NULL,
  "modified_at" timestamptz NOT NULL,
  "synced_at" timestamptz NOT NULL,
  "osv_json" jsonb NOT NULL,
  PRIMARY KEY ("advisory_id")
);

-- Create "security_advisory_packages" table
CREATE TABLE "security_advisory_packages" (
  "advisory_id" text NOT NULL,
  "package" text NOT NULL,
  PRIMARY KEY ("advisory_id", "package"),
  CONSTRAINT "security_advisory_packages_fk_advisory" FOREIGN KEY ("advisory_id") REFERENCES "security_advisories" ("advisory_id") ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create index "security_advisory_packages_idx_package" to table: "security_advisory_packages"
CREATE INDEX "security_advisory_packages_idx_package" ON "security_advisory_packages" ("package");
