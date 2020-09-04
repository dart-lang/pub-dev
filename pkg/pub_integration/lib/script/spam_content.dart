// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;

import '../src/pub_http_client.dart';
import '../src/pub_tool_client.dart';
import '../src/test_data.dart';

/// A single object to execute integration script and verification tests of
/// package contents with spam.
class SpamContentScript {
  final String pubHostedUrl;
  final String credentialsFileContent;
  final PubHttpClient _pubHttpClient;
  PubToolClient _pubToolClient;

  Directory _temp;
  Directory _retryDir;

  SpamContentScript({
    @required this.pubHostedUrl,
    @required this.credentialsFileContent,
  }) : _pubHttpClient = PubHttpClient(pubHostedUrl);

  Future<void> close() async {
    await _pubHttpClient.close();
  }

  /// Run the script and the verification.
  Future<void> verify() async {
    assert(_pubToolClient == null);
    _temp = await Directory.systemTemp.createTemp('pub-integration');
    try {
      _pubToolClient = await PubToolClient.create(
          pubHostedUrl: pubHostedUrl,
          credentialsFileContent: credentialsFileContent);

      // pre-attempt
      await _verifyRetryPageDoesNotExists();

      // creating packages
      await _createFakeRetryPkg('spam-SPAM-spaM-spam');
      await _pubToolClient.getDependencies(_retryDir.path);
      await _pubToolClient.publish(_retryDir.path,
          expectedError: 'Package archive is classified as spam.');

      // post-attempt check
      await _verifyRetryPageDoesNotExists();
    } finally {
      await _temp.delete(recursive: true);
      await _pubToolClient?.close();
    }
  }

  Future<void> _createFakeRetryPkg(String readmeContent) async {
    _retryDir = Directory(path.join(_temp.path, 'pkg', 'retry'));
    await _retryDir.create(recursive: true);
    await createFakeRetryPkg(_retryDir.path);
    await File(path.join(_retryDir.path, 'README.md'))
        .writeAsString(readmeContent, mode: FileMode.append);
  }

  Future<void> _verifyRetryPageDoesNotExists() async {
    final content = await _pubHttpClient.getLatestVersionPage('retry');
    // TODO: should detect redirect-to-search (and also fix not-available)
    if (content != null &&
        !content.contains('Search is temporarily impaired')) {
      throw Exception(
          'Expected missing page but found content: ${content.length} characters.');
    }
  }
}
