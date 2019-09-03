// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

import 'package:pub_integration/pub_integration.dart';
import 'package:pub_integration/src/fake_credentials.dart';
import 'package:pub_integration/src/fake_pub_server_process.dart';

void main() {
  group('Integration test using pkg/fake_pub_server', () {
    FakePubServerProcess fakePubServerProcess;
    final httpClient = http.Client();

    setUpAll(() async {
      fakePubServerProcess = await FakePubServerProcess.start();
      await fakePubServerProcess.started;
    });

    tearDownAll(() async {
      await fakePubServerProcess?.kill();
      httpClient.close();
    });

    test('standard integration', () async {
      final inviteUrlFuture = fakePubServerProcess
          .waitForLine((line) => line.contains('/admin/confirm/new-uploader/'));
      Future inviteCompleterFn() async {
        final pageUrl = await inviteUrlFuture.timeout(Duration(seconds: 30));
        final pageUri = Uri.parse(pageUrl);
        final confirmUrl = pageUri.replace(
          scheme: 'http',
          host: 'localhost',
          port: fakePubServerProcess.port,
        );
        print('Requesting confirm URL $confirmUrl');
        final pageRs = await httpClient.get(confirmUrl);
        final pageDom = html_parser.parse(pageRs.body);
        final elem = pageDom.getElementById('accept-invite-link');
        final acceptUrl = elem.attributes['href'];
        print('Requesting accept URL $acceptUrl');
        final acceptUri = Uri.parse(acceptUrl);
        await httpClient.get(acceptUri.replace(
            queryParameters: Map.from(acceptUri.queryParameters)
              ..addAll({'code': 'dev-at-example-dot-org'})));
      }

      await verifyPub(
        pubHostedUrl: 'http://localhost:${fakePubServerProcess.port}',
        credentialsFileContent: fakeCredentialsFileContent(),
        invitedEmail: 'dev@example.org',
        inviteCompleterFn: inviteCompleterFn,
      );
    });
  }, timeout: Timeout.factor(2));
}
