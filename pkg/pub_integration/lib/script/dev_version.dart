// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as p;

import '../src/pub_http_client.dart';
import '../src/pub_tool_client.dart';
import '../src/test_data.dart';

/// A single object to execute integration script and verification tests
/// publishing dev and stable version of a package.
class DevVersionScript {
  final String pubHostedUrl;
  final String credentialsFileContent;
  final PubHttpClient _pubHttpClient;
  DartToolClient? _pubToolClient;
  late Directory _temp;
  late Directory _pubCacheDir;

  DevVersionScript({
    required this.pubHostedUrl,
    required this.credentialsFileContent,
  }) : _pubHttpClient = PubHttpClient(pubHostedUrl);

  /// Publish and verify dev and stable versions.
  Future<void> verify(bool stableFirst) async {
    _pubToolClient = await DartToolClient.withServer(
        pubHostedUrl: pubHostedUrl,
        credentialsFileContent: credentialsFileContent);
    _temp = await Directory.systemTemp.createTemp();
    try {
      _pubCacheDir = Directory(p.join(_temp.path, 'pub-cache'));
      await _pubCacheDir.create(recursive: true);
      await File(p.join(_pubCacheDir.path, 'credentials.json'))
          .writeAsString(credentialsFileContent);

      await _createFakeRetryPkg();
      if (stableFirst) {
        await _publishVersion('0.9.0');
        _expectContent(
          await _pubHttpClient.getLatestVersionPage('_dummy_pkg'),
          present: [
            '_dummy_pkg 0.9.0',
          ],
          absent: [
            '<a href="/packages/_dummy_pkg">0.9.0</a>',
            '<a href="/packages/_dummy_pkg/versions/0.9.0">0.9.0</a>',
          ],
        );
        await _publishVersion('1.0.0-beta');
      } else {
        await _publishVersion('1.0.0-beta');
        _expectContent(
          await _pubHttpClient.getLatestVersionPage('_dummy_pkg'),
          present: [
            '_dummy_pkg 1.0.0-beta',
          ],
          absent: [
            '<a href="/packages/_dummy_pkg">1.0.0-beta</a>',
            '<a href="/packages/_dummy_pkg/versions/1.0.0-beta">1.0.0-beta</a>',
          ],
        );
        await _publishVersion('0.9.0');
      }

      // At this point both 0.9.0 and 1.0.0-beta is published.
      // We display both versions.
      _expectContent(
        await _pubHttpClient.getLatestVersionPage('_dummy_pkg'),
        present: [
          '_dummy_pkg 0.9.0',
          '<a href="/packages/_dummy_pkg">0.9.0</a>',
          '<a href="/packages/_dummy_pkg/versions/1.0.0-beta">1.0.0-beta</a>',
        ],
        absent: [
          '<a href="/packages/_dummy_pkg">1.0.0-beta</a>',
          '<a href="/packages/_dummy_pkg/versions/0.9.0">0.9.0</a>',
        ],
      );

      // Publishing a stable version that is not larger than the dev version
      // keeps it on the page.
      await _publishVersion('0.9.1');
      _expectContent(
        await _pubHttpClient.getLatestVersionPage('_dummy_pkg'),
        present: [
          '_dummy_pkg 0.9.1',
          '<a href="/packages/_dummy_pkg">0.9.1</a>',
          '<a href="/packages/_dummy_pkg/versions/1.0.0-beta">1.0.0-beta</a>',
        ],
        absent: [
          '<a href="/packages/_dummy_pkg">0.9.0</a>',
          '<a href="/packages/_dummy_pkg">1.0.0-beta</a>',
          '<a href="/packages/_dummy_pkg/versions/0.9.0">0.9.0</a>',
          '<a href="/packages/_dummy_pkg/versions/1.0.0">0.9.1</a>',
        ],
      );

      // Publishing a new dev version updates the dev version link.
      await _publishVersion('1.0.0-gamma');
      _expectContent(
        await _pubHttpClient.getLatestVersionPage('_dummy_pkg'),
        present: [
          '_dummy_pkg 0.9.1',
          '<a href="/packages/_dummy_pkg">0.9.1</a>',
          '<a href="/packages/_dummy_pkg/versions/1.0.0-gamma">1.0.0-gamma</a>',
        ],
        absent: [
          '<a href="/packages/_dummy_pkg">0.9.0</a>',
          '<a href="/packages/_dummy_pkg">1.0.0-beta</a>',
          '<a href="/packages/_dummy_pkg">1.0.0-gamma</a>',
          '<a href="/packages/_dummy_pkg/versions/0.9.0">0.9.0</a>',
          '<a href="/packages/_dummy_pkg/versions/1.0.0">0.9.1</a>',
          '<a href="/packages/_dummy_pkg/versions/1.0.0-beta">1.0.0-beta</a>',
        ],
      );

      // Publishing the stable version removes the dev version link.
      await _publishVersion('1.0.0');
      _expectContent(
        await _pubHttpClient.getLatestVersionPage('_dummy_pkg'),
        present: [
          '_dummy_pkg 1.0.0',
        ],
        absent: [
          '<a href="/packages/_dummy_pkg">0.9.0</a>',
          '<a href="/packages/_dummy_pkg">0.9.1</a>',
          '<a href="/packages/_dummy_pkg">1.0.0</a>',
          '<a href="/packages/_dummy_pkg">1.0.0-beta</a>',
          '<a href="/packages/_dummy_pkg">1.0.0-gamma</a>',
          '<a href="/packages/_dummy_pkg/versions/0.9.0">0.9.0</a>',
          '<a href="/packages/_dummy_pkg/versions/1.0.0">0.9.1</a>',
          '<a href="/packages/_dummy_pkg/versions/1.0.0-beta">1.0.0-beta</a>',
          '<a href="/packages/_dummy_pkg/versions/1.0.0-gamma">1.0.0-gamma</a>',
        ],
      );

      // Publishing a new dev version will trigger the re-appear of the dev link.
      await _publishVersion('1.1.0-dev');
      _expectContent(
        await _pubHttpClient.getLatestVersionPage('_dummy_pkg'),
        present: [
          '_dummy_pkg 1.0.0',
          '<a href="/packages/_dummy_pkg">1.0.0</a>',
          '<a href="/packages/_dummy_pkg/versions/1.1.0-dev">1.1.0-dev</a>',
        ],
        absent: [
          '<a href="/packages/_dummy_pkg">0.9.0</a>',
          '<a href="/packages/_dummy_pkg">0.9.1</a>',
          '<a href="/packages/_dummy_pkg">1.0.0-beta</a>',
          '<a href="/packages/_dummy_pkg">1.0.0-gamma</a>',
          '<a href="/packages/_dummy_pkg/versions/0.9.0">0.9.0</a>',
          '<a href="/packages/_dummy_pkg/versions/1.0.0">0.9.1</a>',
          '<a href="/packages/_dummy_pkg/versions/1.0.0-beta">1.0.0-beta</a>',
          '<a href="/packages/_dummy_pkg/versions/1.0.0-gamma">1.0.0-gamma</a>',
        ],
      );
    } finally {
      await _temp.delete(recursive: true);
      await _pubToolClient!.close();
      _pubToolClient = null;
      await _pubHttpClient.close();
    }
  }

  Future<void> _publishVersion(String version) async {
    final dir = await _temp.createTemp();
    await createDummyPkg(dir.path, version);
    await _pubToolClient!.publish(dir.path);
    await dir.delete(recursive: true);
  }

  void _expectContent(String? content,
      {List<Pattern>? present, List<Pattern>? absent}) {
    // removing title attributes to keep patterns simple
    content = content!.replaceAll(RegExp(' title=".*?"'), '');
    for (final p in present ?? const <Pattern>[]) {
      if (p.allMatches(content).isEmpty) {
        throw Exception('$p is missing from the content.');
      }
    }
    for (final p in absent ?? const <Pattern>[]) {
      if (p.allMatches(content).isNotEmpty) {
        throw Exception('$p is present in the content.');
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
