// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:puppeteer/puppeteer.dart';
// ignore: implementation_imports
import 'package:puppeteer/src/page/page.dart' show ClientError;

/// Creates and tracks the headless Chrome environment, its temp directories and
/// and uncaught exceptions.
class HeadlessEnv {
  final Directory tempDir;
  Browser _browser;
  final clientErrors = <ClientError>[];

  HeadlessEnv({Directory tempDir})
      : tempDir =
            tempDir ?? Directory.systemTemp.createTempSync('pub-headless');

  Future<String> _detectChromeBinary() async {
    // TODO: scan $PATH
    // check hardcoded values
    final binaries = [
      '/usr/bin/google-chrome',
    ];
    for (String binary in binaries) {
      if (File(binary).existsSync()) return binary;
    }

    // sanity check for travis
    if (Platform.environment['TRAVIS'] == 'true') {
      throw StateError('Could not detect chrome binary while running in CI.');
    }

    // Otherwise let puppeteer download a chrome in the local .local-chromium
    // directory:
    return null;
  }

  Future<void> _startBrowser() async {
    if (_browser != null) return;
    final chromeBin = await _detectChromeBinary();
    final userDataDir = await tempDir.createTemp('user');
    _browser = await puppeteer.launch(
      executablePath: chromeBin,
      args: [
        '--lang=en-US,en',
        '--disable-setuid-sandbox',
        '--disable-dev-shm-usage',
        '--disable-accelerated-2d-canvas',
        '--disable-gpu',
      ],
      noSandboxFlag: true,
      userDataDir: userDataDir.path,
      headless: true,
      devTools: false,
    );
  }

  Future<Page> newPage({FakeGoogleUser user}) async {
    await _startBrowser();
    final page = await _browser.newPage();
    await page.setRequestInterception(true);
    page.onRequest.listen((rq) async {
      // soft-abort
      if (rq.url.startsWith('https://www.google-analytics.com/') ||
          rq.url.startsWith('https://www.googletagmanager.com/') ||
          rq.url.startsWith('https://www.google.com/insights')) {
        await rq.abort(error: ErrorReason.failed);
        return;
      }
      // ignore
      if (rq.url.startsWith('data:')) {
        await rq.continueRequest();
        return;
      }

      if (rq.url ==
          'https://apis.google.com/js/platform.js?onload=pubAuthInit') {
        final fakePlatformJs = File('lib/src/fake_platform.js');
        final fileContent = await fakePlatformJs.readAsString();
        final overrides = <String>[
          if (user != null) 'googleUser = ${json.encode(user.toJson())};',
        ];
        await rq.respond(
          status: 200,
          contentType: 'text/javascript',
          body: '$fileContent\n\n${overrides.join('\n')}',
        );
        return;
      }

      await rq.continueRequest();
    });

    // print console messages
    page.onConsole.listen(print);

    // print and store uncaught errors
    page.onError.listen((e) {
      print('Error: $e');
      clientErrors.add(e);
    });
    return page;
  }

  Future<void> close() async {
    await _browser.close();
  }
}

/// User to inject in the fake google auth JS script.
class FakeGoogleUser {
  final String id;
  final String email;
  final String imageUrl;
  final String accessToken;
  final String idToken;
  final String scope;
  final DateTime expiresAt;

  FakeGoogleUser({
    this.id,
    this.email,
    this.imageUrl,
    this.accessToken,
    this.idToken,
    this.scope,
    this.expiresAt,
  });

  factory FakeGoogleUser.withDefaults(String email) {
    final id = email.replaceAll('@', '-at-').replaceAll('.', '-dot-');
    return FakeGoogleUser(
      id: id,
      email: email,
      imageUrl: '/images/user/$id.jpg',
      scope: 'profile',
      accessToken: id,
      idToken: id,
      expiresAt: DateTime.now().add(Duration(hours: 1)),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'isSignedIn': id != null,
        'id': id,
        'email': email,
        'imageUrl': imageUrl,
        'accessToken': accessToken,
        'idToken': idToken,
        'expiresAt': expiresAt?.millisecondsSinceEpoch ?? 0,
      };
}
