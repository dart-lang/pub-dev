## 0.5.1+3

* Support the latest `cli_util` package.

## 0.5.1+2

* Support the latest `analyzer` package.

## 0.5.1+1

* Updated mock SDK sources to include FutureOr<T> (and fixed a syntax error)

## 0.5.1

* Resolver has a new method which can check whether an Asset is a Dart library
  source

## 0.5.0+2

* Resolver no longer returns a partial LibraryElement for assets which are not
  libraries

## 0.5.0+1

* Stop using deprecated analyzer apis.

## 0.5.0

* Always use a single `Resolver` instance. Fixes an issue where running with the
  'build' package in file watching mode would treat some files as never
  changing.
* Breaking Change: remove the `useSharedSources` argument to Resolvers ctor
  since sources are always shared.

## 0.4.2+4

* Update to work with analyzer 0.29.x and transform_test 0.2.x

## 0.4.2+3

* Update to work with analyzer 0.28.x.

## 0.4.2+2

* Update to work with analyzer 0.23.x.

## 0.4.2+1

* Contains a fix for the `useSharedSources` option that could result in null
  library elements when running on multiple entry points.

## 0.4.2

* Use Strong Mode, fixes
  [#38](https://github.com/dart-lang/code_transformers/issues/38).

## 0.4.1

* Added a fix for [#24890](https://github.com/dart-lang/sdk/issues/24890).
  * All constants in all libraries will once again be resolved by default.
  * Added a new `resolveAllLibraries` option to `Resolver#resolve` and
    `Resolvers#get`. If `false` is passed then constants will not be resolved in
    non entry points. This saves significant time if constants are not needed.
* Added a `useSharedSources` option to `Resolvers`. This gives a significant
  speed increase, but must be used carefully.
  * If used, then all `Resolver` instances created from the same `Resolvers`
    instance will share the same sources cache.
  * This should be generally safe to use if the `Resolvers` instance is created
    in the constructor of your `Transformer`.
  * This option should probably not be used with a static or shared `Resolvers`
    instance.

## 0.4.0

* Remove dependency on `test`, and move all test related apis to a new
  `transformer_test` package which is now a dev dependency.

## 0.3.1

* Update to analyzer `>=0.27.0 <0.28.0`.

## 0.3.0+1

* Upgrade `test` to a real dependency.

## 0.3.0

* Re-release `0.2.10` release as `0.3.0`.

## 0.2.11

* Revert `0.2.10` release, will be re-released as `0.3.0` since it is actually
  a breaking change.

## 0.2.10

* Update to use the `test` package instead of the `unittest` package.

## 0.2.9+4

* Republish 0.2.9+2 under new version.

## 0.2.9+3

* Republish of 0.2.9 to ensure nobody gets 0.2.9+1 in the future.

## 0.2.9+2

* Update to analyzer '>=0.26.0 <0.27.0'

## 0.2.9+1

* Update to analyzer '<0.27.0'
* This version will be reverted as it wasn't compatible with <0.26.0.

## 0.2.9

* Update to analyzer `<=0.26.0`.

## 0.2.8

* Add `benchmarks.dart` file which exposes a `TransformerBenchmark`. This can be
used to implement simple benchmarks of transformer code.

## 0.2.7+2

* Fix `assetIdToUri` on windows,
[41](https://github.com/dart-lang/polymer-dart/issues/41)

## 0.2.7+1

* Fixes for missing overrides after upgrade to analzyer 0.24.0

## 0.2.7

* Added default set of mockSdkSources and upgraded to analyzer 0.24.0

## 0.2.6

* Added `assetIdToUri` to assets.dart.

## 0.2.5
* Improvements to `dartSdkDirectory` so it has a better chance of success.
* `BuildLogger` now accepts `AggregateTransform` or `Transform`. If passing in
an `AggregateTransform` you must also pass in an `AssetId` to use as the primary
input.

## 0.2.4

* Added some basic string formatting options to `testPhases` to make it a bit
  less strict if desired.

## 0.2.3+2

* Added logic to discover the location of the dart SDK when the dart binary is a
  symlink.

## 0.2.3

* Added support for logging stable error messages from transformers.

## 0.2.2

* Added two transformers, 'delete_file' and 'remove_sourcemap_comment'.

## 0.2.0+3

* Raise the lower bound on the source_maps constraint to exclude incompatible
  versions.

## 0.2.0+2

* Widen the constraint on source_maps.

## 0.2.0+1

* Widen the constraint on barback.

## 0.2.0

* Switch from `source_maps`' `Span` class to `source_span`'s `SourceSpan` class.
