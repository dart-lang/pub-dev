Important changes to data-models, configuration and migrations between each
AppEngine version, listed here to ease deployment and troubleshooting.

## Next Release (replace with git tag when deployed)

 * `Package.uploaderEmails` and `PackageVersion.uploaderEmail` is no longer used/updated.

## `20190325t131912-all`

 * Fixes to invitation logic.

## `20190320t135247-all`

 * Run `gcloud app deploy cron.yaml` to update cron-job retry logic.

 * Behaviour changes:

   * OAuth: accept only validated e-mails that look like e-mails (have @, . and e-mail-like structure).

## `20190306t115839-all`
 
 * Run `app/bin/tools/backfill_packageversions.dart` to backfill `PubSpec`
   entities in datastore (these entitites are not in use yet).
 * Bumped runtimeVersion to `2019.03.05`.
