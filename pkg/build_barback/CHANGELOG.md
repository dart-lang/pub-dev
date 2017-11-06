## 0.4.0+1

- Use a single `ResourceManager` for all calls to `runBuilder` in
  `BuilderTransformer`. This makes `Resource`s be shared across all build
  steps for a given package and Builder.

## 0.4.0

- **Breaking**: Resolver interface updated for breaking change in
  `package:build` v0.10.0

## 0.3.0

- **Breaking** `BuilderTransformer` is now an `AggregateTransformer`. This
  should be transparent for most use cases but could have errors if an instance
  was assigned to a variable of type `Transformer`.
- **Breaking** `BuilderTransformer` no longer accepts a `Resolvers` instance,
  instead it will create and manage Resolvers on its own.

## 0.2.0

- Update to build 0.9.0
- **Breaking** `TransformerBuilder` must be constructed with a `buildExtension`
  configuration. Transformers wrapped as a builder must have outputs which vary
  only by input extension.

## 0.1.2

- Only use the global log from `build`
- Upgrade to build 0.8.0

## 0.1.1

- Support the global log from `build`

## 0.1.0

Updated to reflect the new support for reading/writing as bytes in the `build`
package, and the removal of the `Asset` class.

### New Features
- `BuilderTransformer` now supports wrapping transformers that read or write
  their inputs as bytes.
- The Resolver implementation now has `isLibrary` to check whether an Asset is a
  Library and throws an exception rather than returns null on `getLibrary` when
  it isn't

### Breaking Changes
- Stopped exporting `lib/src/util/barback.dart` which contains internal only
  utilities. Specifically, the following items are no longer public (some are
  deleted entirely or had breaking changes as well):
  - `toBarbackAsset`
  - `toBarbackAssetId`
  - `toBarbackTransform`
  - `toBuildAsset`
  - `toBuildAssetId`
  - `toTransformLogger`
  - `BuildStepTransform`

## 0.0.3

- Prevent asset writing from escaping beyond the `complete()` call in
  BuildStepImpl

## 0.0.2

- Fix a bug forwarding logs from a `BuilderTransformer`

## 0.0.1

- Initial separate release - split off from `build` package.
