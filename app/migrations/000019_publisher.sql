-- Create "publishers" table
CREATE TABLE "publishers" (
  "publisher_id" text NOT NULL,
  "description" text NULL,
  "website_url" text NULL,
  "contact_email" text NULL,
  "created_at" timestamptz NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "is_abandoned" boolean NOT NULL,
  "is_moderated" boolean NOT NULL,
  "moderated_at" timestamptz NULL,
  PRIMARY KEY ("publisher_id")
);

-- Create "publisher_members" table
CREATE TABLE "publisher_members" (
  "publisher_id" text NOT NULL,
  "user_id" text NOT NULL,
  "created_at" timestamptz NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "role" text NOT NULL,
  PRIMARY KEY ("publisher_id", "user_id"),
  CONSTRAINT "publisher_members_fk_publisher" FOREIGN KEY ("publisher_id") REFERENCES "publishers" ("publisher_id") ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT "publisher_members_fk_user" FOREIGN KEY ("user_id") REFERENCES "users" ("user_id") ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create index "publisher_members_idx_user_publisher" to table: "publisher_members"
CREATE INDEX "publisher_members_idx_user_publisher" ON "publisher_members" ("user_id", "publisher_id");
