-- Modify "consents" table
ALTER TABLE "consents"
ADD CONSTRAINT "consents_dedup_id_key" UNIQUE ("dedup_id");

-- Modify "users" table
ALTER TABLE "users"
ADD CONSTRAINT "users_oauth_user_id_key" UNIQUE ("oauth_user_id");

-- Modify "user_sessions" table
ALTER TABLE "user_sessions"
ADD CONSTRAINT "user_sessions_fk_user" FOREIGN KEY ("user_id") REFERENCES "users" ("user_id") ON UPDATE CASCADE ON DELETE CASCADE;
