-- Create index "task_dependencies_idx_current_dependency" to table: "task_dependencies"
CREATE INDEX "task_dependencies_idx_current_dependency" ON "task_dependencies" ("runtime_version", "dependency");

-- Create index "tasks_idx_current_dependency_changed" to table: "tasks"
CREATE INDEX "tasks_idx_current_dependency_changed" ON "tasks" ("runtime_version", "last_dependency_changed");

-- Create index "tasks_idx_current_finished" to table: "tasks"
CREATE INDEX "tasks_idx_current_finished" ON "tasks" ("runtime_version", "finished");

-- Create index "tasks_idx_current_pending_at" to table: "tasks"
CREATE INDEX "tasks_idx_current_pending_at" ON "tasks" ("runtime_version", "pending_at");
