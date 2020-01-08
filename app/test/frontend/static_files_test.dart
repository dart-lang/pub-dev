// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

@Tags(['presubmit-only'])

import 'dart:async';
import 'dart:io';

import 'package:crypto/crypto.dart' as crypto;
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

import 'package:pub_dev/frontend/static_files.dart';

void main() {
  setUpAll(() => updateLocalBuiltFilesIfNeeded());

  group('dartdoc assets', () {
    Future<void> checkAsset(String url, String path) async {
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

  group('Manual copy of files', () {
    test('pubapi.client.dart', () async {
      final f1 = File('lib/frontend/handlers/pubapi.client.dart');
      final c1 = await f1.readAsString();
      final f2 = File('../pkg/web_app/lib/src/pubapi.client.dart');
      final c2 = await f2.readAsString();
      expect(c2, c1);
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
      final css = cache.getFile('/static/css/style.css');
      for (Match m
          in RegExp('url\\("(.*)"\\);').allMatches(css.contentAsString)) {
        final matched = m.group(1);
        if (matched.contains('data:image')) continue;
        final uri = Uri.parse(matched);
        final absPath =
            Uri.parse('/static/css/style.css').resolve(uri.path).toString();
        final hash = uri.queryParameters['hash'] ?? '_no_hash_';
        final expectedHash = cache.getFile(absPath).etag;
        if (hash != expectedHash) {
          throw Exception('$absPath must use hash $expectedHash');
        }
      }
    });
  });
}
