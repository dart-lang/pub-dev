## 0.12.1+4

* Fixed SDK constraint to allow edge builds.

## 0.12.1+3

* Make `predicate` and `pairwiseCompare` generic methods to allow typed
 functions to be passed to them as arguments.

* Make internal implementations take better advantage of type promotion to avoid
  dynamic call overhead.

## 0.12.1+2

* Fixed small documentation issues.

* Fixed small issue in `StringEqualsMatcher`.

* Update to support future Dart language changes.

## 0.12.1+1

* Produce a better error message when a `CustomMatcher`'s feature throws.

## 0.12.1

* Add containsAllInOrder matcher for Iterables

## 0.12.0+2

* Fix all strong-mode warnings.

## 0.12.0+1

* Fix test files to use `test` instead of `unittest` pkg.

## 0.12.0

* Moved a number of members to the
  [`unittest`](https://pub.dartlang.org/packages/unittest) package.
  * `TestFailure`, `ErrorFormatter`, `expect`, `fail`, and 'wrapAsync'.
  * `completes`, `completion`, `throws`, and `throwsA` Matchers.
  * The `Throws` class.
  * All of the `throws...Error` Matchers.

* Removed `FailureHandler`, `DefaultFailureHandler`,
  `configureExpectFailureHandler`, and `getOrCreateExpectFailureHandler`.
  Now that `expect` is in the `unittest` package, these are no longer needed.

* Removed the `name` parameter for `isInstanceOf`. This was previously
  deprecated, and is no longer necessary since all language implementations now
  support converting the type parameter to a string directly.

## 0.11.4+6

* Fix a bug introduced in 0.11.4+5 in which operator matchers broke when taking
  lists of matchers.

## 0.11.4+5

* Fix all strong-mode warnings.

## 0.11.4+4

* Deprecate the name parameter to `isInstanceOf`. All language implementations
  now support converting the type parameter to a string directly.

## 0.11.4+3

* Fix the examples for `equalsIgnoringWhitespace`.

## 0.11.4+2

* Improve the formatting of strings that contain unprintable ASCII characters.

## 0.11.4+1

* Correctly match and print `String`s containing characters that must be
  represented as escape sequences.

## 0.11.4

* Remove the type checks in the `isEmpty` and `isNotEmpty` matchers and simply
  access the `isEmpty` respectively `isNotEmpty` fields. This allows them to
  work with custom collections. See [Issue
  21792](https://code.google.com/p/dart/issues/detail?id=21792) and [Issue
  21562](https://code.google.com/p/dart/issues/detail?id=21562)

## 0.11.3+1

* Fix the `prints` matcher test on dart2js.

## 0.11.3

* Add a `prints` matcher that matches output a callback emits via `print`.

## 0.11.2

* Add an `isNotEmpty` matcher.

## 0.11.1+1

* Refactored libraries and tests.

* Fixed spelling mistake.

## 0.11.1

* Added `isNaN` and `isNotNaN` matchers.

## 0.11.0

* Removed deprecated matchers.

## 0.10.1+1

* Get the tests passing when run on dart2js in minified mode.

## 0.10.1

* Compare sets order-independently when using `equals()`.

## 0.10.0+3

* Removed `@deprecated` annotation on matchers due to 
[Issue 19173](https://code.google.com/p/dart/issues/detail?id=19173)

## 0.10.0+2

* Added types to a number of constants.

## 0.10.0+1

* Matchers related to bad language use have been removed. These represent code
structure that should rarely or never be validated in tests.
    * `isAbstractClassInstantiationError`
    * `throwsAbstractClassInstantiationError`
    * `isFallThroughError`
    * `throwsFallThroughError`

* Added types to a number of method arguments.

* The structure of the library and test code has been updated.
