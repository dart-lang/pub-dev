-- Create "users" table
CREATE TABLE "users" (
  "user_id" text NOT NULL,
  "oauth_user_id" text NULL,
  "email" text NULL,
  "created_at" timestamptz NULL,
  "is_deleted" boolean NOT NULL,
  "is_moderated" boolean NOT NULL,
  "moderated_at" timestamptz NULL,
  "moderated_reason" text NULL,
  PRIMARY KEY ("user_id")
);

-- Create index "users_idx_oauth_user_id" to table: "users"
CREATE INDEX "users_idx_oauth_user_id" ON "users" ("oauth_user_id");
