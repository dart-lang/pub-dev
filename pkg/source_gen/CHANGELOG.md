## 0.7.2

* Support an optional `header` argument to `PartBuilder` and `LibraryBuilder`.

## 0.7.1

### `Generator{ForAnnotation}`

* Return type of `generate{ForAnnotatedElement}` is now `FutureOr<String>`.

### `LibraryReader`

* Added `annotatedElements` to return all elements annotated with something.
* Added `classElements` getter for returning all `class`-es in a library.

### `TypeChecker`

* Added `hasAnnotationOf` and `hasAnnotationOfExact`.

### `ConstantReader`

* Added `isAny` (for consistency, but _deprecated_) and `isLiteral`.
* Added `literalValue` as an alias for the now deprecated `anyValue`.
* Allow `literalValue` to return `null` if the value is actually `null`.
* Fixed a bug where a `Symbol` would return as a `String` for `anyValue`.
* Fixed a bug where a `List` and `Map` were not considered literals.

## 0.7.0

* **Breaking changes**: See [the wiki](https://github.com/dart-lang/source_gen/wiki/Migrating-to-0.7.x)
  for help upgrading.
  * `Generator.generate` now operates on a `LibraryReader` rather than being
    called for every `Element` within a library. Generators can iterate over
    elements using `LibraryReader.allElements`. `GeneratorForAnnotation` will
    continue to call `generateForAnnotatedElement` repeatedly for each element.
  * `GeneratorForAnnotation` passes in a `ConstantReader` for the annotation
    instance rather than re-creating it using mirrors.
  * `GeneratorBuilder` is replaced with `PartBuilder` and `LibraryBuilder`
    depending on whether the output is meant to be included in a `part` file.
  * Removed `JsonSerializable` and related classes. These are moved to
    `package:json_serializable`.
  * Removed `lib/builder.dart`. Import through `source_gen.dart` instead.
  * Removed `OutputFormatter` typedef.

* Add `LibraryReader.allElements` - a utility to iterate across all `Element`
  instances contained in Dart library.
* Add `LibraryReader.element` to get back to the `LibraryElement` instance.
* Add `ConstantReader.objectValue` to get back to the `DartObject` instance.
* Add `ConstantReader.peek` to read a value that returns `null` if not found:

```dart
// Tries to read the field "token" first, then "_token".
findTokenField(DartObject o) {
  final reader = new ConstantReader(o);
  final token = o.peek('token') ?? o.read('_token');
}
```

* Add `throwOnUnresolved` optional parameter to `TypeChecker.annotationsOf`,
  `TypeChecker.annotationsOfExact`, `TypeChecker.firstAnnotationOf`, and
  `TypeChecker.firstAnnotationOfExact`. Setting this to `false` will enable you
  to check for matching annotations with incomplete type information (at your
  own risk).
* Builder logs now log the primary inputs `AssetId` instead of the `library`,
  which is more useful for tracking down the actual files.

## 0.6.1+1

* Tighten constraint on `source_span`.

## 0.6.1

* Added `spanForElement`; returns a `SourceSpan` for an analyzer `Element`.
* Logs a _warning_ to the console when a `GeneratorBuilder` outputs a part file
  for a given input, but that input does not define `part 'name.g.dart';`.

## 0.6.0

* **Breaking change**: `TypeChecker#annotationsOf|firstAnnotationOf` now
  returns annotations that are _assignable_ to the `TypeChecker`'s type. As a
  result we've added `#annotationsOfExact|firstAnnotationOfExact` which has the
  old behavior for precise checks.
* `TypeChecker#annotations...`-methods now throw a `StateError` if one or more
  annotations on an element are not resolvable. This is usually a sign of a
  misspelling, missing import, or missing dependency.
* Added `TypeChecker.any`, which delegates to multiple other `TypeChecker`
  implementations when making a type check.

## 0.5.10+1

* Update minimum `analyzer` package to `0.29.10`.

## 0.5.10

* Bug fixes:
  * Do not fail when "library" is omitted but nothing would be output.
  * Do not fail on extensions that don't end in ".dart" (valid use case).

## 0.5.9

* Update the minimum Dart SDK to `1.22.1`.
* Deprecated `builder.dart`: import `source_gen.dart` instead.
* Added `TypeChecker`, a high-level API for performing static type checks:

  ```dart
  import 'package:analyzer/dart/element/type.dart';
  import 'package:source_gen/source_gen.dart';

  void checkType(DartType dartType) {
    // Checks compared to runtime type `SomeClass`.
    print(const TypeChecker.forRuntime(SomeClass).isExactlyType(dartType));

    // Checks compared to a known Url/Symbol:
    const TypeChecker.forUrl('package:foo/foo.dart#SomeClass');

    // Checks compared to another resolved `DartType`:
    const TypeChecker.forStatic(anotherDartType);
  }
  ```

* Failing to add a `library` directive to a library that is being used as a
  generator target that generates partial files (`part of`) is now an explicit
  error that gives a hint on how to name and fix your library:

  ```bash
  > Could not find library identifier so a "part of" cannot be built.
  >
  > Consider adding the following to your source file:
  >
  > "library foo.bar;"
  ```

  In Dart SDK `>=1.25.0` this can be relaxed as `part of` can refer to a path.
  To opt-in, `GeneratorBuilder` now has a new flag, `requireLibraryDirective`.
  Set it to `false`, and also set your `sdk` constraint appropriately:

  ```yaml
    sdk: '>=1.25.0 <2.0.0'
  ```

* Added `LibraryReader`, a utility class for `LibraryElement` that exposes
  high-level APIs, including `findType`, which traverses `export` directives
  for publicly exported types. For example, to find `Generator` from
  `package:source_gen/source_gen.dart`:

  ```dart
  void example(LibraryElement pkgSourceGen) {
    var library = new LibraryReader(pkgSourceGen);

    // Instead of pkgSourceGen.getType('Generator'), which is null.
    library.findType('Generator');
  }
  ```

* Added `ConstantReader`, a high-level API for reading from constant (static)
  values from Dart source code (usually represented by `DartObject` from the
  `analyzer` package):

  ```dart
  abstract class ConstantReader {
    factory ConstantReader(DartObject object) => ...

    // Other methods and properties also exist.

    /// Reads[ field] from the constant as another constant value.
    ConstantReader read(String field);

    /// Reads [field] from the constant as a boolean.
    ///
    /// If the resulting value is `null`, uses [defaultTo] if defined.
    bool readBool(String field, {bool defaultTo()});

    /// Reads [field] from the constant as an int.
    ///
    /// If the resulting value is `null`, uses [defaultTo] if defined.
    int readInt(String field, {int defaultTo()});

    /// Reads [field] from the constant as a string.
    ///
    /// If the resulting value is `null`, uses [defaultTo] if defined.
    String readString(String field, {String defaultTo()});
  }
  ```

## 0.5.8

* Add `formatOutput` optional parameter to the `GeneratorBuilder` constructor.
  This is a lambda of the form `String formatOutput(String originalCode)` which
  allows you do do custom formatting.

## 0.5.7

* Support for package:analyzer 0.30.0

## 0.5.6

* Support for package:build 0.9.0

## 0.5.5

* Support package:build 0.8.x
* Less verbose errors when analyzer fails to resolve the input.

## 0.5.4+3

* Support the latest release of `pkg/dart_style`.

## 0.5.4+2

* Use the new `log` field instead of the deprecated `buildStep.logger`

## 0.5.4+1

* Give more information when `dartfmt` fails.

## 0.5.4

* Update to latest `build`, `build_runner`, and `build_test` releases.

## 0.5.3+2

* BugFix: Always release the Resolver instance, even when generation does not
  run

## 0.5.3+1

* Don't throw when running against a non-library asset and getting no
  LibraryElement

## 0.5.3

* Add matchTypes method. As with anything imported from /src/ this is
  use-at-your-own-risk since it is not guaranteed to be stable
* Internal cleanup
  * Drop some unused utility methods
  * Move cli_util to dev_dependencies
  * Avoid some deprecated analyzer apis
  * Syntax tweaks
  * Drop results.dart which had no usages

## 0.5.2

* Use library URIs (not names) to look up annotations in the mirror system.
* Loosen version constraint to allow package:build version 0.6
* Fix a bug against the latest SDK checking whether List implements Iterable

## 0.5.1+7

* Generate valid strong-mode code for typed lists.

## 0.5.1+6

* Support the latest version of `pkg/build`.

## 0.5.1+5

* Remove "experimental" comment in `README.md`.

## 0.5.1+4

* Support `package:analyzer` 0.29.0

## 0.5.1+3

* Upgrade to be compatible with the breaking changes in analyzer 0.28.0

## 0.5.1+2

* Avoid calling `computeNode()` while instantiating annotation values

## 0.5.1+1

* Support the latest version of `build` package.

## 0.5.1

* Added GeneratorBuilder option isStandalone to generate files that aren't
  part of source file.

## 0.5.0+3

* Fixed multi-line error output.

## 0.5.0+2

* Remove an outdated work-around.

* Make strong-mode clean.

## 0.5.0+1

* Support the latest version of `pkg/build`.

## 0.5.0

* **Breaking**: Switch to the `build` package for running `Generator`s. This
  means that the top level `build` and `generate` functions are no longer
  available, and have been replaced by the top level `build`, `watch`, and
  `serve` functions from the `build` package, and the `GeneratorBuilder` class.
  See `tool/build.dart`, `tool/watch.dart`, and `tool/phases.dart` for usage.

  * Note that the `build` package is experimental, and likely to change.

* **Breaking**: The build package provides an abstraction for reading/writing
  files via the `BuildStep` class, and that is now also provided to
  `Generator#generate` and `GeneratorForAnnotation#generateForAnnotatedElement`
  as a second argument.

* Timestamps are no longer included in generated code.

* There is no longer a need to specify the files related to an individual
  generator via `AssociatedFileSet`. Simply use the `BuildStep` instance to read
  and write files and the `build` package will track any files you read in and
  run incremental rebuilds as necessary.

## 0.4.8

* Added support for `Symbol` and `Type` in annotations.

* Improved error output when unable to create an instance from an annotation.

## 0.4.7+2

* Upgrade to `analyzer '^0.27.1'` and removed a work-around for a fixed
  `analyzer` issue.

## 0.4.7+1

* Upgrade to `analyzer '^0.27.0'`.

## 0.4.7

* `JsonSerializableGenerator` now supports classes with read-only properties.

## 0.4.6

* `JsonSerializable`: Added `JsonKey` annotation.

* Improved output of generation errors and stack traces.

* Require `analyzer '^0.26.2'`.

## 0.4.5+1

* Handle `null` values for `List` properties.

## 0.4.5

* `JsonSerializable`: add support for `List` values.

## 0.4.4+1

* Updated `README.md` to highlight the `build_system` package and de-emphasize
  Dart Editor.

## 0.4.4

* Added `omitGenerateTimestamp` and `followLinks` named args to `build`.

* Added `followLinks` to `generate`.

## 0.4.3+1

* Update tests to use a more reliable method to find the current package root.

## 0.4.3

* Require Dart `1.12`.

* Add implicit support for `.packages`. If the file exists, it is used.
  If not, we fall back to using the `packages` directory.

* Support the latest releases of `analyzer` and `dart_style` packages.

## 0.4.2

* Use `fromJson` if it's defined in a child field.

## 0.4.1

* Match annotations defined in parts. *Thanks, [Greg](https://github.com/greglittlefield-wf)!*

## 0.4.0+1

* Support the latest release of `analyzer` and `args`.

## 0.4.0

* Analysis no longer parses function bodies. This greatly speeds up generation,
  but it could break any usage that needs function bodies.

## 0.3.0+2

* Fixed `README.md`.

## 0.3.0+1

* Updates for move to `dart-lang` org on GitHub.

## 0.3.0

* **BREAKING** Returning a descriptive value from `generate`.

* **BREAKING** Fixed incorrectly named argument `omitGenerateTimestamp`.

* `JsonSerializable`: Handle `dynamic` and `var` as field types.

## 0.2.4

* Added `associatedFileSet` to `Generator`. Allows a generator to specify
  that changes to any file in a directory next to a Dart source file can
  initiate a generation run.

## 0.2.3

* Use `async *`. Requires SDK >= `1.9.0-dev.10`

* Protect against crash during code format.

## 0.2.2

* Added `omitGenerateTimestamp` (incorrectly spelled) named argument to
  `generate` method.

* `Generator.generate` is now called with the `LibraryElement`, too.

## 0.2.1

* Fixed critical bug affecting annotation matching.
  [#35](https://github.com/dart-lang/source_gen/issues/35)

* Started using published `dart_style` package.

## 0.2.0+2

* Tweaks to `JsonGenerator` to address
  [#31](https://github.com/dart-lang/source_gen/issues/31) and
  [#32](https://github.com/dart-lang/source_gen/issues/32)

## 0.2.0+1
* Updated `README.md` with new examples.
* Fixed sub-bullet indenting in `CHANGELOG.md`.

## 0.2.0
* **BREAKING** Moved and renamed JSON serialization classes.
* Added a `JsonLiteral` generator.
* Improved handling and reporting of Generator errors.
* `JsonGenerator`
    * Learned how to use constructor arguments.
    * Learned how to properly handle `DateTime`.

## 0.1.1
* Support for parametrized annotations.
* Add named arguments to `JsonGenerator`.

## 0.1.0+1
* `README.md` updates.

## 0.1.0
* **BREAKING** `Generator.generate` is now async – returns `Future<String>`
* Big update to `README.md`.

## 0.0.1
* Ready for experimentation.

## 0.0.0+1
* First play release.
