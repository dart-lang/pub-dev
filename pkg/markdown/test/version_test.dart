import 'dart:io';
import 'dart:mirrors';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

// Locate the "tool" directory. Use mirrors so that this works with the test
// package, which loads this suite into an isolate.
String get _currentDir => p
    .dirname((reflect(main) as ClosureMirror).function.location.sourceUri.path);

void main() {
  test('check versions', () {
    var binary = p.normalize(p.join(_currentDir, '..', 'bin/markdown.dart'));
    var result = Process.runSync('dart', [binary, '--version']);
    expect(result.exitCode, 0);

    var binVersion = (result.stdout as String).trim();

    var pubspecFile = p.normalize(p.join(_currentDir, '..', 'pubspec.yaml'));

    var pubspecContent =
        loadYaml(new File(pubspecFile).readAsStringSync()) as YamlMap;

    expect(binVersion, pubspecContent['version'],
        reason: 'The version reported by bin/markdown.dart '
            'should match the version in pubspec.');
  });
}
