[![Build Status](https://github.com/dart-lang/pub-dev/workflows/Dart%20CI/badge.svg)](https://github.com/dart-lang/pub-dev/actions?query=workflow%3A"Dart+CI"+branch%3Amaster)

# Code for the "pub.dev" website.

The server for hosting pub packages on [pub.dev](https://pub.dev)
is implemented using AppEngine Custom Runtimes with Flexible environment
(see [package:appengine](https://pub.dev/packages/appengine) for more information about
Dart support for AppEngine).

If you are looking only for a simple self-hosted site to publish internal package,
see [package:pub_server](https://pub.dev/packages/pub_server), which has
an [example](https://pub.dev/packages/pub_server/example) for running
one using the local filesystem as storage.

## Documentation

- [Development](doc/development.md)
- [Versions](doc/versions.md)
- [Secrets](doc/secrets.md)
- [Search](doc/search.md)
