-- Create index "packages_idx_last_version_published_at" to table: "packages"
CREATE INDEX "packages_idx_last_version_published_at" ON "packages" ("last_version_published_at");

-- Create index "packages_idx_publisher_id" to table: "packages"
CREATE INDEX "packages_idx_publisher_id" ON "packages" ("publisher_id");
