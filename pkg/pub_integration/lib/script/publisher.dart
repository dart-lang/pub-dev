// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:pub_integration/src/fake_pub_server_process.dart';
import 'package:pub_integration/src/headless_env.dart';
import 'package:pub_integration/src/pub_puppeteer_helpers.dart';
import 'package:pub_integration/src/test_scenario.dart';

import '../src/pub_http_client.dart';
import '../src/pub_tool_client.dart';
import '../src/test_data.dart';

typedef InviteCompleterFn = Future<void> Function();

/// A single object to execute publisher-related integration script and
/// verification tests with the `pub` tool on the fake site.
class PublisherScript {
  final String pubHostedUrl;
  final PubHttpClient _pubHttpClient;
  final TestUser adminUser;
  final TestUser invitedUser;
  final TestUser unrelatedUser;
  DartToolClient? _pubToolClient;

  late Directory _temp;

  PublisherScript({
    required this.pubHostedUrl,
    required this.adminUser,
    required this.invitedUser,
    required this.unrelatedUser,
  }) : _pubHttpClient = PubHttpClient(pubHostedUrl);

  /// Verify all integration steps.
  Future<void> verify() async {
    assert(_pubToolClient == null);
    _temp = await Directory.systemTemp.createTemp('pub-integration');
    try {
      _pubToolClient = await DartToolClient.withServer(
        pubHostedUrl: pubHostedUrl,
        credentialsFileContent:
            json.encode(await adminUser.createCredentials()),
      );

      await _createFakeRetryPkg();

      await _publishDummyPkg('1.0.0');
      await Future.delayed(Duration(seconds: 1));
      await _verifyDummyPkg(
          version: '1.0.0', uploaderEmail: 'user@example.com');

      await adminUser.withBrowserPage((page) async {
        await page.createPublisher(publisherId: 'example.com');
        await page.setPackagePublisher(
          package: '_dummy_pkg',
          publisherId: 'example.com',
        );
      });

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
      await adminUser.withBrowserPage((page) async {
        final members1 =
            await page.listPublisherMembers(publisherId: 'example.com');
        _verifyMap({'user@example.com': 'admin'}, members1);

        await page.invitePublisherMember(
          publisherId: 'example.com',
          invitedEmail: invitedUser.email,
        );
      });

      // get consent id
      final lastEmail = await invitedUser.readLatestEmail();
      final consentId = extractConsentIdFromEmail(lastEmail);

      // spoofed consent, trying to accept it with a different user
      await unrelatedUser.withBrowserPage((page) async {
        final rs = await page.gotoOrigin('/consent?id=$consentId');
        if (rs.status != 400) {
          throw Exception('Unexpected status code: ${rs.status}');
        }
      });

      // accepting it with the good user
      await invitedUser.withBrowserPage((page) async {
        await page.acceptConsent(consentId: consentId);
      });

      // verify published members after invite succeeded
      await adminUser.withBrowserPage((page) async {
        final members2 =
            await page.listPublisherMembers(publisherId: 'example.com');
        _verifyMap({
          'user@example.com': 'admin',
          invitedUser.email: 'admin',
        }, members2);
      });

      // TODO: verify my publishers page
    } finally {
      await _temp.delete(recursive: true);
      await _pubHttpClient.close();
      await _pubToolClient?.close();
    }
  }

  Future<void> _publishDummyPkg(String version) async {
    final dir = await _temp.createTemp();
    await createDummyPkg(dir.path, version);
    await _pubToolClient!.publish(dir.path);
    await dir.delete(recursive: true);
  }

  Future<void> _verifyDummyPkg(
      {required String version,
      String? uploaderEmail,
      String? publisherId}) async {
    final dv = await _pubHttpClient.getLatestVersionName('_dummy_pkg');
    if (dv != version) {
      throw Exception('Expected version does not match: $dv != $version');
    }

    final pageHtml = (await _pubHttpClient.getLatestVersionPage('_dummy_pkg'))!;
    if (!pageHtml.contains(version)) {
      throw Exception('New version is not to be found on package page.');
    }

    // author must not be present
    if (pageHtml.contains('developer@example.com')) {
      throw Exception(
          'pubspec author field most not be found on package page.');
    }
    if (uploaderEmail != null) {
      if (publisherId != null) throw ArgumentError();
      // publisher most not be present
      if (pageHtml.contains('href="/publishers/')) {
        throw Exception('Publisher link found on the package page.');
      }
    }

    if (publisherId != null) {
      if (uploaderEmail != null) throw ArgumentError();

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
    final html = (await _pubHttpClient.getPublisherPage('example.com'))!;
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

  Future<void> _createFakeRetryPkg() async {
    final dir = await _temp.createTemp();
    await createFakeRetryPkg(dir.path);
    await _pubToolClient!.publish(dir.path);
    await dir.delete(recursive: true);
  }
}
