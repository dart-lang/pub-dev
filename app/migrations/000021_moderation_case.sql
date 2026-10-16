-- Create "moderation_cases" table
CREATE TABLE "moderation_cases" (
  "case_id" text NOT NULL,
  "reporter_email" text NOT NULL,
  "opened_at" timestamptz NOT NULL,
  "resolved_at" timestamptz NULL,
  "source" text NOT NULL,
  "kind" text NOT NULL,
  "subject" text NOT NULL,
  "url" text NULL,
  "appealed_case_id" text NULL,
  "is_subject_owner" boolean NOT NULL,
  "status" text NOT NULL,
  "grounds" text NULL,
  "violation" text NULL,
  "reason" text NULL,
  PRIMARY KEY ("case_id")
);

-- Create index "moderation_cases_idx_appealed_case_id" to table: "moderation_cases"
CREATE INDEX "moderation_cases_idx_appealed_case_id" ON "moderation_cases" ("appealed_case_id");

-- Create index "moderation_cases_idx_subject" to table: "moderation_cases"
CREATE INDEX "moderation_cases_idx_subject" ON "moderation_cases" ("subject");

-- Create "moderation_action_logs" table
CREATE TABLE "moderation_action_logs" (
  "case_id" text NOT NULL,
  "log_id" text NOT NULL,
  "created_at" timestamptz NOT NULL,
  "subject" text NOT NULL,
  "action" text NOT NULL,
  "note" text NULL,
  PRIMARY KEY ("case_id", "log_id"),
  CONSTRAINT "moderation_action_logs_fk_parent" FOREIGN KEY ("case_id") REFERENCES "moderation_cases" ("case_id") ON UPDATE CASCADE ON DELETE CASCADE
);
