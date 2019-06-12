// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@Tags(['presubmit-only'])

import 'dart:async';

import 'package:crypto/crypto.dart' as crypto;
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'package:pub_dartlang_org/frontend/static_files.dart';

void main() {
  setUpAll(() => updateLocalBuiltFiles());

  group('dartdoc assets', () {
    Future checkAsset(String url, String path) async {
      final rs = await http.get(url);
      expect(rs.statusCode, 200);
      final staticContent = staticFileCache.getFile(path);
      expect(staticContent.bytes.length, rs.bodyBytes.length);
      final staticHash = crypto.sha256.convert(staticContent.bytes).toString();
      final dartdocHash = crypto.sha256.convert(rs.bodyBytes).toString();
      expect(staticHash, dartdocHash);
    }

    test(
        'github.css',
        () => checkAsset(
            'https://github.com/dart-lang/dartdoc/raw/master/lib/resources/github.css',
            '/static/highlight/github.css'));

    test(
        'highlight.pack.js',
        () => checkAsset(
            'https://github.com/dart-lang/dartdoc/raw/master/lib/resources/highlight.pack.js',
            '/static/highlight/highlight.pack.js'));
  });

  group('mocked static files', () {
    test('exists', () {
      for (String path in hashedFiles) {
        final file = staticFileCache.getFile('/static/$path');
        expect(file, isNotNull);
        expect(file.bytes.length, greaterThan(10));
        expect(file.etag.contains('mocked_hash'), isFalse);
      }
    });

    test('urls populated with hash', () {
      final assets = staticUrls.assets;
      expect(assets.length, hashedFiles.length);
      for (String value in assets.values) {
        final parts = value.split('?hash=');
        expect(parts.length, greaterThan(1));
        expect(parts.last.length, greaterThan(20));
      }
    });
  });

  group('default content', () {
    final cache = StaticFileCache.withDefaults();
    final files = [
      '/static/css/github-markdown.css',
      '/static/highlight/github.css',
      '/static/highlight/highlight.pack.js',
      '/static/highlight/init.js',
    ];

    for (String file in files) {
      test('$file exists', () {
        final f = cache.getFile(file);
        expect(f, isNotNull);
        expect(f.etag.contains('mocked_hash_'), isFalse);
      });
    }

    test('proper hash in css content', () {
      final cssHashes = <String, String>{};
      final css = cache.getFile('/static/css/style.css');
      for (Match m
          in RegExp('url\\("(.*?)"\\);').allMatches(css.contentAsString)) {
        final matched = m.group(1);
        if (matched.contains('data:image')) continue;
        final uri = Uri.parse(matched);
        final absPath = p.normalize(p.join('/static/css', uri.path));
        final hash = uri.queryParameters['hash'] ?? '_no_hash_';
        if (cssHashes.containsKey(absPath) && cssHashes[absPath] != hash) {
          throw Exception(
              'Multiple hash for key: $absPath ($hash vs ${cssHashes[absPath]})');
        }
        cssHashes[absPath] = hash;
      }

      final expectedHashes = <String, String>{};
      final containedFiles = [
        '/static/img/background-pattern-darkblue.jpg',
        '/static/img/ic_email_black_18px.svg',
        '/static/img/ic_search_black_18px.svg',
      ];
      for (String file in containedFiles) {
        final cf = cache.getFile(file);
        expectedHashes[file] = cf.etag;
      }
      expect(cssHashes, expectedHashes);
    });
  });
}
