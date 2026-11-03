-- Create index "package_versions_idx_created_at" to table: "package_versions"
CREATE INDEX "package_versions_idx_created_at" ON "package_versions" ("created_at");

-- Create index "packages_idx_created_at" to table: "packages"
CREATE INDEX "packages_idx_created_at" ON "packages" ("created_at");

-- Create index "packages_idx_updated_at" to table: "packages"
CREATE INDEX "packages_idx_updated_at" ON "packages" ("updated_at");
