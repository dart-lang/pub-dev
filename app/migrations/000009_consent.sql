-- Create "consents" table
CREATE TABLE "consents" (
  "id" text NOT NULL,
  "email" text NOT NULL,
  "dedup_id" text NOT NULL,
  "kind" text NOT NULL,
  "args_json" jsonb NOT NULL,
  "from_agent" text NOT NULL,
  "created_at" timestamptz NOT NULL,
  "expires_at" timestamptz NOT NULL,
  "last_notified_at" timestamptz NULL,
  "notification_count" bigint NOT NULL,
  PRIMARY KEY ("id")
);

-- Create index "consents_idx_dedup_id" to table: "consents"
CREATE INDEX "consents_idx_dedup_id" ON "consents" ("dedup_id");

-- Create index "consents_idx_expires_at" to table: "consents"
CREATE INDEX "consents_idx_expires_at" ON "consents" ("expires_at");
