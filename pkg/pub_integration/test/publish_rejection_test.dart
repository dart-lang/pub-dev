// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:pub_integration/src/fake_credentials.dart';
import 'package:pub_integration/src/fake_pub_server_process.dart';
import 'package:pub_integration/src/pub_tool_client.dart';
import 'package:test/test.dart';

void main() {
  group('reject based on description', () {
    late FakePubServerProcess fakePubServerProcess;
    late String pubHostedUrl;
    late DartToolClient globalDartTool;
    late DartToolClient localDartTool;

    setUpAll(() async {
      globalDartTool = await DartToolClient.withPubDev();
      fakePubServerProcess = await FakePubServerProcess.start();
      await fakePubServerProcess.started;
      pubHostedUrl = 'http://localhost:${fakePubServerProcess.port}';
      localDartTool = await DartToolClient.withServer(
        pubHostedUrl: pubHostedUrl,
        credentialsFileContent: fakeCredentialsFileContent(),
      );
    });

    tearDownAll(() async {
      await globalDartTool.close();
      await localDartTool.close();
      await fakePubServerProcess.kill();
    });

    test('uses a template', () async {
      final tempDir = await Directory.systemTemp.createTemp();
      try {
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
          expectedError:
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
