-- Create "outgoing_emails" table
CREATE TABLE "outgoing_emails" (
  "id" text NOT NULL,
  "created_at" timestamptz NOT NULL,
  "attempts" bigint NOT NULL,
  "last_attempted_at" timestamptz NULL,
  "claim_id" text NULL,
  "pending_at" timestamptz NOT NULL,
  "from_email" text NOT NULL,
  "recipient_emails_json" jsonb NOT NULL,
  "subject" text NOT NULL,
  "body_text" text NOT NULL,
  "body_html" text NOT NULL,
  PRIMARY KEY ("id")
);

-- Create index "outgoing_emails_idx_pending_at" to table: "outgoing_emails"
CREATE INDEX "outgoing_emails_idx_pending_at" ON "outgoing_emails" ("pending_at");
