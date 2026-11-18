-- Create "neat_task_statuses" table
CREATE TABLE "neat_task_statuses" (
  "task_name" text NOT NULL,
  "runtime_version" text NOT NULL,
  "status" bytea NOT NULL,
  "etag" text NOT NULL,
  "updated_at" timestamptz NOT NULL,
  PRIMARY KEY ("task_name", "runtime_version")
);

-- Create index "neat_task_statuses_idx_updated_at" to table: "neat_task_statuses"
CREATE INDEX "neat_task_statuses_idx_updated_at" ON "neat_task_statuses" ("updated_at");
