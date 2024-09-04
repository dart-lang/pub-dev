// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @Tags(['presubmit-only'])
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:clock/clock.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:http/http.dart' as http;
import 'package:pub_dev/frontend/static_files.dart';
import 'package:test/test.dart';

import '../shared/test_services.dart';
import 'handlers/_utils.dart';

void main() {
  setUpAll(() => updateLocalBuiltFilesIfNeeded());

  group('ParsedStaticUrl', () {
    test('normal URL', () {
      final url =
          ParsedStaticUrl.parse(Uri.parse('/static/css/main.css?hash=123'));
      expect(url.urlHash, '123');
      expect(url.pathHash, isNull);
      expect(url.filePath, '/static/css/main.css');
    });

    test('hashed URL', () {
      final url =
          ParsedStaticUrl.parse(Uri.parse('/static/hash-abc1234/css/main.css'));
      expect(url.urlHash, isNull);
      expect(url.pathHash, 'abc1234');
      expect(url.filePath, '/static/css/main.css');
    });
  });

  group('dartdoc assets', () {
    Future<void> checkAsset(String url, String path) async {
      final rs = await http.get(Uri.parse(url));
      expect(rs.statusCode, 200);
      final staticContent = staticFileCache.getFile(path)!;
      expect(staticContent.bytes.length, rs.bodyBytes.length);
      final staticHash = crypto.sha256.convert(staticContent.bytes).toString();
      final dartdocHash = crypto.sha256.convert(rs.bodyBytes).toString();
      expect(staticHash, dartdocHash);
    }

    test(
      'github.css',
      () => checkAsset(
          'https://github.com/dart-lang/dartdoc/raw/main/lib/resources/github.css',
          '/static/highlight/github.css'),
      tags: ['sanity'],
    );

    test(
      'highlight.pack.js',
      () => checkAsset(
          'https://github.com/dart-lang/dartdoc/raw/main/lib/resources/highlight.pack.js',
          '/static/highlight/highlight.pack.js'),
      tags: ['sanity'],
    );
  });

  group('default content', () {
    late StaticFileCache cache;

    setUpAll(() async {
      await updateLocalBuiltFilesIfNeeded();
      cache = StaticFileCache.withDefaults();
    });

    test('has a short etag', () {
      expect(cache.etag, hasLength(8));
    });

    test('etag changes', () {
      final c = StaticFileCache();
      c.addFile(StaticFile('/static/e1.txt', 'text/plain', utf8.encode('abc'),
          clock.now(), 'etag1'));
      final e1 = c.etag;
      expect(e1, hasLength(8));
      c.addFile(StaticFile('/static/e2.txt', 'text/plain', utf8.encode('abc2'),
          clock.now(), 'etag2'));
      final e2 = c.etag;
      expect(e2, hasLength(8));
      expect(e2, isNot(e1));
    });

    test('third-party files are copied', () {
      final files = [
        '/static/css/github-markdown.css',
        '/static/highlight/github.css',
        '/static/highlight/highlight.pack.js',
        '/static/highlight/init.js',
        '/static/material/bundle/styles.css',
        '/static/material/bundle/script.min.js',
      ];

      for (String file in files) {
        final f = cache.getFile(file)!;
        expect(f, isNotNull, reason: file);
        expect(f.etag.contains('mocked_hash_'), isFalse, reason: file);
      }
    });

    testWithProfile('proper hash in css content', fn: () async {
      final css = cache.getFile('/static/css/style.css')!;
      final matches = RegExp('url\\("([^"]*?)"\\);')
          .allMatches(css.contentAsString)
          .toList();
      // expect some URLs
      expect(matches, hasLength(greaterThan(5)));
      for (final m in matches) {
        final matched = m.group(1)!;
        if (matched.contains('data:image')) continue;
        final uri = Uri.parse(matched);
        final absPath = Uri.parse('/static/hash-xyz/css/style.css')
            .resolve(uri.path)
            .toString();
        expect(absPath, startsWith('/static/hash-xyz/'));
        final rs = await issueGet(absPath);
        expect(rs.statusCode, 200, reason: matched);
        expect(await rs.read().toList(), isNotEmpty);
      }
    });

    test('static files are referenced', () async {
      final requestPaths = cache.keys.toSet()
        // not referenced from the code, but embedded from GTM
        ..remove('/static/js/survey-helper.js')
        // debug-helper files are served, but not referenced
        ..removeAll([
          '/static/css/dartdoc.css.map',
          '/static/css/style.css.map',
          '/static/js/script.dart.js.deps',
          '/static/js/script.dart.js.info.json',
          '/static/js/script.dart.js.map',
          '/static/material/bundle/script.min.js.map',
          '/static/material/bundle/styles.css.map',
          '/static/material/bundle/script.min.js.LICENSE.txt',
          '/static/material/bundle/styles.min.js',
        ])
        // script parts are served, but not referenced
        ..removeWhere(
          (e) =>
              e.startsWith('/static/js/script.dart.js_') &&
              (e.endsWith('.part.js') || e.endsWith('.part.js.map')),
        )
        // material build parts may be present in local dev environment
        ..removeWhere((e) => e.startsWith('/static/material/node_modules/'))
        // files that are in the third-party directory but not essential to serving
        ..removeAll([
          '/static/css/github-markdown.css-license.txt',
          '/static/highlight/readme.md',
          '/static/material/package-lock.json',
          '/static/material/package.json',
          '/static/material/README.md',
        ])
        // third-party CSS files that are included in the style.scss are no longer referenced elsewhere
        ..removeAll([
          '/static/css/dartdoc-github-alert.css',
          '/static/css/github-markdown.css',
          '/static/highlight/github.css',
          '/static/highlight/github-dark.css',
        ])
        // dartdoc files included through dartdoc.scss
        ..removeAll([
          '/static/dartdoc/resources/github.css',
          '/static/dartdoc/resources/styles.css',
        ])
        // dartdoc files not used, or included through javascript
        ..removeAll([
          '/static/dartdoc/resources/favicon.png',
          '/static/dartdoc/resources/play_button.svg',
          '/static/dartdoc/resources/docs.dart.js.map',
          '/static/dartdoc/resources/search.png', // probably used through old js
          '/static/dartdoc/resources/search.svg', // probably used through js
        ]);

      expect(requestPaths, hasLength(greaterThan(50)));

      final directories = [
        'lib',
        '../pkg/web_app/lib',
        '../pkg/web_css/lib',
      ];
      for (final dir in directories) {
        if (requestPaths.isEmpty) break;
        final files = await Directory(dir).list(recursive: true).toList();
        for (final file in files.whereType<File>()) {
          if (requestPaths.isEmpty) break;
          final content = await file.readAsString();
          for (final rp in requestPaths.toList()) {
            if (content.contains(rp) ||
                content.contains(rp.replaceFirst('/static/', '../'))) {
              requestPaths.remove(rp);
            }
          }
        }
      }
      expect(requestPaths, <String>{});
    });

    // This test loosely tracks the size of the main script.dart.js file,
    // the count of its split points and their size, in order to catch
    // sudden jumps in compiled web_app size. When this breaks, update
    // the size or count, and verify if the amount of change is reasonable.
    test('script.dart.js and parts size check', () {
      final file = cache.getFile('/static/js/script.dart.js');
      expect(file, isNotNull);
      expect((file!.bytes.length / 1024).round(), closeTo(343, 10));

      final parts = cache.paths
          .where((path) =>
              path.startsWith('/static/js/script.dart.js') &&
              path.endsWith('part.js'))
          .toList();
      expect(parts.length, closeTo(11, 3));
      final partsSize = parts
          .map((p) => cache.getFile(p)!.bytes.length)
          .reduce((a, b) => a + b);
      expect((partsSize / 1024).round(), closeTo(212, 10));
    });
  });

  group('static files handler', () {
    testWithProfile('bad path hash', fn: () async {
      registerStaticFileCacheForTest(StaticFileCache.withDefaults());
      final rs = await issueGet('/static/hash-xyz/img/email-icon.svg');
      expect(rs.statusCode, 200);
      expect(await rs.readAsString(), contains('<svg'));
      final cache = rs.headers['cache-control'];
      expect(cache, contains('no-store')); // no caching
    });

    testWithProfile('good path hash', fn: () async {
      registerStaticFileCacheForTest(StaticFileCache.withDefaults());
      final rs = await issueGet(
          '/static/hash-${staticFileCache.etag}/img/email-icon.svg');
      expect(rs.statusCode, 200);
      expect(await rs.readAsString(), contains('<svg'));
      final cache = rs.headers['cache-control']!;
      expect(cache, 'public, max-age=604800');
    });
  });
}
