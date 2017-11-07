## 0.10.2+1

- Fix an issue where multiple `ResourceManager`s would share `Resource`
  instances if running at the same time. 

## 0.10.2

- Added the `MultiPackageAssetReader` interface which allows globbing within
  any package.
  - This is not exposed to typical users, only build system implementations
    need it. The `BuildStep` class does not implement this interface.
- The docs for `AssetReader#findAssets` have changed such that it globs within
  the current package instead of the root package (typically defined as
  `buildStep.inputId.package`).
  - Before you could run builders only on the root package, but now that you
    can run them on any package the old functionality no longer makes sense.

## 0.10.1

- Remove restrictions around the root package when Builders are running. It is
  the responsibility of the build system to ensure that builders are only run on
  inputs that will produce outputs that can be written.
- Added the `Resource` class, and `BuildStep#fetchResource` method.

## 0.10.0+1

- Bug Fix: Capture asynchronous errors during asset writing.

## 0.10.0

- **Breaking**: Removed deprecated method `BuildStep.hasInput` - all uses should
  be going through `BuildStep.canRead`.
- **Breaking**: `Resolver` has asynchronous APIs for resolution and is retrieved
  synchronously from the `BuildStep`.
- **Breaking**:  Replaced `Resolver.getLibrary` with `libraryFor` and
  `getLibraryByName` with `findLibraryByName`.
- Change `AssetReader.canRead` to always return a Future.

## 0.9.3

- Add support for resolving `asset:` URIs into AssetIds
- Add `uri` property on AssetId

## 0.9.1

- Skip Builders which would produce no outputs.

## 0.9.0

- Deprecate `BuildStep.hasInput` in favor of `BuildStep.canRead`.
- Rename `AssetReader.hasInput` as `canRead`. This is breaking for implementers
  of `AssetReader` and for any clients passing a `BuildStep` as an `AssetReader`
- Make `canRead` return a `FutureOr` for more flexibility
- Drop `ManagedBuildStep` class.
- Drop `BuildStep.logger`. All logging should go through the top level `log`.
- `BuildStep.writeAs*` methods now take a `FutureOr` for content. Builders which
  produce content asynchronously can now set up the write without waiting for it
  to resolve.
- **Breaking** `declareOutputs` is replaced with `buildExtensions`. All `Builder`
  implementations must now have outputs that vary only based on the extensions
  of inputs, rather than based on any part of the `AssetId`.

## 0.8.0

- Add `AssetReader.findAssets` to allow listing assets by glob.

## 0.7.3

- Add `BuildStep.inputLibrary` as a convenience.
- Fix a bug in `AssetId.resolve` to prepend `lib/` when resolving packages.

## 0.7.2

- Add an `AssetId.resolve` constructor to easily construct AssetIds from import
  uris.
- Capture 'print' calls inside running builds and automatically turn them in to
  `log.info`. Depending on the environment a print can be hazardous so this
  makes all builders safe and consistent by default.

## 0.7.1+1

- Use comment syntax for generic method - not everyone is on an SDK version that
  supports the real syntax.

## 0.7.1

- Add a top-level `log` getter which is scoped to running builds and can be used
  anywhere within a build rather than passing around a logger. This replaces the
  `BuildStep.logger` field.
- Deprecate `BuildStep.logger` - it is replaced by `log`
- Deprecate `ManagedBuildStep`, all build runs should go through `runBuilders`.

## 0.7.0

A number of changes to the apis, primarily to support reading/writing as bytes,
as this is going to inevitably be a required feature. This will hopefully be the
last breaking change before the `1.0` release, but it is a fairly large one.

### New Features
- The `AssetWriter` class now has a
  `Future writeAsBytes(AssetId id, List<int> bytes)` method.
- The `AssetReader` class now has a `Future<List<int>> readAsBytes(AssetId id)`
  method.
- You no longer need to call `Resolver#release` on any resolvers you get from
  a `BuildStep` (in fact, the `Resolver` interface no longer has this method).
- There is now a `BuildStep#resolver` getter, which resolves the primary input,
  and returns a `Future<Resolver>`. This replaces the `BuildStep#resolve`
  method.
- `Resolver` has a new `isLibrary` method to check whether an asset is a Dart
  library source file before trying to resolve it's LibraryElement

### Breaking Changes
- The `Asset` class has been removed entirely.
- The `AssetWriter#writeAsString` signature has changed to
  `Future writeAsString(AssetId id, String contents, {Encoding encoding})`.
- The type of the `AssetWriterSpy#assetsWritten` getter has changed from an
  `Iterable<Asset>` to an `Iterable<AssetId>`.
- `BuildStep#input` has been changed to `BuildStep#inputId`, and its type has
  changed from `Asset` to `AssetId`. This means you must now use
  `BuildStep#readAsString` or `BuildStep#readAsBytes` to read the primary input,
  instead of it already being read in for you.
- `Resolver` no longer has a `release` method (they are released for you).
- `BuildStep#resolve` no longer exists, and has been replaced with the
  `BuildStep#resolver` getter.
- `Resolver.getLibrary` will now throw a `NonLibraryAssetException` instead of
  return null if it is asked to resolve an impossible library.

**Note**: The changes to `AssetReader` and `AssetWriter` also affect `BuildStep`
and other classes that implement those interfaces.

## 0.6.3

- Add hook for `build_barback` to write assets from a Future

## 0.6.2

- Remove unused dependencies

## 0.6.1

- `BuildStep` now implements `AssetReader` and `AssetWriter` so it's easier to
  share with other code paths using a more limited interface.

## 0.6.0

- **BREAKING** Move some classes and methods out of this package. If you are
  using `build`, `watch`, or `serve`, along with `PhaseGroup` and related
  classes add a dependency on `build_runner`. If you are using
  `BuilderTransformer` or `TansformerBuilder` add a dependency on
  `build_barback`.
- **BREAKING** Resolvers is now an abstract class. If you were using the
  constructor `const Resolvers()` as a default instance import `build_barback`
  and used `const BarbackResolvers()` instead.

## 0.5.0

- **BREAKING** BuilderTransformer must be constructed with a single Builder. Use
  the MultiplexingBuilder to cover cases with a list of builders
- When using a MultiplexingBuilder if multiple Builders have overlapping outputs
  the entire step will not run rather than running builders up to the point
  where there is an overlap

## 0.4.1+3

- With the default logger, print exceptions with a terse stack trace.
- Provide a better error when an inputSet package cannot be found.
- Fix `dev_dependencies` so tests run.

## 0.4.1+2
- Stop using removed argument `useSharedSources` when constructing Resolvers
- Support code_transformers 0.5.x

## 0.4.1+1
- Support analyzer 0.29.x

## 0.4.1
- Support analyzer 0.28.x

## 0.4.0
- **BREAKING** BuilderTransformer must be constructed with a List<Builder>
  rather than inherit and override.
- Simplifies Resolver interface so it is possible to add implementations which
  are less complex than the one from code_transformers.
- Adds a Resolvers class and support for overriding the concrete Resolver that
  is used by build steps.
- Updates some test expectations to match the new behavior of analyzer.

## 0.3.0+6
- Convert `packages` paths in the file watcher to their absolute paths. This
  fixes [#109](https://github.com/dart-lang/build/issues/109).

## 0.3.0+5
- Fix duplicate logs issue when running as a BuilderTransformer.

- Support `crypto` 2.0.0.

## 0.3.0+4
- Add error and stack trace to log messages from the BuilderTransformer.

## 0.3.0+3
- Fixed BuilderTransformer so that logs are passed on to the TransformLogger.

## 0.3.0+2
- Enable serving files outside the server root by default (enables serving
  files from other packages).

## 0.3.0+1
- Fix an AssetGraph bug where generated nodes might be created as non-generated
  nodes if they are attempted to be read from previous build steps.

## 0.3.0
- **BREAKING** Renamed values of three enums to be lower-case:
  `BuildType`, `BuildStatus`, and `PackageDependencyType`.
- Updated to crypto ^1.0.0.
- Added option to resolve additional entry points in `buildStep.resolve`.
- Added option to pass in a custom `Resolvers` instance.

## 0.2.1
- Added the `deleteFilesByDefault` option to all top level methods. This will
  skip the prompt to delete files, and instead act as if you responded `y`.
  - Also by default in a non-console environment the prompt no longer exists and
    it will instead just exit with an error.
- Added support for multiple build scripts. Each script now has its own asset
  graph based on a hash of the script uri.
  - You need to be careful here, as you can get in an infinite loop if two
    separate build scripts keep triggering updates for each other.
  - There is no explicit link between multiple scripts, so they operate as if
    all changes from other scripts were user edits. This will usually just do
    the "right thing", but may result in undesired behavior in some
    circumstances.
- Improved logging for non-posix consoles.

## 0.2.0
- Updated the top level classes to take a `PhaseGroup` instead of a
  `List<List<Phase>>`.
- Added logic to handle nested package directories.
- Basic windows support added, although it may still be unstable.
- Significantly increased the resolving speed by using the same sources cache.
- Added a basic README.
- Moved the `.build` folder to `.dart_tool/build`. Other packages in the future
  may also use this folder.

## 0.1.4
- Added top level `serve` function.
  - Just like `watch`, but it provides a server which blocks on any ongoing
    builds before responding to requests.
- Minor bug fixes.

## 0.1.3
- Builds are now fully incremental, even on startup.
  - Builds will be invalidated if the build script or any of its dependencies
    are updated since there is no way of knowing how that would affect things.
- Added `lastModified` to `AssetReader` (only matters if you implement it).

## 0.1.2
- Exposed the top level `watch` function. This can be used to watch the file
  system and run incremental rebuilds on changes.
  - Initial build is still non-incremental.

## 0.1.1

- Exposed the top level `build` function. This can be used to run builds.
  - For this release all builds are non-incremental, and delete all previous
    build outputs when they start up.
  - Creates a `.build` directory which should be added to your `.gitignore`.
- Added `resolve` method to `BuildStep` which can give you a `Resolver` for an
  `AssetId`.
  - This is experimental and may get moved out to a separate package.
  - Resolves the full dart sdk so this is slow, first call will take multiple
    seconds. Subsequent calls are much faster though.
  - Will end up marking all transitive deps as dependencies, so your files may
    end up being recompiled often when not entirely necessary (once we have
    incremental builds).
- Added `listAssetIds` to `AssetReader` (only matters if you implement it).
- Added `delete` to `AssetWriter` (also only matters if you implement it).

## 0.1.0

- Initial version
