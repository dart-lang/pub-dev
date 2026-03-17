-- Create "tasks" table
CREATE TABLE "tasks" (
  "runtimeVersion" text NOT NULL,
  "package" text NOT NULL,
  "state" jsonb NOT NULL,
  "pendingAt" timestamptz NOT NULL,
  "lastDependencyChanged" timestamptz NOT NULL,
  "finished" timestamptz NOT NULL,
  PRIMARY KEY ("runtimeVersion", "package")
);

-- Create "taskDependencies" table
CREATE TABLE "taskDependencies" (
  "runtimeVersion" text NOT NULL,
  "package" text NOT NULL,
  "dependency" text NOT NULL,
  PRIMARY KEY ("runtimeVersion", "package", "dependency"),
  CONSTRAINT "taskDependencies_runtimeVersion_package_fkey" FOREIGN KEY ("runtimeVersion", "package") REFERENCES "tasks" ("runtimeVersion", "package") ON UPDATE NO ACTION ON DELETE NO ACTION
);
