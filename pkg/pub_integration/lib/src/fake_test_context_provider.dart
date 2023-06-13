// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:isolate';

import 'package:_pub_shared/pubapi.dart';
import 'package:puppeteer/puppeteer.dart';

import 'fake_pub_server_process.dart';
import 'fake_test_user.dart';
import 'headless_env.dart';
import 'test_scenario.dart';

/// The timeout factor that should be used in integration tests.
final testTimeoutFactor = 6;

class TestContextProvider {
  final String pubHostedUrl;
  final FakePubServerProcess _fakePubServerProcess;
  final TestBrowser _testBrowser;

  TestContextProvider._(
      this.pubHostedUrl, this._fakePubServerProcess, this._testBrowser);

  static Future<TestContextProvider> start() async {
    final fakePubServerProcess = await FakePubServerProcess.start();
    await fakePubServerProcess.started;
    final origin = 'http://localhost:${fakePubServerProcess.port}';

    // creating a unique test name for coverage reports
    final testName = [
      Platform.script.pathSegments.last.replaceAll('.', '-'),
      DateTime.now().millisecondsSinceEpoch,
      Isolate.current.hashCode,
    ].join('-');

    final testBrowser = TestBrowser(
      origin: origin,
      testName: testName,
    );
    await testBrowser.startBrowser();
    return TestContextProvider._(origin, fakePubServerProcess, testBrowser);
  }

  Future<void> close() async {
    await _testBrowser.close();
    await _fakePubServerProcess.kill();
  }

  Future<TestUser> createAnonymousTestUser() async {
    return TestUser(
      email: '',
      api: PubApiClient(pubHostedUrl),
      withBrowserPage: <T>(Future<T> Function(Page) fn) async {
        return await _testBrowser.withPage<T>(fn: fn);
      },
      readLatestEmail: () async => throw UnimplementedError(),
      createCredentials: () async => throw UnimplementedError(),
    );
  }

  Future<TestUser> createTestUser({
    required String email,
    List<String>? scopes,
  }) async {
    return await createFakeTestUser(
      email: email,
      testBrowser: _testBrowser,
      fakeEmailReader: _fakePubServerProcess.fakeEmailReader,
      scopes: scopes,
    );
  }
}
