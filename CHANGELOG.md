Important changes to data-models, configuration and migrations between each
AppEngine version, listed here to ease deployment and troubleshooting.

## Next Release (replace with git tag when deployed)
 * Upgraded runtime SDK to `2.7.0`.
 * Bumped runtimeVersion to `2019.12.13`.
 * Upgraded Flutter to `1.12.13+hotfix.5`.
 * Upgraded pana to `0.13.2`.
 * Removed the use of `platformTags` from `pana` analysis,
   and also the use of `platform` in search queries (#3167).

## `20191210t151931-all`
 * Upgraded dart to `2.7.0`.
 * Upgraded Flutter to `1.12.13+hotfix.4`.
 * Bumped runtimeVersion to `2019.12.10`.
 * A few nit CSS fixes.

## `20191209t173621-all`
 * Fixed fallback tag generation for flutter.

## `20191209t144508-all`
 * Bumped runtimeVersion to `2019.12.09`.
 * Upgraded pana to `0.13.1+4`.

## `20191206t130338-all`
 * Fallback to tags derived from older score cards.

## `20191205t152333-all`
 * Bumped runtimeVersion to `2019.12.05+1`.
 * Upgraded Flutter to `1.12.13+hotfix.2`.
 * Upgraded pana to `0.13.1+2`.
 * Upgraded dartdoc to `0.29.1`.

## `20191128t123245-all`
 * Run `app/bin/tools/backfill_package_fields.dart` to backfill
   `Package.assignedTags`.

## `20191127t111711-all`
 * Added 'my liked packages' page behind experimental flag.

## `20191120t113136-all`
 * Bumped runtimeVersion to `2019.11.12`.
 * Upgraded tool SDK to Dart `2.6.1`.
 * Removed support for old `Consent` format.

## `20191111t112217-all`
 * Run `app/bin/tools/backfill_package_fields.dart` to backfill `Package`
   entities by populating the `likes`, `isDiscontinued` and `doNotAdvertise` properties.
 * Upgraded runtime SDK to `2.6.0`.
 * Upgraded package dependencies.
 * Refactored `Consent`:
   * new entities do not have the user in their key
   * WARNING: user merge on pending old consent entities does not work
 * Removed support for old uploader invites.
 * Added thumb-up button and likes functionality in the UI.

## `20191104t103859-all`
 * Refactored `Consent`:
   * new entities contain `userId` (if it is known upfront)  
 * Search updates:
   * #2968 may increase CPU latencies while serving a query
 * Bumped runtimeVersion to `2019.11.01`.
 * Upgraded tool SDK to Dart `2.6.0`.
 * Upgraded Flutter SDK to `1.9.1+hotfix.6`.

## `20191028t120414-all`
 * Run `app/bin/tools/backfill_packagelikes.dart` to backfill `Package`
   entities by populating the `likes` property.
 * Added API endpoints and backend implementation for package likes.
 * Force account selection on login.
 * Bumped runtimeVersion to `2019.10.22`.
 * Upgraded dartdoc to `0.28.8` (upgraded analyzer).
 * Fixed race condition in user creation flow.

## `20191015t141342-all`
 * Minor fixes to publisher texts.

## `20191010t103137-all`
 * Minor template adjustments.

## `20191009t181835-all`
 * Releasing publishers.

## `20191009t104315-all`
 * Fixed UI page cache issue.
 * Updated confirmation message about cache updates.

## `20191008t163533-all`
 * Minor NPE fixes in dartdoc process.

## `20191008t123347-all`
 * Minor fixes of JS when experimental flag is not on.

## `20191007t110314-all`

 * Upgraded to Dart `2.5.0`.
 * Upgraded `package:markdown` to `2.1.0`.
 * Search index contains `publisherId` and `owners` fields, the first startup
   needs to have a 1-2 hours before all the packages get re-indexed with them.
   After that they will be part of the index snapshot, and will be available
   as other parts of the index.
 * Upgraded Flutter SDK to `1.9.1+hotfix.4`.
 * Bumped runtimeVersion to `2019.10.07`.

## `20190910t122708-all`

 * Upgraded tool SDK to Dart `2.5.0`.
 * Upgraded Flutter SDK to `1.9.1+hotfix.2`.
 * Upgraded pana to `0.12.21` (upgraded analyzer).
 * Upgraded dartdoc to `0.28.5` (upgraded analyzer).
 * Bumped runtimeVersion to `2019.09.10`.

## `20190828t095814-all`

 * Run `app/bin/tools/backfill_users.dart` to backfill `User`
   entities in datastore (populates `isDeleted` flag).
 * Upgraded pana to `0.12.20` (upgraded analyzer).
 * Bumped runtimeVersion to `2019.08.26`.

## `20190814t134432-all`

 * Upgraded dartdoc to `0.28.4` (upgraded analyzer).
 * Upgraded Flutter SDK to `1.7.8+hotfix.4`.
 * Bumped runtimeVersion to `2019.08.13`.
 * Increased HSTS duration to a year.

## `20190711t114908-all`
 
 * Fix NPE in cache logic.

## `20190710t115923-all`

 * Upgraded Flutter to `1.7.8+hotfix.3`.
 * Bumped runtimeVersion to `2019.07.10`.

## `20190708t104225-all`

 * Fixed issue with sdk dependencies.

## `20190704t133404-all`

 * Upgraded to Dart `2.4.0`.
 * Bumped runtimeVersion to `2019.05.03`.

## `20190626t135754-all`

 * Downgraded `package:appengine` to `0.6.1` due to `grpc` issues.

## `20190625t130656-all`

 * Upgraded `package:appengine` to `0.7.0`, need to watch for side-effects.
 * Update project to use split health checks, run:
   `gcloud app update --split-health-checks --project dartlang-pub`
 * Upgraded `pana` (`0.12.19`).
 * Bumped runtimeVersion to `2019.06.24`.

## `20190617t112618-all`

 * `search` service is using custom liveness and readiness checks.
 * Search results (top packages, listing pages) use local fallbacks.
 * Upgraded `pana` (`0.12.18`), runtime and analysis Dart SDK (`2.3.2`).
 * Bumped runtimeVersion to `2019.06.17`.

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
