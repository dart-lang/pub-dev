// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:pub_integration/src/fake_credentials.dart';
import 'package:pub_integration/src/fake_test_context_provider.dart';
import 'package:pub_integration/src/pub_tool_client.dart';
import 'package:test/test.dart';

void main() {
  group('reject based on description', () {
    late final TestContextProvider fakeTestScenario;
    late String pubHostedUrl;
    late DartToolClient globalDartTool;
    late DartToolClient localDartTool;

    setUpAll(() async {
      globalDartTool = await DartToolClient.withPubDev();
      fakeTestScenario = await TestContextProvider.start();
      pubHostedUrl = fakeTestScenario.pubHostedUrl;
      localDartTool = await DartToolClient.withServer(
        pubHostedUrl: pubHostedUrl,
        credentialsFileContent: fakeCredentialsFileContent(),
      );
    });

    tearDownAll(() async {
      await globalDartTool.close();
      await localDartTool.close();
      await fakeTestScenario.close();
    });

    test('uses a template', () async {
      final tempDir = await Directory.systemTemp.createTemp();
      try {
        final dependentPackages = {
          'lints': '2.99.0',
          'test': '1.99.0',
        };
        for (final d in dependentPackages.keys) {
          final pkgDir = p.join(tempDir.path, d);
          await Directory(pkgDir).create(recursive: true);
          await File(p.join(pkgDir, 'pubspec.yaml')).writeAsString('name: $d\n'
              'version: ${dependentPackages[d]}\n'
              'description: simple package placeholder\n'
              'environment:\n  sdk: ">=3.0.0 <4.0.0"\n');
          await File(p.join(pkgDir, 'LICENSE'))
              .writeAsString('No real license.');
          if (d == 'test') {
            final file = File(p.join(pkgDir, 'lib/test.dart'));
            await file.parent.create(recursive: true);
            await file.writeAsString('void test(String name, Function fn) {}\n'
                'void expect(dynamic a, dynamic b) {}\n');
          }
          await localDartTool.publish(pkgDir);
        }

        final pkgName = 'pkg';
        final pkgDir = p.join(tempDir.path, pkgName);
        // create templated package
        await globalDartTool.create(pkgDir);

        // customize content to clear publishing warnings
        final pubspecFile = File(p.join(pkgDir, 'pubspec.yaml'));
        final pubspecContent = await pubspecFile.readAsString();
        await pubspecFile.writeAsString(
            'homepage: https://github.com/abc/xyz\n$pubspecContent');
        await File(p.join(pkgDir, 'LICENSE'))
            .writeAsString('All rights reserved.');

        // publish should fail with the description-related error message
        await localDartTool.publish(
          pkgDir,
          expectedErrorContains:
              '`description` contains a generic text fragment coming from package templates (`A sample command-line application`).\n'
              'Please follow the guides to describe your package:\n'
              'https://dart.dev/tools/pub/pubspec#description',
        );
      } finally {
        await tempDir.delete(recursive: true);
      }
    });
  }, timeout: Timeout.factor(testTimeoutFactor));
}
