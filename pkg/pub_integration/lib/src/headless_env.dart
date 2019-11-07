// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:puppeteer/puppeteer.dart';
// ignore: implementation_imports
import 'package:puppeteer/src/page/page.dart' show ClientError;

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

  Future _startBrowser() async {
    if (_browser != null) return;
    final chromeBin = await _detectChromeBinary();
    final userDataDir = tempDir.createTempSync('user');
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
      headless: false,
      devTools: false,
    );
  }

  Future<Page> newPage() async {
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
        await rq.respond(
            status: 200, contentType: 'text/javascript', body: '{};');
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

  Future close() async {
    await _browser.close();
  }
}
