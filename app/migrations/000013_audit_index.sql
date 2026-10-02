-- Drop index "audit_log_associations_idx_kind_value" from table: "audit_log_associations"
DROP INDEX "audit_log_associations_idx_kind_value";

-- Create index "audit_log_associations_idx_kind_value_created" to table: "audit_log_associations"
CREATE INDEX "audit_log_associations_idx_kind_value_created" ON "audit_log_associations" ("kind", "value", "record_created_at");

-- Create index "audit_log_associations_idx_record_created_at" to table: "audit_log_associations"
CREATE INDEX "audit_log_associations_idx_record_created_at" ON "audit_log_associations" ("record_created_at");

-- Create index "audit_log_records_idx_created_at" to table: "audit_log_records"
CREATE INDEX "audit_log_records_idx_created_at" ON "audit_log_records" ("created_at");
