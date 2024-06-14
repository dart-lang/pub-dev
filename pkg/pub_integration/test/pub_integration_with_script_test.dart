// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:pub_integration/src/fake_pub_server_process.dart';
import 'package:test/test.dart';

void main() {
  group('Integration test using pkg/fake_pub_server with script', () {
    late final FakePubServerProcess fakePubServerProcess;
    late final String pubHostedUrl;

    setUpAll(() async {
      fakePubServerProcess = await FakePubServerProcess.start();
      await fakePubServerProcess.started;
      pubHostedUrl = 'http://localhost:${fakePubServerProcess.port}';
    });

    tearDownAll(() async {
      await fakePubServerProcess.kill();
    });

    test('standard integration', () async {
      final pr = await Process.run(
        'dart',
        [
          'bin/verify_prod_pub.dart',
          '--pub-hosted-url',
          pubHostedUrl,
          // admin user
          '--user-a-email',
          'user@example.com',
          '--user-a-api-access-token-callback',
          'dart bin/fake_user_callback.dart api-access-token --email user@example.com --pub-hosted-url $pubHostedUrl',
          '--user-a-client-credentials-json-callback',
          'dart bin/fake_user_callback.dart client-credentials-json --email user@example.com',
          '--user-a-browser-cookies-callback',
          'dart bin/fake_user_callback.dart browser-cookies --email user@example.com --pub-hosted-url $pubHostedUrl',
          '--user-a-last-email-callback',
          'dart bin/fake_user_callback.dart last-email --email user@example.com --email-output-dir ${fakePubServerProcess.fakeEmailOutputPath}',
          // invited user
          '--user-b-email',
          'dev@example.com',
          '--user-b-api-access-token-callback',
          'dart bin/fake_user_callback.dart api-access-token --email dev@example.com --pub-hosted-url $pubHostedUrl',
          '--user-b-client-credentials-json-callback',
          'dart bin/fake_user_callback.dart client-credentials-json --email dev@example.com',
          '--user-b-browser-cookies-callback',
          'dart bin/fake_user_callback.dart browser-cookies --email dev@example.com --pub-hosted-url $pubHostedUrl',
          '--user-b-last-email-callback',
          'dart bin/fake_user_callback.dart last-email --email dev@example.com --email-output-dir ${fakePubServerProcess.fakeEmailOutputPath}',
        ],
      );
      expect(pr.exitCode, 0, reason: [pr.stdout, pr.stderr].join('\n'));
    }, timeout: Timeout.factor(4));
  });
}
