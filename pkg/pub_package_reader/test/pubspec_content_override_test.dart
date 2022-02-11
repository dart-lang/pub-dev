// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_package_reader/src/pubspec_content_override.dart';
import 'package:test/test.dart';

void main() {
  group('strict versions', () {
    String pubspec({
      String version = '1.2.0',
      String? sdk,
      String? pathDep,
      String? testDep,
      String? overrideDep,
    }) {
      return [
        'name: mocktail',
        'version: $version',
        if (sdk != null) 'environment:\n  sdk: $sdk',
        if (pathDep != null) 'dependencies:\n  path: $pathDep',
        if (testDep != null)
          'dev_dependencies:\n  test:\n    version: $testDep',
        if (overrideDep != null) 'dependency_overrides:\n  http: $overrideDep',
      ].join('\n');
    }

    String tryOverride(String content) {
      return overridePubspecYamlIfNeeded(
        pubspecYaml: content,
        published: DateTime(2021, 1, 1),
      );
    }

    test('version, no change', () {
      expect(tryOverride(pubspec()), pubspec());
    });

    test('version, update', () {
      final updated = tryOverride(pubspec(version: '1,3.0+1'));
      expect(updated, contains('version: 1.3.0+1'));
      expect(updated, isNot(contains('version: 1,3.0+1')));
    });

    test('sdk, no change', () {
      final content = pubspec(sdk: '">=2.10.0 <3.0.0"');
      final updated = tryOverride(content);
      expect(updated, content);
    });

    test('sdk any', () {
      final content = pubspec(sdk: 'any');
      final updated = tryOverride(content);
      expect(updated, content);
    });

    test('sdk, updated', () {
      final wrong = '">=2,10,0-0 <3,0.0"';
      final content = pubspec(sdk: wrong);
      final updated = tryOverride(content);
      expect(updated, contains('sdk: ">=2.10.0-0 <2.17.0"'));
      expect(updated, isNot(contains('sdk: $wrong')));
    });

    test('dependency, no change', () {
      final content = pubspec(testDep: '^3.0.1+12');
      final updated = tryOverride(content);
      expect(updated, content);
    });

    test('dependency, updated', () {
      final wrong = '^3.0,1+12';
      final content = pubspec(testDep: wrong);
      final updated = tryOverride(content);
      expect(updated, contains('version: ^3.0.1+12'));
      expect(updated, isNot(contains('version: $wrong')));
    });

    test('everything, no change', () {
      final content = pubspec(
        sdk: '">=2.12.0-0 <3.0.0+1"',
        pathDep: '^1.0.0',
        testDep: 'any',
        overrideDep: '2.1.0-dev1',
      );
      expect(tryOverride(content), content);
    });

    test('everything, updated', () {
      final content = pubspec(
        version: '123-5',
        sdk: '">=2y12x0-0 <3,0-0+1"',
        pathDep: '^1a0a0',
        testDep: '">12345"',
        overrideDep: '2-1-0-dev1+2',
      );
      expect(
        tryOverride(content),
        '# Compatibility rewrites applied by pub.dev\n'
        'name: mocktail\n'
        'version: 1.3.5\n'
        'environment:\n'
        '  sdk: ">=2.12.0-0 <2.17.0"\n'
        'dependencies:\n'
        '  path: ^1.0.0\n'
        'dev_dependencies:\n'
        '  test:\n'
        '    version: ">1.3.5"\n'
        'dependency_overrides:\n'
        '  http: 2.1.0-dev1+2',
      );
    });
  });
}
