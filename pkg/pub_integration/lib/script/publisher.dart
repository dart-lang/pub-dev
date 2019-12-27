// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';

import '../src/pub_http_client.dart';
import '../src/pub_tool_client.dart';
import '../src/test_data.dart';

typedef InviteCompleterFn = Future<void> Function();

/// A single object to execute publisher-related integration script and
/// verification tests with the `pub` tool on the fake site.
class PublisherScript {
  final String pubHostedUrl;
  final String credentialsFileContent;
  final String invitedEmail;
  final InviteCompleterFn inviteCompleterFn;
  PubHttpClient _pubHttpClient;
  PubToolClient _pubToolClient;

  Directory _temp;

  PublisherScript({
    @required this.pubHostedUrl,
    @required this.credentialsFileContent,
    @required this.invitedEmail,
    @required this.inviteCompleterFn,
  });

  /// Verify all integration steps.
  Future<void> verify() async {
    assert(_pubHttpClient == null);
    assert(_pubToolClient == null);
    _pubHttpClient = PubHttpClient(pubHostedUrl);
    _temp = await Directory.systemTemp.createTemp('pub-integration');
    try {
      _pubToolClient = await PubToolClient.create(
          pubHostedUrl: pubHostedUrl,
          credentialsFileContent: credentialsFileContent);

      await _publishDummyPkg('1.0.0');
      await Future.delayed(Duration(seconds: 1));
      await _verifyDummyPkg(
          version: '1.0.0', uploaderEmail: 'user@example.com');

      await _pubHttpClient.createPublisher(
        authToken: 'user-at-example-dot-com',
        publisherId: 'example.com',
        accessToken: 'user-at-example-dot-com',
      );
      await _pubHttpClient.setPackagePublisher(
        authToken: 'user-at-example-dot-com',
        package: '_dummy_pkg',
        publisherId: 'example.com',
      );

      final infoBody =
          await _pubHttpClient.getContent('/api/packages/_dummy_pkg/publisher');
      final info = json.decode(infoBody) as Map<String, dynamic>;
      if (info['publisherId'] != 'example.com') {
        throw Exception('Unexpected publisher info: $infoBody');
      }

      await _publishDummyPkg('2.0.0');
      await Future.delayed(Duration(seconds: 1));
      await _verifyDummyPkg(version: '2.0.0', publisherId: 'example.com');

      await _pubHttpClient.forceSearchUpdate();
      await _verifyPublisherPackageListPage();

      await _verifyPublisherListPage();

      // member invite
      final members1 = await _pubHttpClient.listMembers(
        authToken: 'user-at-example-dot-com',
        publisherId: 'example.com',
      );
      _verifyMap({'user@example.com': 'admin'}, members1);

      await _pubHttpClient.inviteMember(
        authToken: 'user-at-example-dot-com',
        publisherId: 'example.com',
        invitedEmail: invitedEmail,
      );
      await inviteCompleterFn();
      final members2 = await _pubHttpClient.listMembers(
        authToken: 'user-at-example-dot-com',
        publisherId: 'example.com',
      );
      _verifyMap({
        'user@example.com': 'admin',
        invitedEmail: 'admin',
      }, members2);

      // TODO: verify my publishers page
    } finally {
      await _temp.delete(recursive: true);
      _pubHttpClient.close();
      await _pubToolClient?.close();
    }
  }

  Future<void> _publishDummyPkg(String version) async {
    final dir = await _temp.createTemp();
    await createDummyPkg(dir.path, version);
    await _pubToolClient.publish(dir.path);
    await dir.delete(recursive: true);
  }

  Future<void> _verifyDummyPkg(
      {String version, String uploaderEmail, String publisherId}) async {
    final dv = await _pubHttpClient.getLatestVersionName('_dummy_pkg');
    if (dv != version) {
      throw Exception('Expected version does not match: $dv != $version');
    }

    final pageHtml = await _pubHttpClient.getLatestVersionPage('_dummy_pkg');
    if (!pageHtml.contains(version)) {
      throw Exception('New version is not to be found on package page.');
    }

    if (uploaderEmail != null) {
      if (publisherId != null) throw ArgumentError();

      // author must not be present
      if (pageHtml.contains('developer@example.com')) {
        throw Exception(
            'pubspec author field most not be found on package page.');
      }
      // uploader must be present
      if (!pageHtml.contains('Uploader') ||
          !pageHtml.contains('user@example.com')) {
        throw Exception('Uploader not found on the package page.');
      }
      // publisher most not be present
      if (pageHtml.contains('href="/publishers/')) {
        throw Exception('Publisher link found on the package page.');
      }
    }

    if (publisherId != null) {
      if (uploaderEmail != null) throw ArgumentError();

      // author must not be present
      if (pageHtml.contains('developer@example.com')) {
        throw Exception('pubspec author field found on package page.');
      }
      // uploader must not be present
      if (pageHtml.contains('Uploader') ||
          pageHtml.contains('user@example.com')) {
        throw Exception('Uploader found on the package page.');
      }
      // publisher must be present
      if (!pageHtml.contains('href="/publishers/$publisherId"')) {
        throw Exception('Publisher link not found on the package page.');
      }
    }
  }

  Future<void> _verifyPublisherPackageListPage() async {
    final html = await _pubHttpClient.getPublisherPage('example.com');
    if (!html.contains('href="/packages/_dummy_pkg"')) {
      throw Exception('Does not contain link to package.');
    }
  }

  Future<void> _verifyPublisherListPage() async {
    final html = await _pubHttpClient.getPublisherListPage();
    if (!html.contains('href="/publishers/example.com"')) {
      throw Exception('Does not contain link to publisher.');
    }
  }

  void _verifyMap(Map expected, Map actual) {
    if (expected.length != actual.length) {
      throw Exception(
          'Map differ in length: ${expected.length} != ${actual.length}');
    }
    for (final key in expected.keys) {
      if (actual[key] != expected[key]) {
        throw Exception(
            'Map value differs for key: $key ${actual[key]} != ${expected[key]}');
      }
    }
  }
}
