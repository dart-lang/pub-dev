// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as path;

import '../src/pub_http_client.dart';
import '../src/pub_tool_client.dart';
import '../src/test_data.dart';

/// A single object to execute integration script and verification tests with the
/// `pub` tool on the pub.dev site (or on a test site).
class BaseSetupScript {
  final String pubHostedUrl;
  final String? credentialsFileContent;
  final PubHttpClient _pubHttpClient;
  DartToolClient? _pubToolClient;

  late Directory _temp;
  late Directory _dummyDir;
  late Directory _retryDir;

  BaseSetupScript({required this.pubHostedUrl, this.credentialsFileContent})
    : _pubHttpClient = PubHttpClient(pubHostedUrl);

  Future<void> close() async {
    await _pubHttpClient.close();
  }

  /// Do the required setup steps, e.g. publishing packages.
  Future<void> publishPackages() async {
    assert(_pubToolClient == null);
    _temp = await Directory.systemTemp.createTemp('pub-integration');
    try {
      _pubToolClient = await DartToolClient.withServer(
        pubHostedUrl: pubHostedUrl,
        credentialsFileContent: credentialsFileContent!,
      );

      // creating packages
      await _createFakeRetryPkg();
      await _pubToolClient!.getDependencies(_retryDir.path);
      await _pubToolClient!.publish(_retryDir.path);

      await _createDummyPkg();
      await _pubToolClient!.getDependencies(_dummyDir.path);
      await _pubToolClient!.publish(_dummyDir.path);
    } finally {
      await _temp.delete(recursive: true);
      await _pubToolClient?.close();
    }
  }

  Future<void> updatePubSite() async {
    // trigger job processing
    await _pubHttpClient.forceAnalyzerUpdate();
    await _pubHttpClient.forceDartdocUpdate();

    // trigger re-indexing
    await _pubHttpClient.forceSearchUpdate();
  }

  Future<void> _createFakeRetryPkg() async {
    _retryDir = Directory(path.join(_temp.path, 'pkg', 'retry'));
    await _retryDir.create(recursive: true);
    await createFakeRetryPkg(_retryDir.path);
  }

  Future<void> _createDummyPkg() async {
    _dummyDir = Directory(path.join(_temp.path, 'pkg', '_dummy_pkg'));
    await _dummyDir.create(recursive: true);
    await createDummyPkg(_dummyDir.path, '0.1.0');
  }
}
