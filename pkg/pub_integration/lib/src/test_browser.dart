// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:_pub_shared/validation/html/html_validation.dart';
import 'package:path/path.dart' as p;
import 'package:puppeteer/puppeteer.dart';
import 'package:puppeteer_screenshots/puppeteer_utils.dart';
import 'package:retry/retry.dart';

/// Filters server or client messages, ignoring and not reporting them as errors.
typedef IgnoreMessageFilter = bool Function(String message);

/// Creates and tracks the headless Chrome environment, its temp directories and
/// and uncaught exceptions.
class TestBrowser {
  final String? _testName;
  final String _origin;
  final String? _coverageDir;
  final Directory _tempDir;
  final bool _displayBrowser;
  Browser? _browser;
  late final _trackCoverage =
      _coverageDir != null || Platform.environment.containsKey('COVERAGE');
  final _trackedSessions = <TestBrowserSession>[];

  /// The coverage report of JavaScript files.
  final _jsCoverages = <String, _Coverage>{};

  /// The coverage report of CSS files.
  final _cssCoverages = <String, _Coverage>{};

  /// Filters to ignore server errors.
  final List<IgnoreMessageFilter>? _ignoreServerErrors;

  TestBrowser({
    required String origin,
    String? testName,
    String? coverageDir,
    bool displayBrowser = false,
    List<IgnoreMessageFilter>? ignoreServerErrors,
  }) : _displayBrowser = displayBrowser,
       _testName = testName,
       _origin = origin,
       _ignoreServerErrors = ignoreServerErrors,
       _coverageDir = coverageDir ?? Platform.environment['COVERAGE_DIR'],
       _tempDir = Directory.systemTemp.createTempSync('pub-headless');

  Future<String> _detectChromeBinary() async {
    // TODO: scan $PATH
    // check hardcoded values
    final binaries = ['/usr/bin/google-chrome'];

    for (final binary in binaries) {
      if (!File(binary).existsSync()) {
        continue;
      }
      try {
        // Get the local chrome's main version
        final pr = await retry(
          maxAttempts: 2,
          retryIf: (e) => e is TimeoutException,
          () async {
            return await Process.run(binary, [
              '--version',
            ]).timeout(Duration(seconds: 5));
          },
        );
        final output = pr.stdout.toString();
        final mainVersion = output
            .split(' ')
            .expand((p) => p.split('.'))
            .map(int.tryParse)
            .whereType<int>()
            .firstOrNull;
        // No version string, better not running it.
        if (mainVersion == null) continue;
        // Main version is after the currently supported version, will fail.
        // https://github.com/xvrh/puppeteer-dart/issues/364
        if (mainVersion >= 132) continue;

        return binary;
      } on TimeoutException catch (_) {
        print('Unable to detect chrome version with $binary');
        continue;
      }
    }

    // Otherwise let puppeteer download a chrome in the local .dart_tool directory:
    final r = await downloadChrome(cachePath: '.dart_tool/puppeteer/chromium');
    return r.executablePath;
  }

  Future<void> startBrowser() async {
    if (_browser != null) return;
    final chromeBin = await _detectChromeBinary();
    final userDataDir = await _tempDir.createTemp('user');
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
      headless: !_displayBrowser,
      devTools: false,
      defaultViewport: desktopDeviceViewport,
    );

    // Update the default permissions like clipboard access.
    await _browser!.defaultBrowserContext.overridePermissions(_origin, [
      PermissionType.clipboardReadWrite,
    ]);
  }

  Future<TestBrowserSession> createSession() async {
    final incognito = await _browser!.createIncognitoBrowserContext();
    await incognito.overridePermissions(_origin, [
      PermissionType.clipboardReadWrite,
    ]);
    final session = TestBrowserSession(this, incognito);
    _trackedSessions.add(session);
    return session;
  }

  Future<void> close() async {
    for (final s in _trackedSessions) {
      await s.close();
    }
    await _browser!.close();

    _printCoverage();
    if (_coverageDir != null) {
      await _saveCoverage(p.join(_coverageDir, 'puppeteer'));
    }
    await _tempDir.delete(recursive: true);
  }

  void _printCoverage() {
    for (final c in _jsCoverages.values) {
      print('${c.url}: ${c.percent.toStringAsFixed(2)}%');
    }
    for (final c in _cssCoverages.values) {
      print('${c.url}: ${c.percent.toStringAsFixed(2)}%');
    }
  }

  Future<void> _saveCoverage(String outputDir) async {
    Future<void> saveToFile(Map<String, _Coverage> map, String path) async {
      if (map.isNotEmpty) {
        final file = File(path);
        await file.parent.create(recursive: true);
        await file.writeAsString(
          json.encode(
            map.map(
              (k, v) => MapEntry<String, dynamic>(v.url, {
                'textLength': v.textLength,
                'ranges': v._coveredRanges.map((r) => r.toJson()).toList(),
              }),
            ),
          ),
        );
      }
    }

    final outputFileName = _testName ?? _generateTestName();
    await saveToFile(_jsCoverages, '$outputDir/$outputFileName.js.json');
    await saveToFile(_cssCoverages, '$outputDir/$outputFileName.css.json');
  }
}

class TestBrowserSession {
  final TestBrowser _browser;
  final BrowserContext _context;
  final _trackedPages = <Page>[];

  TestBrowserSession(this._browser, this._context);

  /// Creates a new page and setup overrides and tracking.
  Future<R> withPage<R>({required Future<R> Function(Page page) fn}) async {
    final clientErrors = <ClientError>[];
    final serverErrors = <String>[];
    final page = await _context.newPage();
    _pageOriginExpando[page] = _browser._origin;
    await page.setRequestInterception(true);
    if (_browser._trackCoverage) {
      await page.coverage.startJSCoverage(resetOnNavigation: false);
      await page.coverage.startCSSCoverage(resetOnNavigation: false);
    }

    page.onRequest.listen((rq) async {
      // soft-abort
      if (rq.url.startsWith('https://www.google-analytics.com/') ||
          rq.url.startsWith('https://www.googletagmanager.com/') ||
          rq.url.startsWith('https://www.google.com/insights') ||
          rq.url.startsWith(
            'https://www.gstatic.com/brandstudio/kato/cookie_choice_component/',
          )) {
        // reduce log error by replying with empty JS content
        if (rq.url.endsWith('.js') || rq.url.contains('.js?')) {
          await rq.respond(
            status: 200,
            body: '{}',
            contentType: 'application/javascript',
          );
        } else {
          await rq.abort(error: ErrorReason.failed);
        }
        return;
      }
      // ignore
      if (rq.url.startsWith('data:')) {
        await rq.continueRequest();
        return;
      }

      final uri = Uri.parse(rq.url);
      if (uri.path.contains('//')) {
        serverErrors.add('Double-slash URL detected: "${rq.url}".');
      }

      await rq.continueRequest();
    });

    page.onResponse.listen((rs) async {
      if (rs.status >= 500) {
        serverErrors.add(
          '${rs.status} ${rs.statusText} received on ${rs.request.url}',
        );
      } else if (rs.status >= 400 && rs.url.contains('/static/')) {
        serverErrors.add(
          '${rs.status} ${rs.statusText} received on ${rs.request.url}',
        );
      }

      final contentType = rs.headers[HttpHeaders.contentTypeHeader];
      if (contentType == null || contentType.isEmpty) {
        serverErrors.add(
          'Content type header is missing for ${rs.request.url}.',
        );
      }
      if (rs.status == 200 && contentType!.contains('text/html')) {
        try {
          parseAndValidateHtml(await rs.text);
        } catch (e) {
          final url = rs.request.url;
          if (url.contains('/documentation/') &&
              url.endsWith('-sidebar.html')) {
            // ignore dartdoc sidebars
          } else {
            serverErrors.add('$url returned bad HTML: $e');
          }
        }
      }

      if (rs.status == 200 &&
          rs.request.method.toUpperCase() == 'GET' &&
          // filters out data: and other-domain URLs
          rs.url.startsWith(_browser._origin)) {
        final uri = Uri.parse(rs.url);
        final firstPathSegment = uri.pathSegments.firstOrNull;

        if (firstPathSegment == 'static') {
          if (!uri.pathSegments[1].startsWith('hash-')) {
            serverErrors.add('Static URL ${rs.url} is without hash segment.');
          }
        }

        final shouldBePublic =
            firstPathSegment == 'static' ||
            firstPathSegment == 'documentation' ||
            uri.path == '/api/search-input-completion-data' ||
            (firstPathSegment == 'favicon.ico' &&
                uri.queryParameters.containsKey('hash'));
        final knownExemption =
            firstPathSegment == 'experimental' || firstPathSegment == 'report';
        final cacheHeader = rs.headers[HttpHeaders.cacheControlHeader];
        if (shouldBePublic && !knownExemption) {
          if (cacheHeader == null ||
              !cacheHeader.contains('public') ||
              !cacheHeader.contains('max-age')) {
            serverErrors.add(
              '${rs.url} is without public cache-control header (was: $cacheHeader).',
            );
          }
        }
        // NOTE: We have deliberately removed `cache-control: public` from pages that
        //       are both public and can have custom content based on the signed-in
        //       status (e.g. like button, admin links or the status in the header).
        //       https://github.com/dart-lang/pub-dev/pull/9035
        //
        //       To fix this, we need to test with different CDN configuration (e.g. to
        //       skip caching if the session cookie is present), or otherwise the
        //       combination of public caching + sign-in could result stale pages at the
        //       user's browser (see issue #9033).
        if (!shouldBePublic &&
            cacheHeader != null &&
            cacheHeader.contains('public')) {
          serverErrors.add(
            '${rs.url} must have non-public cache-control header (was: $cacheHeader).',
          );
        }
      }
    });

    // print console messages
    page.onConsole.listen(print);

    // print and store uncaught errors
    page.onError.listen((e) {
      if (e.toString().contains(
        'FocusTrap: Element must have at least one focusable child.',
      )) {
        // The error seems to come from material components, but it still works.
        // TODO: investigate if this is something we can change on our side.
        print('Ignored client error: $e');
        return;
      } else {
        print('Client error: $e');
        clientErrors.add(e);
      }
    });

    _trackedPages.add(page);

    try {
      final r = await fn(page);
      if (clientErrors.isNotEmpty) {
        throw Exception('Client errors detected: ${clientErrors.first}');
      }
      if (_browser._ignoreServerErrors != null) {
        serverErrors.removeWhere(
          (msg) => _browser._ignoreServerErrors!.any((fn) => fn(msg)),
        );
      }
      if (serverErrors.isNotEmpty) {
        throw Exception(
          '${serverErrors.length} server errors detected: ${serverErrors.first}',
        );
      }
      return r;
    } finally {
      await _closePage(page);
    }
  }

  /// Gets tracking results of [page] and closes it.
  Future<void> _closePage(Page page) async {
    if (_browser._trackCoverage) {
      final jsEntries = await page.coverage.stopJSCoverage();
      for (final e in jsEntries) {
        _browser._jsCoverages[e.url] ??= _Coverage(e.url);
        _browser._jsCoverages[e.url]!.textLength = e.text.length;
        _browser._jsCoverages[e.url]!.addRanges(e.ranges);
      }

      final cssEntries = await page.coverage.stopCSSCoverage();
      for (final e in cssEntries) {
        _browser._cssCoverages[e.url] ??= _Coverage(e.url);
        _browser._cssCoverages[e.url]!.textLength = e.text.length;
        _browser._cssCoverages[e.url]!.addRanges(e.ranges);
      }
    }

    await page.close();
    _trackedPages.remove(page);
  }

  Future<void> close() async {
    if (_trackedPages.isNotEmpty) {
      throw StateError('There are tracked pages with pending coverage report.');
    }
    await _context.close();
  }
}

String _generateTestName() {
  return [
    p.basenameWithoutExtension(Platform.script.path),
    DateTime.now().microsecondsSinceEpoch,
    ProcessInfo.currentRss,
  ].join('-');
}

/// Stores the origin URL on the page.
final _pageOriginExpando = Expando<String>();

extension PageExt on Page {
  /// The base URL of the pub.dev website.
  String get origin => _pageOriginExpando[this]!;

  /// Visits the [path] relative to the origin.
  Future<Response> gotoOrigin(String path) async {
    return await goto('$origin$path', wait: Until.networkIdle);
  }

  /// Returns the [property] value of the first element by [selector].
  Future<T> propertyValue<T>(String selector, String property) async {
    final h = await $(selector);
    return await h.propertyValue<T>(property);
  }
}

extension ElementHandleExt on ElementHandle {
  Future<String> textContent() async {
    return await propertyValue('textContent');
  }

  Future<String?> attributeValue(String name) async {
    final v = await evaluate('el => el.getAttribute("$name")');
    return v as String?;
  }
}

/// Track the covered ranges in the source file.
class _Coverage {
  final String url;
  int? textLength;

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
    final coveredPosition = _coveredRanges.fold<int>(
      0,
      (sum, r) => sum + r.end - r.start,
    );
    return coveredPosition * 100 / textLength!;
  }
}
