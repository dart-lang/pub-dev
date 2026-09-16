-- Create "global_lock_states" table
CREATE TABLE "global_lock_states" (
  "lock_id" text NOT NULL,
  "claim_id" text NOT NULL,
  "locked_until" timestamptz NOT NULL,
  PRIMARY KEY ("lock_id")
);
