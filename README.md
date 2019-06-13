[![Build Status](https://travis-ci.org/dart-lang/pub-dev.svg?branch=master)](https://travis-ci.org/dart-lang/pub-dev)

# Code for the "pub.dev" website.

The server for hosting pub packages on [pub.dev](https://pub.dev)
is implemented using AppEngine Custom Runtimes with Flexible environment
(see [package:appengine](https://pub.dev/packages/appengine) for more information about
Dart support for AppEngine).

If you are looking only for a simple self-hosted site to publish internal package,
see [package:pub_server](https://pub.dev/packages/pub_server), which has
an [example](https://pub.dev/packages/pub_server#-example-tab-) for running
one using the local filesystem as storage.

## Documentation

- [Development](doc/development.md)
- [Versions](doc/versions.md)
- [Deploying](doc/deploying.md)
- [Secrets](doc/secrets.md)
- [Search](doc/search.md)
