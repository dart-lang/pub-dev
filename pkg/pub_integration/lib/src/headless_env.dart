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
  final bool debug;
  Browser _browser;
  final clientErrors = <ClientError>[];
  final bool trackCoverage;
  final _trackedPages = <Page>[];

  /// The coverage report of JavaScript files.
  final _jsCoverages = <String, _Coverage>{};

  /// The coverage report of CSS files.
  final _cssCoverages = <String, _Coverage>{};

  HeadlessEnv({
    Directory tempDir,
    this.trackCoverage = false,
    this.debug = false,
  }) : tempDir = tempDir ?? Directory.systemTemp.createTempSync('pub-headless');

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

  Future<void> startBrowser() async {
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
      headless: !debug,
      devTools: false,
    );
  }

  /// Creates a new page and setup overrides and tracking.
  Future<R> withPage<R>(
      {FakeGoogleUser user, Future<R> Function(Page page) fn}) async {
    await startBrowser();
    final page = await _browser.newPage();
    await page.setRequestInterception(true);
    if (trackCoverage) {
      await page.coverage.startJSCoverage(resetOnNavigation: false);
      // TODO: figure out why the following future does not complete
      page.coverage.startCSSCoverage(resetOnNavigation: false);
    }
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

    _trackedPages.add(page);

    try {
      return await fn(page);
    } finally {
      await _closePage(page);
    }
  }

  /// Gets tracking results of [page] and closes it.
  Future<void> _closePage(Page page) async {
    if (page == null) return;

    if (trackCoverage) {
      final jsEntries = await page.coverage.stopJSCoverage();
      for (final e in jsEntries) {
        _jsCoverages[e.url] ??= _Coverage(e.url);
        _jsCoverages[e.url].textLength = e.text.length;
        _jsCoverages[e.url].addRanges(e.ranges);
      }

      final cssEntries = await page.coverage.stopCSSCoverage();
      for (final e in cssEntries) {
        _cssCoverages[e.url] ??= _Coverage(e.url);
        _cssCoverages[e.url].textLength = e.text.length;
        _cssCoverages[e.url].addRanges(e.ranges);
      }
    }

    await page.close();
    _trackedPages.remove(page);
  }

  Future<void> close() async {
    if (_trackedPages.isNotEmpty) {
      throw StateError('There are tracked pages with pending coverage report.');
    }
    await _browser.close();
  }

  void printCoverage() {
    for (final c in _jsCoverages.values) {
      print('${c.url}: ${c.percent.toStringAsFixed(2)}%');
    }
    for (final c in _cssCoverages.values) {
      print('${c.url}: ${c.percent.toStringAsFixed(2)}%');
    }
  }

  Future<void> saveCoverage(String outputDir, String name) async {
    Future<void> saveToFile(Map<String, _Coverage> map, String path) async {
      if (map.isNotEmpty) {
        final file = File(path);
        await file.parent.create(recursive: true);
        await file.writeAsString(json.encode(map.map(
          (k, v) => MapEntry<String, dynamic>(
            v.url,
            {
              'textLength': v.textLength,
              'ranges': v._coveredRanges.map((r) => r.toJson()).toList(),
            },
          ),
        )));
      }
    }

    await saveToFile(_jsCoverages, '$outputDir/$name.js.json');
    await saveToFile(_cssCoverages, '$outputDir/$name.css.json');
  }
}

/// Track the covered ranges in the source file.
class _Coverage {
  final String url;
  int textLength;

  /// List of start-end ranges that were covered in the source file during the
  /// execution of the app.
  List<Range> _coveredRanges = <Range>[];

  _Coverage(this.url);

  void addRanges(List<Range> ranges) {
    final list = [..._coveredRanges, ...ranges];
    // sort by start position first, and if they are matching, sort by end position
    list.sort((a, b) {
      final x = a.start.compareTo(b.start);
      return x == 0 ? a.end.compareTo(b.end) : x;
    });
    // merge ranges
    _coveredRanges = list.fold<List<Range>>(<Range>[], (m, range) {
      if (m.isEmpty || m.last.end < range.start) {
        m.add(range);
      } else {
        final last = m.removeLast();
        m.add(Range(last.start, range.end));
      }
      return m;
    });
  }

  double get percent {
    final coveredPosition =
        _coveredRanges.fold<int>(0, (sum, r) => sum + r.end - r.start);
    return coveredPosition * 100 / textLength;
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
