// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'package:pub_integration/pub_integration.dart';
import 'package:pub_integration/src/fake_pub_server_process.dart';

void main() {
  group('Integration test using pkg/fake_pub_server', () {
    Directory tempDir;
    String fakeCredentialsFile;
    FakePubServerProcess fakePubServerProcess;
    final httpClient = http.Client();

    setUpAll(() async {
      tempDir = await Directory.systemTemp.createTemp('fake-pub-server-test');

      // fake credentials.json
      fakeCredentialsFile = p.join(tempDir.path, 'credentials.json');
      await File(fakeCredentialsFile).writeAsString(json.encode({
        'accessToken': 'user-at-example-dot-com',
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

      await verifyPubIntegration(
        pubHostedUrl: 'http://localhost:${fakePubServerProcess.port}',
        mainAccountEmail: 'user@example.com',
        credentialsFile: fakeCredentialsFile,
        invitedAccountEmail: 'dev@example.org',
        inviteCompleterFn: inviteCompleterFn,
      );
    });
  });
}
