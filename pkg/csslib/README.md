CSS parser library for Dart
==========================

This is a [CSS](https://developer.mozilla.org/en-US/docs/Web/CSS) parser written entirely in [Dart][dart].
It can be used in the client/server/command line.

This package is installed with [Pub][pub], see:
[install instructions](https://pub.dartlang.org/packages/csslib#installing)
for this package.

Usage
-----

Parsing CSS is easy!
```dart
import 'package:csslib/parser.dart';

main() {
  var stylesheet = parse(
      '.foo { color: red; left: 20px; top: 20px; width: 100px; height:200px }');
  print(stylesheet.toDebugString());
}
```

You can pass a String or list of bytes to `parse`.


Running Tests
-------------

Basic tests can be found in this repository:
```bash
pub run test
```

The full CSS test suite can be found in https://github.com/dart-lang/csslib-test-suite
```bash
cd ../csslib-test-suite
./run.sh
```

[dart]: http://www.dartlang.org/
[pub]: http://www.dartlang.org/docs/pub-package-manager/
