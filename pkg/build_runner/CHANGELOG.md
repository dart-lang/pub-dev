## 0.5.0

- **Breaking**: Removed `buildType` field from `BuildResult`.
- **Breaking**: `watch` now returns a `ServeHandler` instead of a
  `Stream<BuildResult>`. Use `ServeHandler.buildResults` to get back to the
  original stream.
- **Breaking**: `serve` has been removed. Instead use `watch` and use the
  resulting `ServeHandler.handle` method along with a server created in the
  client script to start a server.
- Prevent reads into `.dart_tool` for more hermetic builds.
- Bug Fix: Rebuild entire asset graph if the build script changes.
- Add `writeToCache` argument to `build` and `watch` which separates generated
  files from the source directory and allows running builders against other
  packages.
- Allow the latest version of `package:shelf`.

## 0.4.0+3

- Bug fix: Don't try to delete files generated for other packages.

## 0.4.0+2

- Bug fix: Don't crash after a Builder reads a file from another package.

## 0.4.0+1

- Depend on `build` 0.10.x and `build_barback` 0.4.x

## 0.4.0

- **Breaking**: The `PhaseGroup` class has been replaced with a
  `List<BuildAction>` in `build`, `watch`, and `serve`. The `PhaseGroup` and
  `Phase` classes are removed.
  If your current build has multiple actions in a single phase which are
  depending on *not* seeing the outputs from other actions in the phase you will
  need to instead set up the `InputSet`s so that the outputs are filtered out.
- **Breaking**: The `resolvers` argument has been removed from `build`, `watch`,
  and `serve`.
- Allow `package:build` v0.10.x

## 0.3.4+1

- Support the latest release of `build_barback`.

## 0.3.4

- Support the latest release of `analyzer`.

## 0.3.2

- Support for build 0.9.0

## 0.3.1+1

- Bug Fix: Update AssetGraph version so builds can be run without manually
  deleting old build directory.
- Bug Fix: Check for unreadable assets in an async method rather than throw
  synchronously

## 0.3.1

- Internal refactoring of RunnerAssetReader.
- Support for build 0.8.0
- Add findAssets on AssetReader implementations
- Limit Asset reads to those which were available at the start of the phase.
  This might cause some reads which uses to succeed to fail.

## 0.3.0

### Bug Fixes

- Fixed a race condition bug [175](https://github.com/dart-lang/build/issues/175)
  that could cause invalid output errors.

### Breaking Changes

- `RunnerAssetWriter` now requires an additional field, `onDelete` which is a
  callback that must be called synchronously within `delete`.

## 0.2.0

Add support for the new bytes apis in `build`.

### New Features

- `FileBasedAssetReader` and `FileBasedAssetWriter` now support reading/writing
  as bytes.

### Breaking Changes

- Removed the `AssetCache`, `CachedAssetReader`, and `CachedAssetWriter`. These
  may come back at a later time if deemed necessary, but for now they just
  complicate things unnecessarily without proven benefits.
- `BuildResult#outputs` now has a type of `List<AssetId>` instead of
  `List<Asset>`, since the `Asset` class no longer exists. Additionally this was
  wasting memory by keeping all output contents around when it's not generally
  a very useful thing outside of tests (which retain this information in other
  ways).

## 0.0.1

- Initial separate release - split off from `build` package.
