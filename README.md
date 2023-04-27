[![Build Status](https://github.com/dart-lang/pub-dev/workflows/Dart%20CI/badge.svg)](https://github.com/dart-lang/pub-dev/actions?query=workflow%3A"Dart+CI"+branch%3Amaster)

# Code for the "pub.dev" website.

The server for hosting pub packages on [pub.dev](https://pub.dev)
is implemented using AppEngine Custom Runtimes with Flexible environment
(see [package:appengine](https://pub.dev/packages/appengine) for more information about
Dart support for AppEngine).

This code isn't designed with private hosting in mind. 
If you need a private hosted environment, you may find some of the suggestions in
[this StackOverflow answer](https://stackoverflow.com/questions/54143695/how-to-use-my-dart-packages-private-and-not-show-on-pub-dart-lang)
to be helpful.

## Documentation

- [Development](doc/development.md)
- [Versions](doc/versions.md)
- [Secrets](doc/secrets.md)
- [Search](doc/search.md)
