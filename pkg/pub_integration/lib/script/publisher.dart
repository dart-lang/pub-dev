// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:meta/meta.dart';

import '../src/pub_http_client.dart';
import '../src/pub_tool_client.dart';
import '../src/test_data.dart';

typedef InviteCompleterFn = Future Function();

/// A single object to execute publisher-related integration script and
/// verification tests with the `pub` tool on the fake site.
class PublisherScript {
  final String pubHostedUrl;
  final String credentialsFileContent;
  PubHttpClient _pubHttpClient;
  PubToolClient _pubToolClient;

  Directory _temp;

  PublisherScript({
    @required this.pubHostedUrl,
    @required this.credentialsFileContent,
  });

  /// Verify all integration steps.
  Future verify() async {
    assert(_pubHttpClient == null);
    assert(_pubToolClient == null);
    _pubHttpClient = PubHttpClient(pubHostedUrl);
    _temp = await Directory.systemTemp.createTemp('pub-integration');
    try {
      _pubToolClient = await PubToolClient.create(
          pubHostedUrl: pubHostedUrl,
          credentialsFileContent: credentialsFileContent);

      await _publishVersion('1.0.0');
      await Future.delayed(Duration(seconds: 1));
      await _verifyDummyPkg(version: '1.0.0');

      await _pubHttpClient.createPublisher(
        authToken: 'user-at-example-dot-com',
        publisherId: 'example.com',
        accessToken: 'access-at-example-dot-com',
      );
      await _pubHttpClient.setPackagePublisher(
        authToken: 'user-at-example-dot-com',
        package: '_dummy_pkg',
        publisherId: 'example.com',
      );

      final publisherInfo =
          await _pubHttpClient.getContent('/api/packages/_dummy_pkg/publisher');
      if (publisherInfo != '{"publisherId":"example.com"}') {
        throw Exception('Unexpected publisher info: $publisherInfo');
      }
      // TODO: check package page that publisherId is displayed

      await _publishVersion('2.0.0');
      await Future.delayed(Duration(seconds: 1));
      await _verifyDummyPkg(version: '2.0.0');
    } finally {
      await _temp.delete(recursive: true);
      _pubHttpClient.close();
      await _pubToolClient?.close();
    }
  }

  Future _publishVersion(String version) async {
    final dir = await _temp.createTemp();
    await createDummyPkg(dir.path, version);
    await _pubToolClient.publish(dir.path);
    await dir.delete(recursive: true);
  }

  Future _verifyDummyPkg({String version}) async {
    final dv = await _pubHttpClient.getLatestVersionName('_dummy_pkg');
    if (dv != version) {
      throw Exception('Expected version does not match: $dv != $version');
    }

    final pageHtml = await _pubHttpClient.getLatestVersionPage('_dummy_pkg');
    if (!pageHtml.contains(version)) {
      throw Exception('New version is not to be found on package page.');
    }
    if (!pageHtml.contains('developer@example.com')) {
      throw Exception(
          'pubspec author field is not to be found on package page.');
    }
  }
}
