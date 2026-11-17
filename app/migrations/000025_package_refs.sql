-- Modify "package_version_assets" table
ALTER TABLE "package_version_assets"
ADD CONSTRAINT "package_version_assets_fk_parent" FOREIGN KEY ("package", "version") REFERENCES "package_versions" ("package", "version") ON UPDATE CASCADE ON DELETE CASCADE;

-- Modify "packages" table
ALTER TABLE "packages"
ADD CONSTRAINT "packages_fk_publisher" FOREIGN KEY ("publisher_id") REFERENCES "publishers" ("publisher_id") ON UPDATE CASCADE ON DELETE SET NULL;
