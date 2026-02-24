[![Build Status](https://github.com/dart-lang/pub-dev/workflows/Dart%20CI/badge.svg)](https://github.com/dart-lang/pub-dev/actions?query=workflow%3A"Dart+CI"+branch%3Amaster)

# Code for the "pub.dev" website.

The server for hosting pub packages on [pub.dev](https://pub.dev)
is implemented using AppEngine Custom Runtimes with Flexible environment
(see [package:appengine](https://pub.dev/packages/appengine) for more information about
Dart support for AppEngine).

This code isn't designed with private hosting in mind.
If you need a private hosted environment, you may find some of the suggestions in
[this page](https://dart.dev/tools/pub/custom-package-repositories)
to be helpful.

## Documentation

- [Development](doc/development.md)
- [Versions](doc/versions.md)
- [Search](doc/search.md)
- [Secrets](doc/secrets.md)

## Recent Fixes

### Fix dartdoc crash on pub.dev (#9202)

- Upgraded `dartdoc` to `9.0.3` and `pana` to `0.23.10`.
- Incremented `runtimeVersion` to `2026.02.24` to trigger re-analysis.
- Improved `setup-dartdoc.sh` to ensure consistent AOT compilation.
- This addresses the crash occurring when elements have null library fragments.
