// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'package:pub_integration/pub_integration.dart';
import 'package:pub_integration/src/fake_pub_server_process.dart';

void main() {
  group('Integration test using pkg/fake_pub_server', () {
    Directory tempDir;
    String fakeCredentialsFile;
    FakePubServerProcess fakePubServerProcess;

    setUpAll(() async {
      tempDir = await Directory.systemTemp.createTemp('fake-pub-server-test');

      // fake credentials.json
      fakeCredentialsFile = p.join(tempDir.path, 'credentials.json');
      await File(fakeCredentialsFile).writeAsString(json.encode({
        'accessToken': 'access-token',
        'refreshToken': 'refresh-token',
        'tokenEndpoint': 'http://localhost:9999/o/oauth2/token',
        'scopes': ['email', 'openid'],
        'expiration': 2558512791154,
      }));

      fakePubServerProcess = await FakePubServerProcess.start();
      await fakePubServerProcess.started;
    });

    tearDownAll(() async {
      await tempDir?.delete(recursive: true);
      await fakePubServerProcess?.kill();
    });

    test('standard integration', () async {
      await verifyPubIntegration(
        pubHostedUrl: 'http://localhost:${fakePubServerProcess.port}',
        credentialsFile: fakeCredentialsFile,
      );
    });
  });
}
