# Versions

The canonical source for versioned dependencies are listed in
[versions.dart](https://github.com/dart-lang/pub-dartlang-dart/blob/master/app/lib/shared/versions.dart).

## Dependencies

The dependencies of the pub site are somewhat independent:

- *direct runtime dependencies*:
  - the Dart SDK that is used to run the pub site and services
  - the package dependencies defined in `app/pubspec.yaml`
    - `pana` (used for package analysis) is part of these
  
- *tool environment dependencies*:
  - the Dart SDK that is used to run the package analysis
  - the Flutter SDK that is used to run the package analysis for Flutter packages
  - the `dartdoc` version (used in `pkg/pub_dartdoc`)

## Runtime version

The `runtimeVersion` is an point-in-time identifier that allows us to
reference the independently moving dependencies in a predictable way:
- it follows the semantic version syntax (`x.y.z`), but:
- `yyyy.MM.dd` date format is used to describe the point-in-time,
  allowing us to compare to versions by using String comparison.

There is no compatibility assumption between versions. It is now used
to separate some of the calculated data between different runtimes,
reducing the probability of incompatibility issues, and also to
provide an easier upgrade path.

## Version upgrades

Core dependency changes should have involve a change of the `versions.dart` file:
- `pana` version,
- tool environment (Dart SDK and Flutter SDK),
- `dartdoc` version in `pkg/pub_dartdoc`,
- customization changes (e.g. dartdoc template updates).

On each change, the `runtimeVersion` should be updated. There is a test in
`versions_test.dart` that calculates the hash of all the version, and it
will fail if any one of them changes. The test is a reminder that we should
also change the `runtimeVersion`.

Some version upgrades doesn't need to modify other files (e.g. Flutter version
or dartdoc customization), while others need to be updated at different places
(e.g. `pana` or `dartdoc` version). The later items need to have a documentation
to keep it in-sync with the other places, and also tests that should check the
related files.

## Cleanup of old/stale data

We've started to track the `runtimeVersion` that is the earliers (oldest) data
we'd like to preserve: `gcBeforeRuntimeVersion`.

Service processes should check this version, and delete stale data that is
generated before the specified version.
