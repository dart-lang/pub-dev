-- Create "tasks" table
CREATE TABLE "tasks" (
  "runtime_version" text NOT NULL,
  "package" text NOT NULL,
  "state" jsonb NOT NULL,
  "pending_at" timestamptz NOT NULL,
  "last_dependency_changed" timestamptz NOT NULL,
  "finished" timestamptz NOT NULL,
  PRIMARY KEY ("runtime_version", "package")
);

-- Create "task_dependencies" table
CREATE TABLE "task_dependencies" (
  "runtime_version" text NOT NULL,
  "package" text NOT NULL,
  "dependency" text NOT NULL,
  PRIMARY KEY ("runtime_version", "package", "dependency"),
  CONSTRAINT "task_dependencies_fk_task" FOREIGN KEY ("runtime_version", "package") REFERENCES "tasks" ("runtime_version", "package") ON UPDATE CASCADE ON DELETE CASCADE
);
