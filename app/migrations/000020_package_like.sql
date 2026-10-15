-- Create "package_likes" table
CREATE TABLE "package_likes" (
  "user_id" text NOT NULL,
  "package" text NOT NULL,
  "created_at" timestamptz NOT NULL,
  PRIMARY KEY ("user_id", "package"),
  CONSTRAINT "package_likes_fk_packageRow" FOREIGN KEY ("package") REFERENCES "packages" ("name") ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT "package_likes_fk_userRow" FOREIGN KEY ("user_id") REFERENCES "users" ("user_id") ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create index "package_likes_idx_package_user" to table: "package_likes"
CREATE INDEX "package_likes_idx_package_user" ON "package_likes" ("package", "user_id");
