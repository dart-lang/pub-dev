@TestOn('vm')
library samples_test;

import 'dart:io';
import 'dart:mirrors';

import 'package:test/test.dart';
import 'package:csslib/parser.dart';

const testOptions = const PreprocessorOptions(
    useColors: false,
    checked: false,
    warningsAsErrors: true,
    inputFile: 'memory');

void testCSSFile(File cssFile) {
  final errors = <Message>[];
  final css = cssFile.readAsStringSync();
  final stylesheet = parse(css, errors: errors, options: testOptions);

  expect(stylesheet, isNotNull);
  expect(errors, isEmpty, reason: errors.toString());
}

main() {
  final libraryUri = currentMirrorSystem().findLibrary(#samples_test).uri;
  final cssDir = new Directory.fromUri(libraryUri.resolve('examples'));
  for (var element in cssDir.listSync())
    if (element is File && element.uri.pathSegments.last.endsWith('.css')) {
      test(element.uri.pathSegments.last, () => testCSSFile(element));
    }
}
