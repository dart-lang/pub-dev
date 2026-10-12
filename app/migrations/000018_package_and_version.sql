-- Create "package_versions" table
CREATE TABLE "package_versions" (
  "package" text NOT NULL,
  "version" text NOT NULL,
  "created_at" timestamptz NOT NULL,
  "sha256" bytea NULL,
  "pubspec_json" jsonb NOT NULL,
  "libraries_json" jsonb NOT NULL,
  "uploader" text NOT NULL,
  "publisher_id" text NULL,
  "is_retracted" boolean NOT NULL,
  "retracted_at" timestamptz NULL,
  "is_moderated" boolean NOT NULL,
  "moderated_at" timestamptz NULL,
  "is_admin_deleted" boolean NOT NULL,
  "admin_deleted_at" timestamptz NULL,
  PRIMARY KEY ("package", "version")
);

-- Create "packages" table
CREATE TABLE "packages" (
  "name" text NOT NULL,
  "created_at" timestamptz NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "last_version_published_at" timestamptz NOT NULL,
  "latest_version" text NOT NULL,
  "latest_published_at" timestamptz NULL,
  "latest_prerelease_version" text NULL,
  "latest_prerelease_published_at" timestamptz NULL,
  "latest_preview_version" text NULL,
  "latest_preview_published_at" timestamptz NULL,
  "publisher_id" text NULL,
  "versions_count" bigint NOT NULL,
  "likes_count" bigint NOT NULL,
  "is_discontinued" boolean NOT NULL,
  "replaced_by" text NULL,
  "is_unlisted" boolean NOT NULL,
  "is_moderated" boolean NOT NULL,
  "moderated_at" timestamptz NULL,
  "is_admin_deleted" boolean NOT NULL,
  "admin_deleted_at" timestamptz NULL,
  "assigned_tags_json" jsonb NOT NULL,
  "deleted_versions_json" jsonb NOT NULL,
  "publishing_config_json" jsonb NULL,
  "latest_advisory_at" timestamptz NULL,
  PRIMARY KEY ("name")
);

-- Create "package_uploaders" table
CREATE TABLE "package_uploaders" (
  "package" text NOT NULL,
  "user_id" text NOT NULL,
  PRIMARY KEY ("package", "user_id"),
  CONSTRAINT "package_uploaders_fk_packageRow" FOREIGN KEY ("package") REFERENCES "packages" ("name") ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT "package_uploaders_fk_userRow" FOREIGN KEY ("user_id") REFERENCES "users" ("user_id") ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create index "package_uploaders_idx_user_package" to table: "package_uploaders"
CREATE INDEX "package_uploaders_idx_user_package" ON "package_uploaders" ("user_id", "package");
