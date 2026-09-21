-- Create "audit_log_records" table
CREATE TABLE "audit_log_records" (
  "id" text NOT NULL,
  "created" timestamptz NOT NULL,
  "expires" timestamptz NOT NULL,
  "kind" text NOT NULL,
  "agent" text NOT NULL,
  "summary" text NOT NULL,
  "data_json" jsonb NULL,
  PRIMARY KEY ("id")
);

-- Create index "audit_log_records_idx_expires" to table: "audit_log_records"
CREATE INDEX "audit_log_records_idx_expires" ON "audit_log_records" ("expires");

-- Create "audit_log_association" table
CREATE TABLE "audit_log_association" (
  "record_id" text NOT NULL,
  "kind" text NOT NULL,
  "value" text NOT NULL,
  PRIMARY KEY ("record_id", "kind", "value"),
  CONSTRAINT "audit_log_association_fk_record" FOREIGN KEY ("record_id") REFERENCES "audit_log_records" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create index "audit_log_association_idx_kind_value" to table: "audit_log_association"
CREATE INDEX "audit_log_association_idx_kind_value" ON "audit_log_association" ("kind", "value");
