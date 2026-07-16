-- Create "task_aborted_tokens" table
CREATE TABLE "task_aborted_tokens" (
  "runtime_version" text NOT NULL,
  "package" text NOT NULL,
  "token" text NOT NULL,
  "expires" timestamptz NOT NULL,
  PRIMARY KEY ("runtime_version", "package", "token"),
  CONSTRAINT "task_aborted_tokens_fk_task" FOREIGN KEY ("runtime_version", "package") REFERENCES "tasks" ("runtime_version", "package") ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create "task_versions" table
CREATE TABLE "task_versions" (
  "runtime_version" text NOT NULL,
  "package" text NOT NULL,
  "version" text NOT NULL,
  "scheduled" timestamptz NOT NULL,
  "attempts" bigint NOT NULL,
  "zone" text NULL,
  "instance" text NULL,
  "secret_token" text NULL,
  "has_docs" boolean NOT NULL,
  "has_pana" boolean NOT NULL,
  "is_finished" boolean NOT NULL,
  PRIMARY KEY ("runtime_version", "package", "version"),
  CONSTRAINT "task_versions_fk_task" FOREIGN KEY ("runtime_version", "package") REFERENCES "tasks" ("runtime_version", "package") ON UPDATE CASCADE ON DELETE CASCADE
);
