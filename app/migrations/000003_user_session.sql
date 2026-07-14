-- Create "user_sessions" table
CREATE TABLE "user_sessions" (
  "session_id" text NOT NULL,
  "user_id" text NULL,
  "email" text NULL,
  "name" text NULL,
  "image_url" text NULL,
  "created" timestamptz NOT NULL,
  "expires" timestamptz NOT NULL,
  "authenticated_at" timestamptz NULL,
  "csrf_token" text NULL,
  "openid_nonce" text NULL,
  "access_token" text NULL,
  "granted_scopes" text NULL,
  PRIMARY KEY ("session_id")
);

-- Create index "user_sessions_idx_expires" to table: "user_sessions"
CREATE INDEX "user_sessions_idx_expires" ON "user_sessions" ("expires");

-- Create index "user_sessions_idx_user_id" to table: "user_sessions"
CREATE INDEX "user_sessions_idx_user_id" ON "user_sessions" ("user_id");
