## 0.12.26

* The `spawnHybridUri()` function now allows root-relative URLs, which are
  interpreted as relative to the root of the package.

## 0.12.25

* Add a `override_platforms` configuration field which allows test platforms'
  settings (such as browsers' executables) to be overridden by the user.

* Add a `define_platforms` configuration field which makes it possible to define
  new platforms that use the same logic as existing ones but have different
  settings.

## 0.12.24+8

* `spawnHybridUri()` now interprets relative URIs correctly in browser tests.

## 0.12.24+7

* Declare support for `async` 2.0.0.

## 0.12.24+6

* Small refactoring to make the package compatible with strong-mode compliant Zone API.
  No user-visible change.

## 0.12.24+5

* Expose a way for tests to forward a `loadException` to the server.

## 0.12.24+4

* Drain browser process `stdout` and `stdin`. This resolves test flakiness, especially in Travis
  with the `Precise` image.

## 0.12.24+3

* Extend `deserializeTimeout`.

## 0.12.24+2

* Only force exit if `FORCE_TEST_EXIT` is set in the environment.

## 0.12.24+1

* Widen version constraint on `analyzer`.

## 0.12.24

* Add a `node` platform for compiling tests to JavaScript and running them on
  Node.js.

## 0.12.23+1

* Remove unused imports. 

## 0.12.23

* Add a `fold_stack_frames` field for `dart_test.yaml`. This will
  allow users to customize which packages' frames are folded.
  
## 0.12.22+2

* Properly allocate ports when debugging Chrome and Dartium in an IPv6-only
  environment.

## 0.12.22+1

* Support `args` 1.0.0.

* Run tear-down callbacks in the same error zone as the test function. This
  makes it possible to safely share `Future`s and `Stream`s between tests and
  their tear-downs.

## 0.12.22

* Add a `retry` option to `test()` and `group()` functions, as well
  as `@Retry()`  annotation for test files and a `retry` 
  configuration field for `dart_test.yaml`.  A test with reties
  enabled will be re-run if it fails for a reason other than a
  `TestFailure`.
  
* Add a `--no-retry` runner flag that disables retries of failing tests.

* Fix a "concurrent modification during iteration" error when calling
  `addTearDown()` from within a tear down.

## 0.12.21

* Add a `doesNotComplete` matcher that asserts that a Future never completes.

* `throwsA()` and all related matchers will now match functions that return
  `Future`s that emit exceptions.

* Respect `onPlatform` for groups.

* Only print browser load errors once per browser.

* Gracefully time out when attempting to deserialize a test suite.

## 0.12.20+13

* Upgrade to package:matcher 0.12.1

## 0.12.20+12

* Now support `v0.30.0` of `pkg/analyzer`

* The test executable now does a "hard exit" when complete to ensure lingering
  isolates or async code don't block completion. This may affect users trying
  to use the Dart service protocol or observatory.

## 0.12.20+11

* Refactor bootstrapping to simplify the test/pub_serve transformer.

## 0.12.20+10

* Refactor for internal tools.

## 0.12.20+9

* Introduce new flag `--chain-stack-traces` to conditionally chain stack traces.

## 0.12.20+8

* Fixed more blockers for compiling with `dev_compiler`.
* Dartfmt the entire repo.

* **Note:** 0.12.20+5-0.12.20+7 were tagged but not officially published.

## 0.12.20+4

* Fixed strong-mode errors and other blockers for compiling with `dev_compiler`.

## 0.12.20+3

* `--pause-after-load` no longer deadlocks with recent versions of Chrome.

* Fix Dartified stack traces for JS-compiled tests run through `pub serve`.

## 0.12.20+2

* Print "[E]" after test failures to make them easier to identify visually and
  via automated search.

## 0.12.20+1

* Tighten the dependency on `stream_channel` to reflect the APIs being used.

* Use a 1024 x 768 iframe for browser tests.

## 0.12.20

* **Breaking change:** The `expect()` method no longer returns a `Future`, since
  this broke backwards-compatibility in cases where a void function was
  returning an `expect()` (such as `void foo() => expect(...)`). Instead, a new
  `expectLater()` function has been added that return a `Future` that completes
  when the matcher has finished running.

* The `verbose` parameter to `expect()` and the `formatFailure()` function are
  deprecated.

## 0.12.19+1

* Make sure asynchronous matchers that can fail synchronously, such as
  `throws*()` and `prints()`, can be used with synchronous matcher operators
  like `isNot()`.

## 0.12.19

* Added the `StreamMatcher` class, as well as several built-in stream matchers:
  `emits()`, `emitsError()`, `emitsDone, mayEmit()`, `mayEmitMultiple()`,
  `emitsAnyOf()`, `emitsInOrder()`, `emitsInAnyOrder()`, and `neverEmits()`.

* `expect()` now returns a Future for the asynchronous matchers `completes`,
  `completion()`, `throws*()`, and `prints()`.

* Add a `printOnFailure()` method for providing debugging information that's
  only printed when a test fails.

* Automatically configure the [`term_glyph`][term_glyph] package to use ASCII
  glyphs when the test runner is running on Windows.

[term_glyph]: https://pub.dartlang.org/packages/term_glyph

* Deprecate the `throws` matcher in favor of `throwsA()`.

* Deprecate the `Throws` class. These matchers should only be constructed via
  `throwsA()`.

## 0.12.18+1

* Fix the deprecated `expectAsync()` function. The deprecation caused it to
  fail to support functions that take arguments.

## 0.12.18

* Add an `addTearDown()` function, which allows tests to register additional
  tear-down callbacks as they're running.

* Add the `spawnHybridUri()` and `spawnHybridCode()` functions, which allow
  browser tests to run code on the VM.

* Fix the new `expectAsync` functions so that they don't produce analysis errors
  when passed callbacks with optional arguments.

## 0.12.17+3

* Internal changes only.

## 0.12.17+2

* Fix Dartium debugging on Windows.

## 0.12.17+1

* Fix a bug where tags couldn't be marked as skipped.

## 0.12.17

* Deprecate `expectAsync` and `expectAsyncUntil`, since they currently can't be
  made to work cleanly in strong mode. They are replaced with separate methods
  for each number of callback arguments:
    * `expectAsync0`, `expectAsync1`, ... `expectAsync6`, and
    * `expectAsyncUntil0`, `expectAsyncUntil1`, ... `expectAsyncUntil6`.

## 0.12.16

* Allow tools to interact with browser debuggers using the JSON reporter.

## 0.12.15+12

* Fix a race condition that could cause the runner to stall for up to three
  seconds after completing.

## 0.12.15+11

* Make test iframes visible when debugging.

## 0.12.15+10

* Throw a better error if a group body is asynchronous.

## 0.12.15+9

* Widen version constraint on `analyzer`.

## 0.12.15+8

* Make test suites with thousands of tests load much faster on the VM (and
  possibly other platforms).

## 0.12.15+7

* Fix a bug where tags would be dropped when `on_platform` was defined in a
  config file.

## 0.12.15+6

* Fix a broken link in the `--help` documentation.

## 0.12.15+5

* Internal-only change.

## 0.12.15+4

* Widen version constraint on `analyzer`.

## 0.12.15+3

* Move `nestingMiddleware` to `lib/src/util/path_handler.dart` to enable a
  cleaner separation between test-runner files and test writing files.

## 0.12.15+2

* Support running without a `packages/` directory.

## 0.12.15+1

* Declare support for version 1.19 of the Dart SDK.

## 0.12.15

* Add a `skip` parameter to `expect()`. Marking a single expect as skipped will
  cause the test itself to be marked as skipped.

* Add a `--run-skipped` parameter and `run_skipped` configuration field that
  cause tests to be run even if they're marked as skipped.

## 0.12.14+1

* Narrow the constraint on `yaml`.

## 0.12.14

* Add test and group location information to the JSON reporter.

## 0.12.13+5

* Declare support for version 1.18 of the Dart SDK.

* Use the latest `collection` package.

## 0.12.13+4

* Compatibility with an upcoming release of the `collection` package.

## 0.12.13+3

* Internal changes only.

## 0.12.13+2

* Fix all strong-mode errors and warnings.

## 0.12.13+1

* Declare support for version 1.17 of the Dart SDK.

## 0.12.13

* Add support for a global configuration file. On Windows, this file defaults to
  `%LOCALAPPDATA%\DartTest.yaml`. On Unix, it defaults to `~/.dart_test.yaml`.
  It can also be explicitly set using the `DART_TEST_CONFIG` environment
  variable. See [the configuration documentation][global config] for details.

* The `--name` and `--plain-name` arguments may be passed more than once, and
  may be passed together. A test must match all name constraints in order to be
  run.

* Add `names` and `plain_names` fields to the package configuration file. These
  allow presets to control which tests are run based on their names.

* Add `include_tags` and `exclude_tags` fields to the package configuration
  file. These allow presets to control which tests are run based on their tags.

* Add a `pause_after_load` field to the package configuration file. This allows
  presets to enable debugging mode.

[global config]: https://github.com/dart-lang/test/blob/master/doc/configuration.md#global-configuration

## 0.12.12

* Add support for [test presets][]. These are defined using the `presets` field
  in the package configuration file. They can be selected by passing `--preset`
  or `-P`, or by using the `add_presets` field in the package configuration
  file.

* Add an `on_os` field to the package configuration file that allows users to
  select different configuration for different operating systems.

* Add an `on_platform` field to the package configuration file that allows users
  to configure all tests differently depending on which platform they run on.

* Add an `ios` platform selector variable. This variable will only be true when
  the `test` executable itself is running on iOS, not when it's running browser
  tests on an iOS browser.

[test presets]: https://github.com/dart-lang/test/blob/master/doc/package_config.md#configuration-presets

## 0.12.11+2

* Update to `shelf_web_socket` 0.2.0.

## 0.12.11+1

* Purely internal change.

## 0.12.11

* Add a `tags` field to the package configuration file that allows users to
  provide configuration for specific tags.

* The `--tags` and `--exclude-tags` command-line flags now allow
  [boolean selector syntax][]. For example, you can now pass `--tags "(chrome ||
  firefox) && !slow"` to select quick Chrome or Firefox tests.

[boolean selector syntax]: https://github.com/dart-lang/boolean_selector/blob/master/README.md

## 0.12.10+2

* Re-add help output separators.

* Tighten the constraint on `args`.

## 0.12.10+1

* Temporarily remove separators from the help output. Version 0.12.8 was
  erroneously released without an appropriate `args` constraint for the features
  it used; this version will help ensure that users who can't use `args` 0.13.1
  will get a working version of `test`.

## 0.12.10

* Add support for a package-level configuration file called `dart_test.yaml`.

## 0.12.9

* Add `SuiteEvent` to the JSON reporter, which reports data about the suites in
  which tests are run.

* Add `AllSuitesEvent` to the JSON reporter, which reports the total number of
  suites that will be run.

* Add `Group.testCount` to the JSON reporter, which reports the total number of
  tests in each group.

## 0.12.8

* Organize the `--help` output into sections.

* Add a `--timeout` flag.

## 0.12.7

* Add the ability to re-run tests while debugging. When the browser is paused at
  a breakpoint, the test runner will open an interactive console on the command
  line that can be used to restart the test.

* Add support for passing any object as a description to `test()` and `group()`.
  These objects will be converted to strings.

* Add the ability to tag tests. Tests with specific tags may be run by passing
  the `--tags` command-line argument, or excluded by passing the
  `--exclude-tags` parameter.

  This feature is not yet complete. For now, tags are only intended to be added
  temporarily to enable use-cases like [focusing][] on a specific test or group.
  Further development can be followed on [the issue tracker][issue 16].

* Wait for a test's tear-down logic to run, even if it times out.

[focusing]: http://jasmine.github.io/2.1/focused_specs.html
[issue 16]: https://github.com/dart-lang/test/issues/16

## 0.12.6+2

* Declare compatibility with `http_parser` 2.0.0.

## 0.12.6+1

* Declare compatibility with `http_multi_server` 2.0.0.

## 0.12.6

* Add a machine-readable JSON reporter. For details, see
  [the protocol documentation][json-protocol].

* Skipped groups now properly print skip messages.

[json-protocol]: https://github.com/dart-lang/test/blob/master/json_reporter.md

## 0.12.5+2

* Declare compatibility with Dart 1.14 and 1.15.

## 0.12.5+1

* Fixed a deadlock bug when using `setUpAll()` and `tearDownAll()`.

## 0.12.5

* Add `setUpAll()` and `tearDownAll()` methods that run callbacks before and
  after all tests in a group or suite. **Note that these methods are for special
  cases and should be avoided**—they make it very easy to accidentally introduce
  dependencies between tests. Use `setUp()` and `tearDown()` instead if
  possible.

* Allow `setUp()` and `tearDown()` to be called multiple times within the same
  group.

* When a `tearDown()` callback runs after a signal has been caught, it can now
  schedule out-of-band asynchronous callbacks normally rather than having them
  throw exceptions.

* Don't show package warnings when compiling tests with dart2js. This was
  accidentally enabled in 0.12.2, but was never intended.

## 0.12.4+9

* If a `tearDown()` callback throws an error, outer `tearDown()` callbacks are
  still executed.

## 0.12.4+8

* Don't compile tests to JavaScript when running via `pub serve` on Dartium or
  content shell.

## 0.12.4+7

* Support `http_parser` 1.0.0.

## 0.12.4+6

* Fix a broken link in the README.

## 0.12.4+5

* Internal changes only.

## 0.12.4+4

* Widen the Dart SDK constraint to include `1.13.0`.

## 0.12.4+3

* Make source maps work properly in the browser when not using `--pub-serve`.

## 0.12.4+2

* Fix a memory leak when running many browser tests where old test suites failed
  to be unloaded when they were supposed to.

## 0.12.4+1

* Require Dart SDK >= `1.11.0` and `shelf` >= `0.6.0`, allowing `test` to remove
  various hacks and workarounds.

## 0.12.4

* Add a `--pause-after-load` flag that pauses the test runner after each suite
  is loaded so that breakpoints and other debugging annotations can be added.
  Currently this is only supported on browsers.

* Add a `Timeout.none` value indicating that a test should never time out.

* The `dart-vm` platform selector variable is now `true` for Dartium and content
  shell.

* The compact reporter no longer prints status lines that only update the clock
  if they would get in the way of messages or errors from a test.

* The expanded reporter no longer double-prints the descriptions of skipped
  tests.

## 0.12.3+9

* Widen the constraint on `analyzer` to include `0.26.0`.

## 0.12.3+8

* Fix an uncaught error that could crop up when killing the test runner process
  at the wrong time.

## 0.12.3+7

* Add a missing dependency on the `collection` package.

## 0.12.3+6

**This version was unpublished due to [issue 287][].**

* Properly report load errors caused by failing to start browsers.

* Substantially increase browser timeouts. These timeouts are the cause of a lot
  of flakiness, and now that they don't block test running there's less harm in
  making them longer.

## 0.12.3+5

**This version was unpublished due to [issue 287][].**

* Fix a crash when skipping tests because their platforms don't match.

## 0.12.3+4

**This version was unpublished due to [issue 287][].**

* The compact reporter will update the timer every second, rather than only
  updating it occasionally.

* The compact reporter will now print the full, untruncated test name before any
  errors or prints emitted by a test.

* The expanded reporter will now *always* print the full, untruncated test name.

## 0.12.3+3

**This version was unpublished due to [issue 287][].**

* Limit the number of test suites loaded at once. This helps ensure that the
  test runner won't run out of memory when running many test suites that each
  load a large amount of code.

## 0.12.3+2

**This version was unpublished due to [issue 287][].**

[issue 287]: https://github.com/dart-lang/test/issues/287

* Improve the display of syntax errors in VM tests.

* Work around a [Firefox bug][]. Computed styles now work in tests on Firefox.

[Firefox bug]: https://bugzilla.mozilla.org/show_bug.cgi?id=548397

* Fix a bug where VM tests would be loaded from the wrong URLs on Windows (or in
  special circumstances on other operating systems).

## 0.12.3+1

* Fix a bug that caused the test runner to crash on Windows because symlink
  resolution failed.

## 0.12.3

* If a future matched against the `completes` or `completion()` matcher throws
  an error, that error is printed directly rather than being wrapped in a
  string. This allows such errors to be captured using the Zone API and improves
  formatting.

* Improve support for Polymer tests. This fixes a flaky time-out error and adds
  support for Dartifying JavaScript stack traces when running Polymer tests via
  `pub serve`.

* In order to be more extensible, all exception handling within tests now uses
  the Zone API.

* Add a heartbeat to reset a test's timeout whenever the test interacts with the
  test infrastructure.

* `expect()`, `expectAsync()`, and `expectAsyncUntil()` throw more useful errors
  if called outside a test body.

## 0.12.2

* Convert JavaScript stack traces into Dart stack traces using source maps. This
  can be disabled with the new `--js-trace` flag.

* Improve the browser test suite timeout logic to avoid timeouts when running
  many browser suites at once.

## 0.12.1

* Add a `--verbose-trace` flag to include core library frames in stack traces.

## 0.12.0

### Test Runner

`0.12.0` adds support for a test runner, which can be run via `pub run
test:test` (or `pub run test` in Dart 1.10). By default it runs all files
recursively in the `test/` directory that end in `_test.dart` and aren't in a
`packages/` directory.

The test runner supports running tests on the Dart VM and many different
browsers. Test files can use the `@TestOn` annotation to declare which platforms
they support. For more information on this and many more new features, see [the
README](README).

[README]: https://github.com/dart-lang/test/blob/master/README.md

### Removed and Changed APIs

As part of moving to a runner-based model, most test configuration is moving out
of the test file and into the runner. As such, many ancillary APIs have been
removed. These APIs include `skip_` and `solo_` functions, `Configuration` and
all its subclasses, `TestCase`, `TestFunction`, `testConfiguration`,
`formatStacks`, `filterStacks`, `groupSep`, `logMessage`, `testCases`,
`BREATH_INTERVAL`, `currentTestCase`, `PASS`, `FAIL`, `ERROR`, `filterTests`,
`runTests`, `ensureInitialized`, `setSoloTest`, `enableTest`, `disableTest`, and
`withTestEnvironment`.

`FailureHandler`, `DefaultFailureHandler`, `configureExpectFailureHandler`, and
`getOrCreateExpectFailureHandler` which used to be exported from the `matcher`
package have also been removed. They existed to enable integration between
`test` and `matcher` that has been streamlined.

A number of APIs from `matcher` have been into `test`, including: `completes`,
`completion`, `ErrorFormatter`, `expect`,`fail`, `prints`, `TestFailure`,
`Throws`, and all of the `throws` methods. Some of these have changed slightly:

* `expect` no longer has a named `failureHandler` argument.

* `expect` added an optional `formatter` argument.

* `completion` argument `id` renamed to `description`.

##0.11.6+4

* Fix some strong mode warnings we missed in the `vm_config.dart` and
  `html_config.dart` libraries.

##0.11.6+3

* Fix a bug introduced in 0.11.6+2 in which operator matchers broke when taking
  lists of matchers.

##0.11.6+2

* Fix all strong mode warnings.

##0.11.6+1

* Give tests more time to start running.

##0.11.6

* Merge in the last `0.11.x` release of `matcher` to allow projects to use both
  `test` and `unittest` without conflicts.

* Fix running individual tests with `HtmlIndividualConfiguration` when the test
  name contains URI-escaped values and is provided with the `group` query
  parameter.

##0.11.5+1

* Internal code cleanups and documentation improvements.

##0.11.5

* Bumped the version constraint for `matcher`.

##0.11.4

* Bump the version constraint for `matcher`.

##0.11.3

* Narrow the constraint on matcher to ensure that new features are reflected in
  unittest's version.

##0.11.2

* Prints a warning instead of throwing an error when setting the test
  configuration after it has already been set. The first configuration is always
  used.

##0.11.1+1

* Fix bug in withTestEnvironment where test cases were not reinitialized if
  called multiple times.

##0.11.1

* Add `reason` named argument to `expectAsync` and `expectAsyncUntil`, which has
  the same definition as `expect`'s `reason` argument.
* Added support for private test environments.

##0.11.0+6

* Refactored package tests.

##0.11.0+5

* Release test functions after each test is run.

##0.11.0+4

* Fix for [20153](https://code.google.com/p/dart/issues/detail?id=20153)

##0.11.0+3

* Updated maximum `matcher` version.

##0.11.0+2

*  Removed unused files from tests and standardized remaining test file names.

##0.11.0+1

* Widen the version constraint for `stack_trace`.

##0.11.0

* Deprecated methods have been removed:
    * `expectAsync0`, `expectAsync1`, and `expectAsync2` - use `expectAsync`
      instead
    * `expectAsyncUntil0`, `expectAsyncUntil1`, and `expectAsyncUntil2` - use
      `expectAsyncUntil` instead
    * `guardAsync` - no longer needed
    * `protectAsync0`, `protectAsync1`, and `protectAsync2` - no longer needed
* `matcher.dart` and `mirror_matchers.dart` have been removed. They are now in
  the `matcher` package.
* `mock.dart` has been removed. It is now in the `mock` package.

##0.10.1+2

* Fixed deprecation message for `mock`.

##0.10.1+1

* Fixed CHANGELOG
* Moved to triple-slash for all doc comments.

##0.10.1

* **DEPRECATED**
    * `matcher.dart` and `mirror_matchers.dart` are now in the `matcher`
      package.
    * `mock.dart` is now in the `mock` package.
* `equals` now allows a nested matcher as an expected list element or map value
  when doing deep matching.
* `expectAsync` and `expectAsyncUntil` now support up to 6 positional arguments
  and correctly handle functions with optional positional arguments with default
  values.

##0.10.0

* Each test is run in a separate `Zone`. This ensures that any exceptions that
occur is async operations are reported back to the source test case.
* **DEPRECATED** `guardAsync`, `protectAsync0`, `protectAsync1`,
and `protectAsync2`
    * Running each test in a `Zone` addresses the need for these methods.
* **NEW!** `expectAsync` replaces the now deprecated `expectAsync0`,
    `expectAsync1` and `expectAsync2`
* **NEW!** `expectAsyncUntil` replaces the now deprecated `expectAsyncUntil0`,
    `expectAsyncUntil1` and `expectAsyncUntil2`
* `TestCase`:
    * Removed properties: `setUp`, `tearDown`, `testFunction`
    * `enabled` is now get-only
    * Removed methods: `pass`, `fail`, `error`
* `interactive_html_config.dart` has been removed.
* `runTests`, `tearDown`, `setUp`, `test`, `group`, `solo_test`, and
  `solo_group` now throw a `StateError` if called while tests are running.
* `rerunTests` has been removed.
