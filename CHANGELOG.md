Important changes to data models, configuration, and migrations between each
AppEngine version, listed here to ease deployment and troubleshooting.

## Next Release (replace with git tag when deployed)

## `20240911t105800-all`
 * Bumped runtimeVersion to `2024.09.10`.
 * Upgraded stable Flutter analysis SDK to `3.24.2`.

## `20240906t140400-all`
 * Upgraded dependencies including `googleapis`.

## `20240905t122100-all`
 * Bumped runtimeVersion to `2024.09.04`.
 * Upgraded stable Dart analysis SDK to `3.5.2`
 * Upgraded dartdoc to `8.1.0`.
 * Note: `Package.latest*` fields are recalculated with a full list of `PackageVersion` entities.

## `20240829t084400-all`
 * Bumped runtimeVersion to `2024.08.27`.
 * Upgraded stable Flutter analysis SDK to `3.24.1`.
 * Upgraded pana to `0.22.12`.
 * Upgraded dartdoc to `8.0.14`.
 * Note: the `report` experiment is enabled by default.

## `20240821t093600-all`
 * Bumped runtimeVersion to `2024.08.20`.
 * Upgraded stable Dart analysis SDK to `3.5.1`
 * Upgraded pana to `0.22.11`.

## `20240815t121700-all`
 * Bumped runtimeVersion to `2024.08.09`.
 * Upgraded runtime Dart SDK to `3.5.0`.
 * Upgraded dependencies including `mailer` and `googleapis`.
 * Additional memory to search instances.

## `20240808t114400-all`
 * Bumped runtimeVersion to `2024.08.08`.
 * Upgraded pana to `0.22.10`.

## `20240808t081100-all`
 * Bumped runtimeVersion to `2024.08.06`.
 * Upgraded stable Flutter analysis SDK to `3.24.0`.
 * Upgraded dartdoc to `8.0.13`.

## `20240805t095700-all`
 * Bumped runtimeVersion to `2024.08.05`.
 * Upgraded stable Dart analysis SDK to `3.5.0`
 * Upgraded stable Flutter analysis SDK to `3.22.3`.

## `20240718t101100-all`
 * Bumped runtimeVersion to `2024.07.18`.
 * Upgraded pana to `0.22.9`.

## `20240711t102500-all`
 * Bumped runtimeVersion to `2024.07.09`.
 * Upgraded pana to `0.22.8`.
 * Upgraded dartdoc to `8.0.10`.
 * Note: `setup-flutter.sh` uses http archives for stable/beta channel.
 * Note: started to use `Summary.result.licenses`.
 * Note: starting to check `hook/` files for new package uploads.

## `20240627t084200-all`
 * Bumped runtimeVersion to `2024.06.25`.
 * Upgraded stable Dart analysis SDK to `3.4.4`

## `20240620t083100-all`
 * Bumped runtimeVersion to `2024.06.19`.
 * Upgraded pana to `0.22.7`.

## `20240613t092600-all`
 * Bumped runtimeVersion to `2024.06.12`.
 * Upgraded stable Dart analysis SDK to `3.4.3`
 * Upgraded stable Flutter analysis SDK to `3.22.2`.
 * Upgraded pana to `0.22.6`.
 * Note: `Consent.fromUserId` and `Consent.createdBySiteAdmin` may be removed once this release gets stable. 

## `20240606t114600-all`
 * Bumped runtimeVersion to `2024.05.30`.
 * Upgraded pana to `0.22.5`.

## `20240529t113700-all`
 * Bumped runtimeVersion to `2024.05.28`.
 * Upgraded stable Dart analysis SDK to `3.4.1`
 * Upgraded stable Flutter analysis SDK to `3.22.1`.
 * Note: backfilling new GitHub publishing fields.

## `20240523t085100-all`
 * Bumped runtimeVersion to `2024.05.22`.
 * Upgraded runtime Dart SDK to `3.4.0`.
 * Upgraded dependencies.
 * Upgraded dartdoc to `8.0.9`.
 * Note: started to populate `Consent.fromAgent` field.

## `20240514t110800-all`
 * Fixes copy icon issue.

## `20240514t085700-all`
 * Bumped runtimeVersion to `2024.05.14`.
 * Upgraded stable Dart analysis SDK to `3.4.0`
 * Upgraded stable Flutter analysis SDK to `3.22.0`.
 * Note: re-enabled email notification on package published events.

## `20240502t112300-all`
 * Bumped runtimeVersion to `2024.05.01`.
 * Upgraded stable Dart analysis SDK to `3.3.4`
 * Upgraded stable Flutter analysis SDK to `3.19.6`.

## `20240429t132000-all`
 * Note: disabled email notification on package published events.

## `20240429t092800-all`
 * Note: re-enabled email notification on package published events.

## `20240418t083500-all`
 * Bumped runtimeVersion to `2024.04.16`.
 * Upgraded pana to `0.22.3`.
 * Upgraded dartdoc to `8.0.8`.
 * Note: Path values in `/documentation/<p>/<v>/<path>` are no longer restricted.

## `20240410t034000-all`
 * Bumped runtimeVersion to `2024.04.08`.
 * Upgraded stable Dart analysis SDK to `3.3.3`
 * Upgraded stable Flutter analysis SDK to `3.19.5`.

## `20240325t103500-all`
 * Bumped runtimeVersion to `2024.03.21`.
 * Upgraded stable Dart analysis SDK to `3.3.1`
 * Upgraded stable Flutter analysis SDK to `3.19.3`.
 * Note: started using generic rate limiting in transactions.

## `20240314t121900-all`
 * Bumped runtimeVersion to `2024.03.12`.
 * Upgraded dartdoc to `8.0.7`.
 * Upgraded dependencies including `markdown 7.2.2`.
 * Note: dynamic SDK selection may download latest stable, beta or master branches.

## `20240307t093000-all`
 * Bumped runtimeVersion to `2024.03.05`.
 * Upgraded stable Flutter analysis SDK to `3.19.2`.
 * Upgraded dartdoc to `8.0.6`.
 * Note: preview analysis SDKs are downloaded dynamically.
 * Note: started to backfill `isModerated` flags in `Package`, `PackageVersion`, `Publisher` and `User`.
 * Resyncing all `SecurityAdvisory` entities to get `pub_display_url` in the
  `database_specific` field backfilled.


## `20240227t140000-all`
 * Bumped runtimeVersion to `2024.02.27`.
 * Upgraded pana to `0.22.2`.

## `20240226t093600-all`
 * Bumped runtimeVersion to `2024.02.26`.
 * Upgraded stable Flutter analysis SDK to `3.19.1`.
 * Note: Analysis SDK directories with separate config homes.

## `20240223t113900-all`
 * Note: removed alert block syntax from markdown rendering.

## `20240222t112000-all`
 * Bumped runtimeVersion to `2024.02.21`.
 * Upgraded runtime Dart SDK to `3.3.0`.
 * Upgraded dependencies including `markdown: ^7.2.1`.

## `20240220t074300-all`
 * Bumped runtimeVersion to `2024.02.16`.
 * Upgraded stable Flutter analysis SDK to `3.19.0`.
 * Upgraded preview Flutter analysis SDK to `3.20.0-1.1.pre`.

## `20240213t125700-all`
 * Bumped runtimeVersion to `2024.02.13`.
 * Upgraded stable Dart analysis SDK to `3.3.0` (hash: `74ea934a1e9b9f01e7fd06b1d872c9cf822c1d71`).
 * Upgraded preview Dart analysis SDK to `3.4.0-131.0.dev`.

## `20240209t135900-all`
 * Bumped runtimeVersion to `2024.02.09`.
 * Upgraded pana to `0.22.0`.
 * Note: applied rate limit on search endpoints.

## `20240206t104500-all`
 * Bumped runtimeVersion to `2024.02.05`.
 * Upgraded stable Dart analysis SDK to `3.2.6`.
 * Upgraded stable Flutter analysis SDK to `3.16.9`.
 * Upgraded preview Dart analysis SDK to `3.3.0-279.3.beta`.
 * Upgraded preview Flutter analysis SDK to `3.19.0-0.4.pre`.
 * Note: started to populate audit log records with extended `agentId` for service accounts.

## `20240201t145300-all`
 * Note: temporarily disabled email notification on package published events.

## `20240130t131100-all`
 * Bumped runtimeVersion to `2024.01.30`.
 * Upgraded dartdoc to `8.0.4`.
 * Note: re-enabled email notification on package published events.

## `20240125t125400-all`
 * Bumped runtimeVersion to `2024.01.22`.
 * Upgraded stable Dart analysis SDK to `3.2.5`.
 * Upgraded stable Flutter analysis SDK to `3.16.8`.
 * Upgraded preview Flutter analysis SDK to `3.19.0-0.2.pre`.
 * Note: Sending emails keep persistent connection for a few minutes.

## `20240118t104800-all`
 * Upgraded dependencies including `markdown: ^7.2.0`.

## `20240115t140400-all`
 * Note: temporarily disabled email notification on package published events.

## `20240111t095800-all`
 * Bumped runtimeVersion to `2024.01.10`.
 * Upgraded stable Flutter analysis SDK to `3.16.5`.
 * Upgraded preview Dart analysis SDK to `3.3.0-279.1.beta`.
 * Upgraded dartdoc to `8.0.3`.

## `20240102t140400-all`
 * Bumped runtimeVersion to `2023.12.18`.
 * Upgraded stable Flutter analysis SDK to `3.16.4`.
 * Upgraded preview Flutter analysis SDK to `3.18.0-0.2.pre`.
 * Upgraded pana to `0.21.45`.

## `20231212t114900-all`
 * Bumped runtimeVersion to `2023.12.08`.
 * Upgraded stable Dart analysis SDK to `3.2.3`.
 * Upgraded stable Flutter analysis SDK to `3.16.3`.
 * Upgraded pana to `0.21.44`.
 * Upgraded dependencies.

## `20231206t130200-all`
 * Bumped runtimeVersion to `2023.12.06`.
 * Upgraded stable Dart analysis SDK to `3.2.2`.
 * Upgraded stable Flutter analysis SDK to `3.16.2`.
 * Upgraded preview Dart analysis SDK to `3.3.0-174.2.beta`.
 * Upgraded preview Flutter analysis SDK to `3.18.0-0.1.pre`.

## `20231128t115900-all`
 * Bumped runtimeVersion to `2023.11.28`.
 * Upgraded stable Dart analysis SDK to `3.2.1`.
 * Upgraded stable Flutter analysis SDK to `3.16.1`.
 * Upgraded preview Dart analysis SDK to `3.3.0-166.0.dev`.
 * Upgraded dartdoc to `8.0.0`.
 * Note: Retrying HTTP failures on `SocketException`.

## `20231121t102000-all`
 * Bumped runtimeVersion to `2023.11.21`.
 * Upgraded runtime Dart SDK to `3.2.0`.
 * Upgraded pana to `0.21.43`.
 * Upgraded dependencies.

## `20231116t095000-all`
 * Bumped runtimeVersion to `2023.11.16`.
 * Upgraded stable Dart analysis SDK to `3.2.0`.
 * Upgraded preview Dart analysis SDK to `3.3.0-120.0.dev`.
 * Upgraded stable Flutter analysis SDK to `3.16.0`.
 * Upgraded preview Flutter analysis SDK to `3.17.0-0.0.pre`.
 * Upgraded pana to `0.21.42`.
 * Note: Started running `dartdoc` from `pana`.

## `20231115t090700-all`
 * Hiding invalid popularity scores.

## `20231109t095900-all`
 * Resyncing all `SecurityAdvisory` entities to get `syncTime` fields backfilled.

## `20231102t094900-all`
 * Bumped runtimeVersion to `2023.11.02`.
 * Upgraded stable Dart analysis SDK to `3.1.5`.
 * Upgraded preview Dart analysis SDK to `3.2.0-210.3.beta`.
 * Upgraded stable Flutter analysis SDK to `3.13.9`.
 * Upgraded preview Flutter analysis SDK to `3.16.0-0.3.pre`.
 * Upgraded pana to `0.21.40`.

## `20231019t115400-all`
 * Moved search index building and search GC jobs into `analyzer` instance.
 * Increased memory on `analyzer` instances to 16G, running two of them.

## `20231018t131100-all`
 * Bumped runtimeVersion to `2023.10.18`.
 * Upgraded pana to `0.21.39`.
 * Upgraded dartdoc to `7.0.0`.
 * Note: backfilling automated publishing field.

## `20231012t082200-all`

## `20231011t120800-all`
 * Bumped runtimeVersion to `2023.10.10`.
 * Upgraded stable Dart analysis SDK to `3.1.3`.
 * Upgraded preview Dart analysis SDK to `3.2.0-210.1.beta`.
 * Upgraded stable Flutter analysis SDK to `3.13.6`.
 * Upgraded pana to `0.21.38`.

## `20230927t085100-all`
 * Bumped runtimeVersion to `2023.09.26`.
 * Upgraded stable Dart analysis SDK to `3.1.2`.
 * Upgraded preview Dart analysis SDK to `3.2.0-134.1.beta`.
 * Upgraded stable Flutter analysis SDK to `3.13.5`.
 * Upgraded preview Flutter analysis SDK to `3.15.0-15.2.pre`.
 * Upgraded pana to `0.21.37`.
 * Upgraded `package:tar` and other dependencies.
 * Note: started to populate `PackageDocument.likeScore` and `popularityScore`.

## `20230918t113400-all`
 * Fix: search isolate renewal doesn't block ongoing traffic.

## `20230914t133300-all`
 * Bumped runtimeVersion to `2023.09.12`.
 * Upgraded stable Dart analysis SDK to `3.1.1`.
 * Upgraded stable Flutter analysis SDK to `3.13.3`.
 * Upgraded preview Dart analysis SDK to `3.2.0-42.2.beta`.
 * Upgraded preview Flutter analysis SDK to `3.14.0-0.2.pre`.
 * Note: isolates do not automatically restart after they are closed with uncaught error.
 * Note: no control isolate is used, first isolate is used as the HTTP-serving frontend.
 * Note: `search` has now a separate index in an isolate that is renewed every 15 minutes.

## `20230907t123500-all`
 * Bumped runtimeVersion to `2023.09.05`.
 * Upgraded dartdoc to `6.3.0`.
 * Note: increased minimum instance count of `default` service to 32.

## `20230904t124200-all`
 * Note: Only a single frontend isolate will process HTTP requests.
         Increased autoscaling of the default service.

## `20230831t122900-all`
 * Bumped runtimeVersion to `2023.08.29`.
 * Upgraded runtime Dart SDK to `3.1.0`.
 * Upgraded dependencies.
 * Note: `DartdocRun`, `Job` and `ScoreCard` entities will be deleted in Datastore.
 * Note: `dartdoc` backend no longer deletes entries from `Configuration.dartdocStorageBucketName`.
         TODO: delete the bucket after this release becomes obsolete.

## `20230822t112400-all`

## `20230821t132100-all`

## `20230818t145900-all`
 * Bumped runtimeVersion to `2023.08.18`.

## `20230817t142000-all`
 * Bumped runtimeVersion to `2023.08.17`.
 * Upgraded stable Dart analysis SDK to `3.1.0`.
 * Upgraded stable Flutter analysis SDK to `3.13.0`.
 * Upgraded preview Dart analysis SDK to `3.2.0-42.1.beta`.
 * Upgraded preview Flutter analysis SDK to `3.13.0`.
 * Upgraded pana to `0.21.36`.
 * Note: Upgraded `package:gcloud`.
 * Note: `analyzer` and `dartdoc` processing is turned off.

## `20230810t094700-all`
 * Bumped runtimeVersion to `2023.08.08`.
 * Upgraded stable Dart analysis SDK to `3.0.7`.
 * Upgraded stable Flutter analysis SDK to `3.10.6`.
 * Upgraded preview Dart analysis SDK to `3.1.0-262.3.beta`.
 * Upgraded preview Flutter analysis SDK to `3.13.0-0.3.pre`.

## `20230804t105300-all`
 * Bumped runtimeVersion to `2023.08.04`.

## `20230727t102500-all`
 * Bumped runtimeVersion to `2023.07.27`.
 * Enabled sandboxing.

## `20230725t162600-all`
 * Bumped runtimeVersion to `2023.07.24`.
 * Upgraded pana to `0.21.35`.
 * Upgraded dependencies (incl. `appengine` and `markdown`).

## `20230710t123000-all`
 * Enable sandboxed output for sandboxed screenshots, dartdoc and ScoreCard.

## `20230709t025700-all`
 * Disable sandboxed output for sandboxed screenshots and dartdoc

## `20230707t103900-all`
 * Bumped runtimeVersion to `2023.07.06`.
 * Removing all fallback runtimeVersions.
 * Displaying sandboxed screenshots and dartdoc.

## `20230623t075300-all`
 * Bumped runtimeVersion to `2023.06.21`.
 * Upgraded stable Dart analysis SDK to `3.0.5`.
 * Upgraded stable Flutter analysis SDK to `3.10.5`.
 * Upgraded preview Dart analysis SDK to `3.1.0-163.1.beta`.
 * Upgraded preview Flutter analysis SDK to `3.12.0`.
 * Upgraded pana to `0.21.33`.

## `20230615t111100-all`
 * Switch on task backend for output.

## `20230613t121200-all`
 * Bumped runtimeVersion to `2023.06.12`.
 * Store sanitized dartdoc HTML as JSON files.
 * Switch to not use task backend for output.
 * Note: search snapshot is now updated in a separate isolate.

## `20230607t103700-all`
 * Switch to use task backend for output.
 * Bumped runtimeVersion to `2023.06.07`.

## `20230606t110900-all`
 * Bumped runtimeVersion to `2023.05.31`.
 * Note: Dart 3 compatibility check uses the same SDK as the analysis.

## `20230531t083600-all`
 * Bumped runtimeVersion to `2023.05.30`.
 * Upgraded stable Dart analysis SDK to `3.0.2`.
 * Upgraded stable Flutter analysis SDK to `3.10.2`.
 * Upgraded preview Flutter analysis SDK to `3.11.0-0.1.pre`.

## `20230530t100200-all`

## `20230526t075200-all`
 * Reduced `search` isolate count to 1.
 * Reduced `search` instance count to 6-12.
 * Added a periodic 250ms `Timer` in every isolate to prevent compaction GC.

## `20230524t141500-all`

## `20230523t155100-all`
 * Note: removed unused-looking code in publisher creation, we need to check if it is still working after deployment.

## `20230523t102500-all`
 * Upgraded dependencies (incl. `mailer`, `tar`, `googleapis`).
 * Increased instance count of `search` instances.

## `20230522t134000-all`
 * Note: Started to rate limit package uploads using (locally cached) AuditLogRecords.
 * Note: Decreased periodic index update to 5 days.

## `20230516t150900-all`
 * Bumped runtimeVersion to `2023.05.16`.
 * Upgraded runtime Dart SDK to `3.0.0`.
 * Upgraded `package:markdown` to `7.1.0`.

## `20230511t105900-all`
 * Bumped runtimeVersion to `2023.05.10`.
 * Upgraded preview Dart analysis SDK to `3.1.0-63.1.beta`.
 * Upgraded stable Flutter analysis SDK to `3.10.0`.
 * Upgraded preview Flutter analysis SDK to `3.11.0-0.0.pre`.

## `20230509t112300-all`
 * Bumped runtimeVersion to `2023.05.09`.
 * Upgraded pana to `0.21.32`.

## `20230508t122100-all`

## `20230504t133400-all`
 * Bumped runtimeVersion to `2023.05.04`.
 * Upgraded stable Dart analysis SDK to `3.0.0`.
 * Upgraded preview Dart analysis SDK to `3.0.0`.
 * Upgraded stable Flutter analysis SDK to `3.10.0-1.5.pre`.
 * Upgraded preview Flutter analysis SDK to `3.10.0-1.5.pre`.
 * Upgraded pana to `0.21.31`.
 * Upgraded dartdoc to `6.2.2`.

## `20230427t134200-all`
 * Bumped runtimeVersion to `2023.04.27`.
 * Upgraded preview Dart analysis SDK to `3.0.0-417.3.beta`.
 * Upgraded preview Flutter analysis SDK to `3.10.0-1.4.pre`.
 * Note: Dart 3 compatibility for Flutter packages is based on preview Flutter SDK.

## `20230421t140900-all`
 * Bumped runtimeVersion to `2023.04.21`.
 * Upgraded stable Flutter analysis SDK to `3.7.12`.
 * Upgraded preview Dart analysis SDK to `3.0.0-417.2.beta`.
 * Upgraded preview Flutter analysis SDK to `3.10.0-1.3.pre`.
 * Upgraded pana to `0.21.30`.

## `20230419t110400-all`
 * Bumped runtimeVersion to `2023.04.19`.
 * Downgraded `package:markdown` to `6.0.1`.

## `20230414t135200-all`
 * Bumped runtimeVersion to `2023.04.14`.
 * Upgraded runtime Dart SDK to `2.19.6`.
 * Upgraded dependencies.

## `20230412t125600-all`
 * Bumped runtimeVersion to `2023.04.12`.
 * Upgraded stable Dart analysis SDK to `2.19.6`.
 * Upgraded stable Flutter analysis SDK to `3.7.10`.
 * Upgraded preview Dart analysis SDK to `3.0.0-400.0.dev`.
 * Upgraded preview Flutter analysis SDK to `3.9.0-0.2.pre`.
 * Upgraded pana to `0.21.28`.
 * Upgraded dartdoc to `6.2.1`.
 * Upgraded `package:markdown` to `7.0.2`
 * Upgraded material web components to `14.0.0`.

## `20230328t111100-all`
 * Turning off old sign-in flow.

## `20230323t135600-all`
 * Fixing session-related rendering in new sign-in flow.

## `20230322t165800-all`
 * Enabled new sign-in flow.

## `20230316t130000-all`
 * Bumped runtimeVersion to `2023.03.13`.
 * Upgraded stable Dart analysis SDK to `2.19.4`.
 * Upgraded stable Flutter analysis SDK to `3.7.7`.
 * Upgraded preview Dart analysis SDK to `3.0.0-305.0.dev`.
 * NOTE: renamed `is:dart3-ready` to `is:dart3-compatible`.
 * Note: started to delete leftover objects in the public bucket.

## `20230307t120800-all`
 * Bumped runtimeVersion to `2023.03.07`.
 * Upgraded preview Dart analysis SDK to `3.0.0-290.0.dev`.

## `20230307t110000-all`
 * Bumped runtimeVersion to `2023.03.03`.
 * Upgraded stable Dart analysis SDK to `2.19.3`.
 * Upgraded stable Flutter analysis SDK to `3.7.6`.
 * Upgraded preview Dart analysis SDK to `3.0.0-218.1.dev`.
 * Upgraded pana to `0.21.27`.
 * Removed `required: true` from the `UserSession.email` field.

## `20230223t105400-all`
 * Bumped runtimeVersion to `2023.02.22`.
 * Upgraded stable Flutter analysis SDK to `3.7.4`.
 * Upgraded preview Flutter analysis SDK to `3.8.0-10.1.pre`.
 * Downgraded `package:markdown` to `6.0.1`.
 * Removed `required: true` from the `UserSession.userId` field.
   TODO: remove `ClientSession` and merge fields into `UserSession` after this release becomes stable.

## `20230216t120900-all`
 * Upgraded `package:markdown` to `7.0.0`.
 * Bumped runtimeVersion to `2023.02.14`.

## `20230210t134600-all`
 * Bumped runtimeVersion to `2023.02.10`
 * Upgraded stable Flutter analysis SDK to `3.7.3`.
 * Upgraded preview Dart analysis SDK to `3.0.0-218.0.dev`.
 * Upgraded preview Flutter analysis SDK to `3.7.3`.
 * Upgraded pana to `0.21.26`.

## `20230209t105500-all`
 * Bumped runtimeVersion to `2023.02.09`
 * Upgraded stable Dart analysis SDK to `2.19.2`.
 * Upgraded stable Flutter analysis SDK to `3.7.2`.
 * Upgraded preview Dart analysis SDK to `3.0.0-187.0.dev`.
 * Upgraded preview Flutter analysis SDK to `3.7.2`.

## `20230202t153800-all`
 * Bumped runtimeVersion to `2023.02.01`
 * Upgraded runtime Dart SDK to `2.19.0`.
 * Upgraded stable Dart analysis SDK to `2.19.1`.
 * Upgraded preview Dart analysis SDK to `3.0.0-179.0.dev`.
 * Upgraded dartdoc to `6.1.5`.
 * Upgraded dependencies.
 * Updated `osd.xml`: using inlined URL parameter.
 * Higher limit on dart-doc total output size (2.3G).

## `20230125t151100-all`
 * Enabled `dart3` experiment, displaying "Dart-3 ready" badges.

## `20230125t095000-all`

## `20230125t093800-all`
 * Bumped runtimeVersion to `2023.01.25`
 * Upgraded stable Flutter analysis SDK to `3.7.0`.
 * Upgraded preview Flutter analysis SDK to `3.7.0`.

## `20230124t115700-all`
 * Bumped runtimeVersion to `2023.01.24`
 * Upgraded stable Dart analysis SDK to `2.19.0`.
 * Upgraded preview Dart analysis SDK to `3.0.0-151.0.dev`.
 * Upgraded preview Flutter analysis SDK to `3.7.0-1.5.pre`.
 * Upgraded Dart 3 SDK to `3.0.0-151.0.dev`.

## `20230123t122500-all`

## `20230123t121400-all`
 * Bumped runtimeVersion to `2023.01.20`
 * Upgraded Dart 3 SDK to `3.0.0-128.0.dev`.
 * Upgraded pana to `0.21.25`.
 * `pkg/pub_worker` uses new `PANA_CACHE` directory to cache intermediate analysis results between versions of the same package.

## `20230117t133900-all`
 * Bumped runtimeVersion to `2023.01.16`
 * Upgraded stable Dart analysis SDK to `2.18.7`.
 * Upgraded preview Dart analysis SDK to `2.19.0-444.4.beta`.
 * Upgraded preview Flutter analysis SDK to `3.7.0-1.4.pre`.
 * Upgraded dependencies.

## `20230112t112900-all`
 * Bumped runtimeVersion to `2023.01.11`

## `20230105t102600-all`
 * Bumped runtimeVersion to `2023.01.03`
 * Upgraded pana to `0.21.24`.

## `20221222t115200-all`

## `20221220t161000-all`
 * Bumped runtimeVersion to `2022.12.16`
 * Upgraded stable Dart analysis SDK to `2.18.6`.
 * Upgraded stable Flutter analysis SDK to `3.3.10`.
 * Upgraded preview Dart analysis SDK to `2.19.0-444.1.beta`.
 * Upgraded preview Flutter analysis SDK to `3.7.0-1.1.pre`.
 * Upgraded pana to `0.21.23`.

## `20221208t112900-all`
 * Bumped runtimeVersion to `2022.12.07`.
 * Upgraded pana to `0.21.22`.
 * Check valid (well-formatted) dependency names at upload.
 * Check that dependencies exist at upload.

## `20221130t094900-all`
 * Increased frontend maximum instance count: 16 -> 18.
 * Increased search instance isolates: 1 -> 2.

## `20221125t092200-all`

## `20221124t133300-all`
 * Update `index.yaml` to allow tracking `PackageState`.

## `20221124t112300-all`
 * Bumped runtimeVersion to `2022.11.23`.
 * Upgraded stable Flutter analysis SDK to `3.3.9`.
 * Upgraded preview Flutter analysis SDK to ` 3.6.0-0.1.pre`.
 * Upgraded pana to `0.21.21
 * Upgraded dependencies.
 * NOTE: `api_builder` rejects requests with unexpected mime types.

## `20221110t093400-all`
 * Bumped runtimeVersion to `2022.11.04`.
 * NOTE: `api_builder` logs unexpected mime types.

## `20221103t103200-all`
 * Bumped runtimeVersion to `2022.11.02`.
 * Upgraded stable Dart analysis SDK to `2.18.4`.
 * Upgraded stable Flutter analysis SDK to `3.3.7`.
 * Upgraded pana to `0.21.20`.

## `20221027t112600-all`
 * Bumped runtimeVersion to `2022.10.27`.
 * Upgraded stable Dart analysis SDK to `2.18.3`.
 * Upgraded stable Flutter analysis SDK to `3.3.6`.
 * Upgraded preview Dart analysis SDK to `2.19.0-255.2.beta`.
 * Upgraded preview Flutter analysis SDK to `3.4.0-34.1.pre`.
 * Upgraded pana to `0.21.19`.
 * NOTE: Removed dartdoc documentation text from search index.
 * NOTE: `FlagMixin` uses `tags`, next release may remove `flags`.

## `20221004t093700-all`

## `20220929t092500-all`
 * Bumped runtimeVersion to `2022.09.29`.
 * Upgraded stable Dart analysis SDK to `2.18.2`.
 * Upgraded stable Flutter analysis SDK to `3.3.3`.

## `20220928t100800-all`
 * Bumped runtimeVersion to `2022.09.26`.
 * Upgraded pana to `0.21.18`.
 * Upgraded dartdoc to `6.1.1`.
 * Upgraded dependencies, including `markdown` to `6.0.1`.
 * NOTE: Fixed `OutgoingEmail`: all recipients in one entry.

## `20220922t114500-all`
 * Bumped runtimeVersion to `2022.09.22`.
 * Upgraded stable Dart analysis SDK to `2.18.1`.
 * Upgraded preview Dart analysis SDK to `2.19.0-146.2.beta`.
 * Upgraded preview Flutter analysis SDK to `3.4.0-17.2.pre`.
 * Upgraded dependencies in `app`, including `package:analyzer` to `4.7.0`.
 * NOTE: Started to use `OutgoingEmail` entities to track pending emails.

## `20220915t093500-all`
 * Bumped runtimeVersion to `2022.09.14`.
 * Upgraded stable Flutter analysis SDK to `3.3.2`.
 * Upgraded preview Flutter analysis SDK to `3.3.2`.
 * Upgraded pana to `0.21.17`.
 * NOTE: Increasing instance counts for `default` and `search` services.
 * NOTE: Landing page uses `CachedValue` to track top-* packages.
 * NOTE: Stopped using old bucket for package archives.

## `20220908t135900-all`
 * Bumped runtimeVersion to `2022.09.08`.
 * Upgraded runtime Dart SDK to `2.18.0`.
 * Upgraded stable Flutter analysis SDK to `3.3.1`.
 * Upgraded preview Flutter analysis SDK to `3.3.1`.
 * NOTE: Deploy new index with `gcloud app deploy index.yaml`.
 * NOTE: Started to populate search index with `is:unlisted` tag for `discontinued` and `legacy` packages.

## `20220831t123000-all`

## `20220831t114300-all`
 * Bumped runtimeVersion to `2022.08.31`.
 * Upgraded stable Flutter analysis SDK to `3.3.0`.
 * Upgraded preview Flutter analysis SDK to `3.3.0`.

## `20220830t132400-all`
 * Fixed `/api/documentation/<package>` endpoint bug.

## `20220829t082800-all`
 * Bumped runtimeVersion to `2022.08.26`.
 * Upgraded stable Dart analysis SDK to `2.18.0`.
 * Upgraded preview Dart analysis SDK to `2.18.0`.

## `20220825t132100-all`
 * NOTE: `search` stopped populating `highlightedHit` field.
 * Upgraded dependencies.
 * NOTE: Limit `/api/documentation/<package>` endpoint to the latest versions.

## `20220822t072200-all`
 * Downgraded `package:markdown` to `5.0.0`.

## `20220818t125400-all`
 * Bumped runtimeVersion to `2022.08.17`.
 * Upgraded preview Flutter analysis SDK to `3.3.0-0.3.pre`.
 * Upgraded pana to `0.21.16`.
 * Upgraded dartdoc to `6.0.1`.
 * NOTE: Started to use new public bucket for pub-dev deployment.
 * NOTE: Started serving `archive_sha256` on client API endpoints.

## `20220804t094500-all`
 * Bumped runtimeVersion to `2022.08.02`.
 * Upgraded stable Dart analysis SDK to `2.17.6`.
 * Upgraded stable Flutter analysis SDK to `3.0.5`.
 * Upgraded preview Dart analysis SDK to `2.18.0-271.4.beta`.
 * Upgraded preview Flutter analysis SDK to `3.3.0-0.1.pre`.
 * Upgraded pana to `0.21.15`.
 * Upgraded dartdoc to `6.0.0`.
 * NOTE: `LICENSE` is a required file in the new versions.
 * NOTE: Started serving package archives from the new public bucket.

## `20220705t102600-all`
 * Bumped runtimeVersion to `2022.07.05`.
 * Upgraded stable Dart analysis SDK to `2.17.5`.
 * Upgraded stable Flutter analysis SDK to `3.0.4`.
 * Upgraded pana to `0.21.14`.
 * NOTE: Relaxed processing of Youtube Playlist API response.
 * NOTE: Store and use verified URL and repository results from pana.
 * NOTE: Started to populate `PackageVersion.sha256`.

## `20220623t124000-all`
 * Bumped runtimeVersion to `2022.06.23`.
 * Upgraded stable Flutter analysis SDK to `3.0.3`.
 * Upgraded preview Flutter analysis SDK to `3.1.0-9.0.pre`.
 * Upgraded pana to `0.21.13`.
 * NOTE: Removing `Package.isWithheld`.

## `20220620t083300-all`
 * Bumped runtimeVersion to `2022.06.13`.
 * Upgraded stable Flutter analysis SDK to `3.0.2`.
 * Upgraded preview Dart analysis SDK to `2.18.0-165.1.beta`.
 * NOTE: Started to strictly match the OAuth token's audience for the scope of the current operation.
 * NOTE: Updated integrity checks before finalizing migration of `Package.isBlocked`.
 * NOTE: Blocking uploader API endpoints used by `pub` client tool.

## `20220608t083800-all`
 * Bumped runtimeVersion to `2022.06.02`.
 * Upgraded stable Dart analysis SDK to `2.17.3`.
 * Upgraded preview Flutter analysis SDK to `3.1.0`.
 * NOTE: Started to use and backfill `Package.isBlocked`.
 * NOTE: Only using the dedicated bucket for incoming package uploads.

## `20220530t115600-all`
 * Bumped runtimeVersion to `2022.05.23`.
 * Upgraded stable Dart analysis SDK to `2.17.1`.
 * Upgraded stable Flutter analysis SDK to `3.0.1`.
 * Upgraded preview Dart analysis SDK to `2.18.0-109.0.dev`.
 * Upgraded preview Flutter analysis SDK to `3.0.1`.
 * Upgraded dartdoc to `5.1.2`.
 * NOTE: Started to use the dedicated bucket for incoming package uploads.

## `20220519t133400-all`

## `20220519t124000-all`
 * Bumped runtimeVersion to `2022.05.14`.
 * Upgraded runtime Dart SDK to `2.17.0`.
 * Upgraded dependencies.
 * NOTE: Started to use and backfill `Publisher.isBlocked`.

## `20220513t212800-all`
 * Bumped runtimeVersion to `2022.05.13`.
 * Upgraded stable Flutter analysis SDK to `3.0.0`.
 * Upgraded preview Flutter analysis SDK to `3.0.0`.

## `20220509t123300-all`
 * Bumped runtimeVersion to `2022.05.09`.
 * Upgraded stable Dart analysis SDK to `2.17.0`.
 * Upgraded preview Dart analysis SDK to `2.17.0`.
 * Upgraded preview Flutter analysis SDK to `2.13.0-0.4.pre`.

## `20220505t124300-all`
 * Bumped runtimeVersion to `2022.05.03`.
 * Upgraded preview Dart analysis SDK to `2.17.0-266.7.beta`.
 * Upgraded preview Flutter analysis SDK to `2.13.0-0.3.pre`.
 * NOTE: In-page click tracking is loaded asynchronously.
   TODO: After deployment check if click tracking on the copy-to-clipboard icon is working.

## `20220425t133600-all`
 * Bumped runtimeVersion to `2022.04.21`.
 * Upgraded stable Dart analysis SDK to `2.16.2`.
 * Upgraded stable Flutter analysis SDK to `2.10.5`.
 * Upgraded preview Dart analysis SDK to `2.17.0-266.1.beta`.
 * Upgraded preview Flutter analysis SDK to `2.13.0-0.1.pre`.
 * Upgraded pana to `0.21.12`.
 * Upgraded dependencies including `package:appengine` to `0.13.2`, `package:markdown` to `5.0.0`.
 * NOTE: started to use `/static/hash-<hash>/...` URLs.

## `20220324t054900-all`
 * Bumped runtimeVersion to `2022.03.21`.
 * Upgraded preview Dart analysis SDK to `2.17.0-182.1.beta`.
 * Upgraded preview Flutter analysis SDK to `2.12.0-4.1.pre`.
 * Upgraded pana to `0.21.10`.
 * Upgraded dependencies, including `analyzer` and `pub_semver`.
 * Note: stopped calling `git gc` in Flutter analysis SDK repositories.

## `20220310t134700-all`
 * Bumped runtimeVersion to `2022.03.08`.
 * Upgraded stable Flutter analysis SDK to `2.10.3`.
 * Upgraded pana to `0.21.8`.
 * NOTE: removed `ScoreCardData.reportTypes`

## `20220302t144000-all`
 * Bumped runtimeVersion to `2022.02.25`.
 * Upgraded runtime Dart SDK to `2.16.1`
 * Upgraded preview Dart analysis SDK to `2.17.0-85.0.dev`.
 * Upgraded stable Flutter analysis SDK to `2.10.2`.
 * Upgraded preview Flutter analysis SDK to `2.11.0-0.1.pre`.
 * Upgraded dartdoc to `5.0.1`.
 * NOTE: override invalid versions at package extraction + backfill.
 * NOTE: `/static/` files are served with gzipped bytes when the request accepts it.

## `20220209t173000-all`
 * Bumped runtimeVersion to `2022.02.09`.
 * Upgrade stable Dart analysis SDK to `2.16.1`.
 * Upgraded preview Dart analysis SDK to `2.16.1`.
 * Upgraded stable Flutter analysis SDK to `2.10.0`.
 * Upgraded preview Flutter analysis SDK to `2.10.0`.

## `20220202t122400-all`
 * Bumped runtimeVersion to `2022.01.31`.
 * Upgrade stable Dart analysis SDK to `2.16.0`.
 * Upgraded preview Dart analysis SDK to `2.16.0`.
 * NOTE: additional null-safety checks in integrity verification.

## `20220128t123200-all`
 * Bumped runtimeVersion to `2022.01.27`.
 * Upgraded preview Dart analysis SDK to `2.16.0-134.5.beta`.
 * Upgraded preview Flutter analysis SDK to `2.10.0-0.3.pre`.
 * Upgraded pana to `0.21.7`.
 * Upgraded dependencies, including `googleapis`, `mailer`, `tar`.
 * NOTE: `search` index no longer uses or populates uploader `userId`.

## `20220112t121700-all`
 * Bumped runtimeVersion to `2022.01.06`.
 * Upgraded pana to `0.21.5`.
 * NOTE: Started to use `pkg/indexed_blob` to generate and serve `dartdoc` content.

## `20220106t124300-all`
 * Bumped runtimeVersion to `2021.12.17`.
 * Upgraded runtime Dart SDK to `2.15.1`
 * Upgraded stable Flutter analysis SDK to `2.8.1`.
 * Upgraded preview Flutter analysis SDK to `2.9.0-0.1.pre`.

## `20211216t102600-all`
 * Bumped runtimeVersion to `2021.12.15`.
 * Restored indexed fields in `Job`.

## `20211215t122100-all`
 * Bumped runtimeVersion to `2021.12.14`.
 * Upgrade stable Dart analysis SDK to `2.15.1`.
 * Upgraded preview Dart analysis SDK to `2.16.0-80.1.beta`.
 * Upgraded stable Flutter analysis SDK to `2.8.0`.
 * Upgraded preview Flutter analysis SDK to `2.8.0`.
 * NOTE: `UserSession` no longer indexes on `email`, `name`, `userImg` and `created` fields.

## `20211206t162600-all`
 * Renamed `retracted` field in API response object `VersionInfo`.

## `20211206t133000-all`
 * Bumped runtimeVersion to `2021.12.06`.
 * Upgrade stable Dart analysis SDK to `2.15.0`.
 * Upgraded preview Dart analysis SDK to `2.16.0-63.0.dev`.
 * Upgraded preview Flutter analysis SDK to `2.8.0-3.3.pre`.

## `20211202t154700-all`
 * Bumped runtimeVersion to `2021.11.28`.
 * NOTE: Corrected published timestamps as part of the backfill.

## `20211125t125900-all`
 * Bumped runtimeVersion to `2021.11.22`.
 * Upgraded preview Dart analysis SDK to `2.15.0-268.18.beta`.
 * Upgraded preview Flutter analysis SDK to `2.8.0-3.2.pre`.
 * NOTE: strict version checks on upload.

## `20211118t160200-all`
 * Bumped runtimeVersion to `2021.11.16`.
 * Upgraded preview Dart analysis SDK to `2.15.0-268.8.beta`.
 * Upgraded preview Flutter analysis SDK to `2.8.0-3.1.pre`.
 * NOTE: First release that includes `/help/api`.
   TODO(deferred): request community members on announce@ to self-report API use.
 * NOTE: removed in-memory buffering in `pkg/pub_dartdoc`.

## `20211108t124400-all`
 * NOTE: Verify backfill logs (`[backfill-version-count-*]` entries) after a few days of this release.

## `20211104t151100-all`
 * Bumped runtimeVersion to `2021.11.01`.
 * Upgraded preview Flutter analysis SDK to `2.7.0-3.1.pre`.
 * Upgraded pana to `0.21.4`.
 * Upgraded dependencies (e.g. `package:analyzer` to `2.7.0`).

## `20211027t134800-all`
 * Bumped runtimeVersion to `2021.10.26`.
 * Upgraded stable Dart analysis SDK to `2.14.4`.
 * Upgraded stable Flutter analysis SDK to `2.5.3`.
 * Upgraded preview Dart analysis SDK to `2.15.0-178.1.beta`.
 * Upgraded preview Flutter analysis SDK to `2.7.0-3.0.pre`.
 * Upgraded dartdoc to `4.1.0`.
 * NOTE: Started to use cached package list from NameTracker instead of Datastore queries with offset.
 * NOTE: `/api/packages/<package>` calls only use `gzip` cache, which may increase
         CPU utilization if there are many clients that do not accept the `gzip` content-encoding.
 * NOTE: Started to use cached package list for all use cases where a list of package versions is required.
 * NOTE: started to populate and use `Package.versionCount`.
         TODO(deferred): add an integrity check in the next release.

## `20211013t105500-all`
 * Bumped runtimeVersion to `2021.10.12`.
 * Upgraded stable Dart analysis SDK to `2.14.3`.
 * Upgraded stable Flutter analysis SDK to `2.5.2`.
 * Upgraded dartdoc to `4.0.0`.
 * Upgraded pana to `0.21.3`.
 * Upgraded dependencies (e.g. `package:analyzer` to `2.5.0`).
 * NOTE: Migrated SearchConsole API.
         When deploying publisher registration should be manually tested before migration.
 * NOTE: Atom feed returns the latest 100 package versions published.
         A package may be present more than once.
         Instead of the `README.md`, the feed contains only the `description:` field from `pubspec.yaml`.
 * NOTE: `/api/packages/<package>` calls are now cached and served with `gzip` content-encoding
         when the client sends accept header in the request (`pub` client does send it).

## `20211001t132700-all`

## `20210930t141400-all`

## `20210930t141200-all`
 * Bumped runtimeVersion to `2021.09.27`.
 * Upgraded stable Dart analysis SDK to `2.14.2`.
 * Upgraded preview Dart analysis SDK to `2.15.0-82.2.beta`.
 * Upgraded stable Flutter analysis SDK to `2.5.1`.
 * Upgraded preview Flutter analysis SDK to `2.6.0-5.2.pre`.
 * Upgraded dartdoc to `3.1.0`.
 * Upgraded pana to `0.21.2`.
 * Upgraded dependencies (e.g. `package:analyzer` to `2.3.0`).

## `20210916t115700-all`
 * Bumped runtimeVersion to `2021.09.15`.
 * Upgraded runtime Dart SDK to `2.14.1`
 * Upgraded stable Dart analysis SDK to `2.14.1`.
 * Upgraded preview Dart analysis SDK to `2.15.0-82.1.beta`.
 * Upgraded stable Flutter analysis SDK to `2.5.0`.
 * Upgraded preview Flutter analysis SDK to `2.5.0`.
 * Upgraded pana to `0.21.1+1`.
 * NOTE: Disabled report size trimming in `ScoreCard`.

## `20210907t091200-all`
 * Bumped runtimeVersion to `2021.09.06`.
 * Upgraded stable Dart analysis SDK to `2.14.0`.

## `20210902t171900-all`
 * Bumped runtimeVersion to `2021.09.02`.
 * Upgraded dependencies (e.g. `package:analyzer` to `2.2.0`).

## `20210826t165000-all`
 * Bumped runtimeVersion to `2021.08.25`.
 * Upgraded preview Flutter analysis SDK to `2.5.0-5.2.pre`.
 * Upgraded dartdoc to `2.0.0`.
 * NOTE: increased the number of search service instances to 4 (autoscale up to 6).
 * Limit `pkg/pub_dartdoc` output to 2 GiB and 10M files.

## `20210819t120700-all`
 * Bumped runtimeVersion to `2021.08.17`.
 * Upgraded preview Dart analysis SDK to `2.14.0-377.7.beta`
 * Upgraded pana to `0.20.0`.
 * NOTE: started to populate and use `PackageDocument.uploaderUserIds`
         TODO(deferred): remove `PackageDocument.uploaderEmails` in a future release
 * NOTE: added weekly (versioned) periodic task: `check-datastore-integrity`.

## `20210812t143400-all`
 * Bumped runtimeVersion to `2021.08.12`.
 * Upgraded preview Dart analysis SDK to `2.14.0-377.4.beta`
 * Upgraded preview Flutter analysis SDK to `2.5.0-5.1.pre`.
 * Upgraded pana to `0.19.1`.
 * Upgraded dartdoc to `1.0.2`.
 * Upgraded `package:analyzer` to `2.0.0`.

## `20210728t125700-all`
 * Bumped runtimeVersion to `2021.07.27`.
 * Upgraded runtime Dart SDK to `2.13.4`
 * Upgraded dependencies.
 * NOTE: enabled activity log UI without experimental flag.
 * NOTE: added `PackageVersion.isRetracted`.
         TODO(deferred): make it required, and add it to integrity checks.
 * NOTE: added weekly (versioned) periodic task: `backfill-new-fields`.
 * Limit `pkg/pub_dartdoc` output to 2 GiB and 10M files.

## `20210722t120000-all`
 * Bumped runtimeVersion to `2021.07.21`.
 * Upgraded preview Dart analysis SDK to `2.14.0-301.2.beta`
 * Upgraded pana to `0.19.0`.
 * Upgraded dependencies.

## `20210713t112200-all`
 * Bumped runtimeVersion to `2021.07.08`.
 * Migrated `pkg/api_builder` and most of `app/` to null-safety.
 * Upgraded stable Dart analysis SDK to `2.13.4`.
 * Upgraded stable Flutter analysis SDK to `2.2.3`.
 * Upgraded preview Dart analysis SDK to `2.14.0-188.5.beta`
 * Upgraded preview Flutter analysis SDK to `2.3.0-24.1.pre`.
 * Upgraded dartdoc to `1.0.0`.
 * NOTE: `app/bin/server.dart` is migrated to null-safety.

## `20210622t160400-all`
 * Bumped runtimeVersion to `2021.06.21`.
 * Upgraded preview Dart analysis SDK to `2.14.0-188.3.beta`

## `20210617t110000-all`
 * Redeploy `cron.yaml` as we have stopped backups through this mechanism.
 * Bumped runtimeVersion to `2021.06.16`.
 * Upgraded runtime Dart SDK to `2.13.3`.
 * Upgraded stable Dart analysis SDK to `2.13.3`.
 * Upgraded preview Dart analysis SDK to `2.13.3`.
 * Upgraded stable Flutter analysis SDK to `2.2.2`.
 * Upgraded preview Flutter analysis SDK to `2.2.2`.
 * Upgraded pana to `0.18.2`.
 * NOTE: Stopped creating and using dartdoc data for Dart SDK.

## `20210610t211000-all`

## `20210610t171300-all`
 * Bumped runtimeVersion to `2021.06.08`.
 * Upgraded dartdoc to `0.45.0`.
 * NOTE: Stopped creating `ScoreCardReport` entities.

## `20210603t155700-all`
 * Bumped runtimeVersion to `2021.06.01`.
 * Upgraded stable Flutter analysis SDK to `2.2.1`.
 * Upgraded preview Flutter analysis SDK to `2.2.1`.
 * Upgraded pana to `0.17.1`.
 * Upgraded dartdoc to `0.44.0`.
 * Upgraded package dependencies, including:
   * `package:appengine` to `0.13.0`
   * `package:gcloud` to `0.8.0`
   * `package:googleapis` to `3.0.0`
   * `package:http` to `0.13.0`
   * `package:mailer` to `5.0.0`
   * `package:tar` to `0.4.0`
 * NOTE: Removed `packages` and `PackageScore` from search results.
 * NOTE: `gc-dartdoc-storage-bucket` logs the total number of entries deleted.
 * NOTE: Started to store report data on `ScoreCard` entities too.

## `20210526t104100-all`
 * Bumped runtimeVersion to `2021.05.25`.
 * Upgraded stable Dart analysis SDK to `2.13.1`.
 * Upgraded preview Dart analysis SDK to `2.13.1`.
 * Upgraded pana to `0.17.0`.

## `20210520t112100-all`
 * Bumped runtimeVersion to `2021.05.19`.
 * Upgraded stable Flutter analysis SDK to `2.2.0`.
 * Upgraded preview Flutter analysis SDK to `2.2.0`.
 * Upgraded dartdoc to `0.43.0`.
 * NOTE: Started to display `PackageHit` and `SdkLibraryHit` results.

## `20210517t183200-all`
 * Bumped runtimeVersion to `2021.05.17`.
 * Upgraded stable Dart analysis SDK to `2.13.0`.
 * Upgraded preview Dart analysis SDK to `2.13.0`.
 * Upgraded preview Flutter analysis SDK to `2.2.0-10.3.pre`.
 * Upgraded pana to `0.16.2`.

## `20210511t144600-all`
 * Bumped runtimeVersion to `2021.05.11`.

## `20210510t142700-all`
 * Bumped runtimeVersion to `2021.05.10`.
 * Upgraded preview Dart analysis SDK to `2.13.0-211.14.beta`.
 * NOTE: search API started to emit `PackageHit` and `SdkLibraryHit`.

## `20210506t120400-all`
 * Bumped runtimeVersion to `2021.05.03`.
 * Upgraded stable Flutter analysis SDK to `2.0.6`.
 * Upgraded preview Flutter analysis SDK to `2.2.0-10.2.pre`.
 * NOTE: `DartdocEntry` status files are no longer stored in the Bucket,
          only in Datastore's `DartdocRun` entity.

## `20210428t105500-all`
 * Bumped runtimeVersion to `2021.04.27`.
 * Upgraded stable Dart analysis SDK to `2.12.4`.
 * Upgraded preview Dart analysis SDK to `2.13.0-211.13.beta`.
 * Upgraded stable Flutter analysis SDK to `2.0.5`.
 * Upgraded preview Flutter analysis SDK to `2.2.0-10.1.pre`.
 * Upgraded pana to `0.16.0`.
 * Upgraded a few dependencies including `markdown`, `pub_semver` and `yaml`.

## `20210419t154700-all`

## `20210419t134200-all`
 * Re-enabled YouTube integrations with `cached_value` pattern.
 * Upgraded `package:appengine` to `0.12.0`.
 * Periodic tasks are now scoped to `global` or `runtimeVersion`.
   NOTE: added weekly periodic task: `delete-old-neat-task-statuses`.

## `20210407t142600-all`
 * Bumped runtimeVersion to `2021.04.06`.
 * Upgraded stable Dart analysis SDK to `2.12.2`.
 * Upgraded stable Flutter analysis SDK to `2.0.4`.
 * Upgraded dartdoc to `0.42.0`.
 * NOTE: Expected reduction in Job-related API calls.

## `20210325t074600-all`
 * Temporarily disabled youtube integration.

## `20210324t155000-all`

 * Bumped runtimeVersion to `2021.03.19`.
 * Upgraded preview Dart analysis SDK to `2.13.0-116.1.beta`.
 * Upgraded stable Flutter analysis SDK to `2.0.3`.
 * Upgraded preview Flutter analysis SDK to `2.1.0-12.2.pre`.

## `20210315t154700-all`
 * Bumped runtimeVersion to `2021.03.15`.
 * Upgraded runtime Dart SDK to `2.12.0`.
 * Upgraded stable Dart analysis SDK to `2.12.1`.
 * Upgraded preview Dart analysis SDK to `2.12.1`.
 * Upgraded stable Flutter analysis SDK to `2.0.2`.
 * Upgraded preview Flutter analysis SDK to `2.0.2`.
 * Upgraded dartdoc to `0.40.0`.
 * Upgraded pana to `0.15.4`.

## `20210303t195300-all`
 * Bumped runtimeVersion to `2021.03.03`.
 * Upgraded pana to `0.15.3`.
 * Upgraded stable Flutter analysis SDK to `2.0.0`.
 * Upgraded preview Flutter analysis SDK to `2.0.0`.

## `20210302t130300-all`
 * Bumped runtimeVersion to `2021.03.02`.
 * Upgraded pana to `0.15.2`.
 * Upgraded stable Dart analysis SDK to `2.12.0`.
 * Upgraded preview Dart analysis SDK to `2.12.0`.
 * Upgraded stable Flutter analysis SDK to `1.26.0-17.8.pre`.
 * Upgraded preview Flutter analysis SDK to `1.26.0-17.8.pre`.

## `20210224t144700-all`
 * Bumped runtimeVersion to `2021.02.24`.
 * Upgraded pana to `0.15.1+1`.
 * Upgraded preview Dart analysis SDK to `2.12.0-259.15.beta`.
 * Upgraded preview Flutter analysis SDK to `1.26.0-17.6.pre`.
 * NOTE: added daily periodic tasks: `delete-old-dartdoc-sdks`,
         `delete-old-search-snapshots`, `delete-old-dartdoc-runs`,
         `delete-expired-dartdoc-runs`, `gc-dartdoc-storage-bucket`.
 * NOTE: Running `git gc` regularly, disk full events (#4458) should decrease.
 * NOTE: started creating `DartdocRun` entities in Datastore.
   TODO(deferred): we may use these entities instead of Bucket objects
                   to scan and load `DartdocEntry`.
 * NOTE: Job processing uses a cached list of available entries.

## `20210215t122000-all`
 * Bumped runtimeVersion to `2021.02.12`.
 * Split: stable Dart analysis SDK to `2.10.5`.
 * Upgraded preview Dart analysis SDK to `2.12.0-259.9.beta`.
 * Split: stable Flutter analysis SDK to `1.22.6`.
 * Upgraded preview Flutter analysis SDK to `1.26.0-17.5.pre`.
 * Deploy `index.yaml` to remove composite index for History.
 * Run `app/bin/tools/remove_history.dart` after the release got deployed.
 * NOTE: added daily periodic tasks: `delete-expired-audit-log-records`,
         `delete-expired-consents`, `delete-expired-sessions`,
         `delete-old-jobs`, `delete-old-scorecards`.
 * Removed all usage of `app/static/js/gtag.js` it can be removed after a few
   runtimeVersions when we are no-longer serving old generated dartdoc files.

## `20210203t120700-all`

## `20210202t151000-all`
 * Bumped runtimeVersion to `2021.01.29`.
 * NOTE: the release starts to create `AuditLogRecord`s for all the existing
         `History` entries. `History` entries could be removed after this release.

## `20210129t103600-all`
 * Bumped runtimeVersion to `2021.01.26`.
 * Upgraded Flutter to `1.25.0-8.3.pre` (beta).
 * NOTE: the release starts to populate preview version fields and runs
         a periodic task to update it.

## `20210119t122300-all`
 * Bumped runtimeVersion to `2021.01.18`.
 * Upgraded dartdoc to `0.39.0`.
 * Run `app/bin/tools/clear_package_properties.dart` after the release got deployed.
   This clears the `download` property in `Package` and `PackageVersion`.
 * Run `app/bin/tools/remove_packageversionpubspec.dart` after the release got deployed.
 * Dartdoc timeout increased for latest stable versions, no more retry on timeout.

## `20210111t165700-all`
 * Bumped runtimeVersion to `2021.01.07`.
 * Upgraded pana to `0.14.10`.
 * NOTE: `downloads` property in `Package` and `PackageVersion` is no longer populated.
   TODO(deferred): schedule cleanup after this release.
 * NOTE: `PackageVersionPubspec` is no longer used or added.
   TODO(deferred): schedule remove the script after this release.

## `20201222t135400-all`
 * Bumped runtimeVersion to `2020.12.21`.
 * Upgraded Dart analysis SDK to `2.12.0-133.2.beta`.
 * Upgraded Flutter to `1.25.0-8.1.pre` (beta).
 * Run `app/bin/tools/backfill_package_fields.dart`.
 * NOTE: `PackageVersionPubspec` is no longer used in dependency graph calculation.
         The next release may remove the use of the entity.
 * NOTE: `PanaReport.pkgDependencies` removed (was deprecated in the previous release).

## `20201210t173100-all`
 * Bumped runtimeVersion to `2020.12.09`.
 * Upgraded dartdoc to `0.38.0`.
 * Using fused json-utf8 converters in JSON API responses and binary
   serialization of JSON blobs in Datastore entities.
 * Run `app/bin/tools/backfill_audit.dart` after the release got deployed.
 * NOTE: `PanaReport` has deprecated `pkgDependencies`.
         The field can be removed after this release is stable.
 * NOTE: added `Package`'s `latestPublished` and `latestPrereleasePublished`.
         TODO(deferred): schedule backfill after this release.
 * NOTE: `downloads` property in `Package` and `PackageVersion` is deprecated
         and no longer `required`.

## `20201126t141046-all`
 * Bumped runtimeVersion to `2020.11.25`.
 * Upgraded pana to `0.14.9`.
 * Run `app/bin/tools/clear_package_properties.dart` after the release got deployed.

## `20201120t114109-all`
 * Bumped runtimeVersion to `2020.11.20`.
 * Upgraded Dart analysis SDK to `2.12.0-51.0.dev`.
 * Upgraded Flutter to `1.24.0-10.2.pre`.
 * Upgraded dartdoc to `0.37.0`.
 * NOTE: `PackageVersion`'s `readme`, `changelog` and `example` fields
         are no longer used (and not updated on uploading a version).
         TODO(deferred): run cleanup after this release.

## `20201118t154758-all`
 * Enable experimental features related to null-safety.
 * Decreased search page cache timeout to 1 minute.

## `20201117t150026-all`
 * Bumped runtimeVersion to `2020.11.17`.
 * Upgraded Dart analysis SDK to `2.12.0-29.0.dev`.
 * Upgraded Flutter to `1.24.0-10.1.pre`.
 * Upgraded pana to `0.14.8`.

## `20201110t141717-all`
 * Bumped runtimeVersion to `2020.11.05`.
 * Upgraded Flutter to `1.22.3`.
 * Upgraded dartdoc to `0.36.2`.
 * Removed `Package.doNotAdvertise`.

## `20201029t121523-all`
 * Bumped runtimeVersion to `2020.10.28`.
 * Upgraded Dart analysis SDK to `2.10.3`.
 * Upgraded pana to `0.14.5`.
 * Package page is rendered using `PackageVersionInfo` and `PackageVersionAsset`.
 * `/api/packages` API no longer returns incorrect 404 (#4192).

## `20201020t163909-all`
 * Bumped runtimeVersion to `2020.10.19`.
 * Upgraded Flutter to `1.22.2`.

## `20201016t121934-all`
 * Bumped runtimeVersion to `2020.10.15`.
 * Upgraded Dart analysis SDK to `2.10.2`.
 * `Package.doNotAdvertise` is no longer a required property.
   Deferred: we should remove it after this is the only release in prod.

## `20201014t110621-all`
 * Bumped runtimeVersion to `2020.10.09`.
 * Upgraded Flutter to `1.22.1`.
 * Upgraded dartdoc to `0.35.0`.

## `20201007t150845-all`
 * Bumped runtimeVersion to `2020.10.06`.
 * Upgraded runtime Dart SDK to `2.10.0`.
 * Upgraded Dart analysis SDK to `2.10.1`.

## `20201001t180935-all`
 * Bumped runtimeVersion to `2020.10.01`.
 * Upgraded Dart analysis SDK to `2.10.0`.
 * Upgraded Flutter to `1.22.0`.
 * Upgraded pana to `0.14.4`.
 * Disabled dependent package trigger for `dartdoc` jobs.

## `20200924t135455-all`
 * Minor fixes to search.

## `20200918t112352-all`
 * Bumped runtimeVersion to `2020.09.16`.
 * Upgraded Flutter to `1.20.4`.
 * Upgraded dartdoc to `0.34.0`.
 * Deferred: 14 days after the release, remove the `UserSession.userIdKey` property.
 * Using new email sending flow, configuration should be tested before switching traffic.

## `20200910t113209-all`
 * Run `app/bin/tools/check_integrity.dart` **before deploying** the new release.
 * Bumped runtimeVersion to `2020.09.09`.
 * Upgraded Dart analysis SDK to `2.9.3`.
 * Upgraded Flutter to `1.20.3`.

## `20200908t122904-all`
 * Run `app/bin/tools/backfill_users.dart` to backfill `User.isBlocked`.
 * Run `app/bin/tools/backfill_package_fields.dart` to backfill `Package.isWithheld`.

## `20200901t143840-all`
 * Bumped runtimeVersion to `2020.09.01`.
 * Upgraded pana to `0.14.3`.
 * Run `app/bin/tools/backfill_package_fields.dart` to backfill `Package.isUnlisted`.

## `20200826t111121-all`
 * Bumped runtimeVersion to `2020.08.25`.
 * Upgraded Flutter to `1.20.2`.
 * Upgraded dartdoc to `0.32.4`.
 * Upgraded pana to `0.14.2`.

## `20200812t113537-all`
 * Bumped runtimeVersion to `2020.08.12`.
 * Upgraded runtime Dart SDK to `2.9.0`.
 * Upgraded Flutter to `1.20.1`.
 * Upgraded dartdoc to `0.32.3`.
 * Upgraded pana to `0.14.1`.
 * Potential memory consumption changes:
   * the SDK seems to consume more memory
   * the `search` index no longer stores the combined text, should need less memory

## `20200806t141051-all`
 * Bumped runtimeVersion to `2020.08.05`.
 * Upgraded Flutter to `1.20.0`.

## `20200804t154113-all`
 * Bumped runtimeVersion to `2020.08.03`.
 * Upgraded Dart analysis SDK to `2.9.0`.
 * Use only Datastore-based DartdocEntry for all user-facing queries.
 * Upgraded dependencies in `app/`.

## `20200723t081306-all`
 * Avoid indexing of `textContent`.

## `20200722t113338-all`
 * Fix font-size regression.

## `20200721t164337-all`
 * Bumped runtimeVersion to `2020.07.21`.
 * Upgraded pana to `0.13.16`
 * Fixed: storing dartdoc entries on `DartdocReport`.
 * `search` removed support for order by `health` and `maintenance`.

## `20200714t110212-all`
 * Enabled new UI by default.
 * Increased diskspace for analyzer and dartdoc to 25 GB

## `20200710t174722-all`
 * Bumped runtimeVersion to `2020.07.10`.
 * Upgraded pana to `0.13.15`

## `20200707t190831-all`
 * Bumped runtimeVersion to `2020.07.07`.
 * Upgraded pana to `0.13.14`
 * `search` supports order by `points`.
 * Updated the session management during sign-in/sign-out flow:
   * Reduce the number of `DELETE /api/account/session` requests (mostly for non-authorized visitors).
   * These should be tested upon deployment.

## `20200702t124059-all`
 * Bumped runtimeVersion to `2020.07.02`.
 * Upgraded pana to `0.13.13`
 * Upgraded Flutter to `1.17.5`.
 * Upgraded `gcloud` to `0.7.3`, using the new `delimiter` to recursively
   delete from storage buckets.
 * `/documentation/` serving changed: content entry lookup first checks Datastore entity.
 * `search` service:
   * uses `Package.likes` as part of the default ranking.
   * index skips updates when task timestamp predates index document.
   * Reduced frequency and concurrency of search snapshot write to storage bucket.
   * Spaced scheduled updates in search index: package update frequency decreases
     after two years (from daily to weekly after 14 years).

## `20200610t120907-all`
 * Bumped runtimeVersion to `2020.06.10`.
 * Upgraded Dart analysis SDK to `2.8.4`.
 * Upgraded Flutter to `1.17.3`.
 * Upgraded dartdoc to `0.32.1`.
 * Upgraded pana to `0.13.9+1`
 * Removed `PackageVersion.sortOrder`.

## `20200529t114421-all`
 * Disabled dartdoc deletion until retention issue has been solved.

## `20200528t100233-all`
 * Bumped runtimeVersion to `2020.05.26`.
 * Upgraded dartdoc to `0.32.0`.

## `20200526t143103-all`
 * Bumped runtimeVersion to `2020.05.15`.
 * Upgraded Dart runtime SDK to `2.8.2`.
 * Upgraded Flutter to `1.17.1`.
 * Deploy `index.yaml` to update index definition for `Like`
   `gcloud datastore indexes create index.yaml`
 * Connection to `redis` is reopened every hour.

## `20200513t104411-all`
 * Bumped runtimeVersion to `2020.05.08`.
 * Upgraded Dart runtime SDK to `2.8.1`.
 * Upgraded Flutter to `1.17.0`.
 * Upgraded package dependencies.

## `20200504t152808-all`
 * Bumped runtimeVersion to `2020.05.03`.
 * Upgraded Dart analysis SDK to `2.8.1`.
 * Upgraded Flutter to `1.17.0-3.4.pre`.
 * Updated pana to `0.13.8`.

## `20200422t171319-all`
 * Bumped runtimeVersion to `2020.04.22`.
 * Upgraded dartdoc to `0.31.0`.

## `20200407t121442-all`
 * Bumped runtimeVersion to `2020.04.07`.
 * Upgraded Flutter to `1.12.13+hotfix.9`.
 * Upgraded dartdoc to `0.30.3`.
 * Updated pana to `0.13.7`.

## `20200324t171808-all`
 * Bumped runtimeVersion to `2020.03.24`.
 * New atom feed ID scheduled to go live at 2020-04-04. Change this hardcoded
   date if the release does not go live before 2020-04-02.
 * Updated pana tot `0.13.6`.

## `20200309t104246-all`
 * Bumped runtimeVersion to `2020.03.09`.
 * Upgraded dartdoc to `0.30.2`.

## `20200304t104107-all`
 * Fix flutter favorite listing.

## `20200302t133833-all`
 * Bumped dependencies.

## `20200224t150327-all`
 * Bumped runtimeVersion to `2020.02.19`.
 * Upgraded Flutter to `1.12.13+hotfix.8`.
 * Upgraded dartdoc to `0.30.1`.

## `20200210t103200-all`
 * Bumped runtimeVersion to `2020.02.07`.
 * Upgraded Flutter to `1.12.13+hotfix.7`.
 * Upgraded pana to `0.13.5`

## `20200127t111331-all`
 * Bumped runtimeVersion to `2020.01.24`.
 * Upgraded runtime SDK to `2.7.1`.

## `20200114t145115-all`
 * Bumped runtimeVersion to `2020.01.13`.
 * Upgraded dartdoc to `0.30.0+1`.
 * Upgraded pana to `0.13.4` (restricted linter rules to `pedantic` `1.8.0`).

## `20191218t150816-all`
 * Upgraded runtime SDK to `2.7.0`.
 * Bumped runtimeVersion to `2019.12.13`.
 * Upgraded Flutter to `1.12.13+hotfix.5`.
 * Upgraded pana to `0.13.2`.
 * Removed the use of `platformTags` from `pana` analysis,
   and also the use of `platform` in search queries (#3167).
* Run `app/bin/tools/backfill_likes.dart` to backfill `Like.packageName`.

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
 * Added 'my liked packages' page behind an experimental flag.

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
 * Minor fixes of JS when the experimental flag is not on.

## `20191007t110314-all`

 * Upgraded to Dart `2.5.0`.
 * Upgraded `package:markdown` to `2.1.0`.
 * Search index contains `publisherId` and `owners` fields, the first startup
   needs to have 1-2 hours before all the packages get re-indexed with them.
   After that, they will be part of the index snapshot and will be available
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
 * Upgraded `pana` (`0.12.18`), runtime, and analysis Dart SDK (`2.3.2`).
 * Bumped runtimeVersion to `2019.06.17`.

## `20190529t163905-all`

 * Upgraded `pana` (`0.12.17`).
 * Bumped runtimeVersion to `2019.05.29`.

## `20190522t135532-all`

 * Removed support for legacy auth tokens (without `user_id`).
   Users with legacy tokens will be requested to login again.
 * Upgraded `pana` (`0.12.16`), Dart SDK (`2.3.1`), and downgraded Flutter SDK (`1.5.4-hotfix.2`).
 * Bumped runtimeVersion to `2019.05.22`.

## `20190508t114341-all`

 * Upgraded `pana` (`0.12.15`), Dart SDK (`2.3.0`), and Flutter SDK (`1.5.8`).
 * Bumped runtimeVersion to `2019.05.07`.

## `20190503t145023-all`

 * Redirect UI traffic to `pub.dev`.
 * Emit `pub.dev` as primary host URL.
 * Bumped runtimeVersion to `2019.05.03` to trigger `dartdoc` content generation with the new primary hosts.

## `20190503t132754-all`

 * Fixed the bug in dynamic OAuth `redirect_uri` calculation.

## `20190502t154607-all`

 * Enabled new design on `pub.dev` (redirects still missing).
 * Dependency graph monitoring in a separate isolate of the `frontend` service.
 * `/feed.atom` changes random seed to generate `UUID` for feed entry.

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

   * OAuth: accept only validated e-mails that look like e-mails (have @, and e-mail-like structure).

## `20190306t115839-all`
 
 * Run `app/bin/tools/backfill_packageversions.dart` to backfill `PubSpec`
   entities in datastore (these entities are not in use yet).
 * Bumped runtimeVersion to `2019.03.05`.
