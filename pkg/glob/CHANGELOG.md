## 1.1.5

* Declare support for `async` 2.0.0.

* Require Dart 1.23.0.

## 1.1.4

* Throw an exception when listing globs whose initial paths don't exist in
  case-insensitive mode. This matches the case-sensitive behavior.

## 1.1.3

* Support `string_scanner` 1.0.0.

## 1.1.2

* Fix all strong mode errors and warnings.

## 1.1.1

* Fix a bug where listing an absolute glob with `caseInsensitive: false` failed.

## 1.1.0

* Add a `caseSensitive` named parameter to `new Glob()` that controls whether
  the glob is case-sensitive. This defaults to `false` on Windows and `true`
  elsewhere.

  Matching case-insensitively on Windows is a behavioral change, but since it
  more closely matches the semantics of Windows paths it's considered a bug fix
  rather than a breaking change.

## 1.0.5

* Narrow the dependency on `path`. Previously, this allowed versions that didn't
  support all the functionality this package needs.

* Upgrade to the new test runner.

## 1.0.4

* Added overlooked `collection` dependency.

## 1.0.3

* Fix a bug where `Glob.list()` and `Glob.listSync()` would incorrectly throw
  exceptions when a directory didn't exist on the filesystem.

## 1.0.2

* Fixed `Glob.list()` on Windows.

## 1.0.1

* Fix several analyzer warnings.

* Fix the tests on Windows.
