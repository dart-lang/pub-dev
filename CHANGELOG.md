Important changes to data-models, configuration and migrations between each
AppEngine version, listed here to ease deployment and troubleshooting.

## Next Release (replace with git tag when deployed)

 * Update project to use split health checks, run:
   `gcloud app update --split-health-checks --project dartlang-pub`
 * `search` service is using custom liveness and readiness checks.

## `20190529t163905-all`

 * Upgraded `pana` (`0.12.17`).
 * Bumped runtimeVersion to `2019.05.29`.

## `20190522t135532-all`

 * Removed support for legacy auth tokens (without `user_id`).
   Users with legacy tokens will be requested to login again.
 * Upgraded `pana` (`0.12.16`), Dart SDK (`2.3.1`) and downgraded Flutter SDK (`1.5.4-hotfix.2`).
 * Bumped runtimeVersion to `2019.05.22`.

## `20190508t114341-all`

 * Upgraded `pana` (`0.12.15`), Dart SDK (`2.3.0`) and Flutter SDK (`1.5.8`).
 * Bumped runtimeVersion to `2019.05.07`.

## `20190503t145023-all`

 * Redirect UI traffic to `pub.dev`.
 * Emit `pub.dev` as primary host URL.
 * Bumped runtimeVersion to `2019.05.03` to trigger `dartdoc` content generation with the new primary hosts.

## `20190503t132754-all`

 * Fixed the bug in dynamic oauth `redirect_uri` calculation.

## `20190502t154607-all`

 * Enabled new design on `pub.dev` (redirects still missing).
 * Dependency graph monitoring in a separate isolate of the `frontend` service.
 * `/feed.atom` changes random seed to generate `uuid` for feed entry.

## `20190416t133139-all`

 * Old dartdoc content will be deleted after 180 days, even if it is the only successful dartdoc run.

## `20190404t123731-all`

 * `Package.uploaderEmails` and `PackageVersion.uploaderEmail` is no longer used/updated.
 * Removed `namespace` and `qualifiedPackage` fields from `PackageVersionPubspec` and `PackageVersionInfo`.
 * Upgrade Flutter SDK to 1.4.7, bumped runtimeVersion to `2019.04.02`.
 * Dependency graph monitoring uses `PackageVersionPubspec`, and triggers affected notifications internally.

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
