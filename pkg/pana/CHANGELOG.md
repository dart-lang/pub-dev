## 0.5.1

* Use a consistent 2 minute timeout for all processes.

* Classify platform as `nowhere` when part of analysis fails.

## 0.5.0

* **Breaking changes**

  * `License` renamed to `LicenseFile`
  * `Summary.license` -> `licenses`: we'll return multiple licenses
  * Removed `LicenseNames.missing`: empty List will indicate no license file

* Greatly expanded and improved license detection.

## 0.4.0

* **Breaking changes**

  * Renamed `AnalyzerIssue` -> `ToolProblem`
    * Renamed `Summary.issues` -> `toolProblems`
    * Renamed `AnalyzerIssue.scope` -> `tool`
    * Renamed `AnalyzerScopes` -> `ToolNames`

  * Renamed `AnalyzerOutput` -> `CodeProblem`
    * Renamed `Summary.analyzerItems` and `DartFileSummary.analyzerItems` -> `codeProblems`

  * Refactored `CodeProblem` (previously `AnalyzerOutput`):
    * Split up `type`, new fields: `severity`, `errorType`, `errorCode`
    * Renamed `error` to `description`

  * Refactored `Fitness`:
    * Renamed `total` -> `magnitude`
    * Removed `value`, using `shortcoming` instead (`value` = `magnitude - shortcoming;`)

  * Refactored `PubSummary`, renamed to `PkgResolution`
    * Moved `pubspec` -> `Summary`
    * Moved `pkgVersion` -> `Pubspec.version`
    * Moved `authors` -> `Pubspec.authors`
    * Merged `packageVersions` and `availableVersions` into `dependencies`
    * Renamed `Summary.pubSummary` -> `pkgResolution`

  * Refactored `platform`:
    * Renamed `PlatformFlags` -> `PlatformNames`
    * Removed most of the platform-related classes, using `DartPlatform` instead

## 0.3.0

* Removed `PlatformSummary.package` in favor of `PlatformSummary.pubspec` of
  (new) type `PubspecPlatform`.

* Renamed `KnownPlatforms` to `PlatformFlags`. Also:
  * Removed `mirrors`, `browser` and `standalone`.
  * Renamed `native` to `dartExtension`.

* `PlatformInfo`
  * Now store `dart:*` references directly in `uses`.
  * `worksInStandalone` renamed to `worksOnServer`.
  * Other `.worksIn*` renamed to `worksOn*`.
  * Added `String get description` which returns a simple `String` description
    of the supported platforms. Examples: `everywhere`, `flutter`, 
    `server, web`, `conflict`.
  * Removed `angular` as a value in `uses`.

## 0.2.4

* Detect native extensions.

* Detect licenses.

## 0.2.3

* Lot's of stability improvements.

* Improvements to error handling.

## 0.2.2

* Lot's of cleanup to JSON output.

* Improved stability.

* Platform detection basics.

## 0.2.1

* Added support for `flutter` packages.

* Expanded analysis to include transitive dependencies.

* Added scoring library.

* Moved the repo to `dart-lang`.

## 0.2.0

* A lot of tweaks. Still under heavy development.

## 0.0.1

* Initial version.
