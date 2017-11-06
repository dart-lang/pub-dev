## 0.1.2+1

- Remove unneeded change to Dart SDK constraint.

## 0.1.2

- Fix a bug in `getSdkDir` (#21)

## 0.1.1

- Updated to the output for indeterminate progress
- Exposed a `Logger.isVerbose` getter

## 0.1.0

- Added a new `getSdkPath()` method to get the location of the SDK (this uses the new
  `Platform.resolvedExecutable` API to locate the SDK)
- Deprecated `getSdkDir()` in favor of `getSdkPath()`
- Add the `cli_logging.dart` library - utilities to display output and progress

## 0.0.1+3

- Find SDK properly when invoked from inside SDK tests.

## 0.0.1+2

- Support an executable in a symlinked directory.

## 0.0.1+1

- Fix for when the dart executable can't be found by `which`.

## 0.0.1

- Initial version
