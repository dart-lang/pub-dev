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

class FakeTestScenario {
  final String pubHostedUrl;
  final FakePubServerProcess _fakePubServerProcess;
  final HeadlessGroup _headlessGroup;

  FakeTestScenario._(
      this.pubHostedUrl, this._fakePubServerProcess, this._headlessGroup);

  static Future<FakeTestScenario> start() async {
    final fakePubServerProcess = await FakePubServerProcess.start();
    await fakePubServerProcess.started;
    final origin = 'http://localhost:${fakePubServerProcess.port}';

    // creating a unique test name for coverage reports
    final testName = [
      Platform.script.pathSegments.last.replaceAll('.', '-'),
      DateTime.now().millisecondsSinceEpoch,
      Isolate.current.hashCode,
    ].join('-');

    final headlessGroup = HeadlessGroup(
      origin: origin,
      testName: testName,
    );
    return FakeTestScenario._(origin, fakePubServerProcess, headlessGroup);
  }

  Future<void> close() async {
    await _headlessGroup.close();
    await _fakePubServerProcess.kill();
  }

  Future<TestUser> createAnonymousTestUser() async {
    final headlessEnv = await _headlessGroup.createNewProfile();
    return TestUser(
      email: '',
      api: PubApiClient(pubHostedUrl),
      withBrowserPage: <T>(Future<T> Function(Page) fn) async {
        return await headlessEnv.withPage<T>(fn: fn);
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
      headlessEnv: await _headlessGroup.createNewProfile(),
      fakeEmailReader: _fakePubServerProcess.fakeEmailReader,
      scopes: scopes,
    );
  }
}
