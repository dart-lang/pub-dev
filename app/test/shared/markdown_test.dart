// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/shared/markdown.dart';

void main() {
  group('Valid custom base URL', () {
    final baseUrl = 'https://github.com/example/project';

    test('relative within page', () {
      expect(markdownToHtml('[text](#relative)', null),
          '<p><a href="#relative">text</a></p>\n');
      expect(markdownToHtml('[text](#relative)', baseUrl),
          '<p><a href="#relative">text</a></p>\n');
      expect(markdownToHtml('[text](#relative)', '$baseUrl/'),
          '<p><a href="#relative">text</a></p>\n');
    });

    test('absolute URL', () {
      expect(markdownToHtml('[text](http://dartlang.org/)', null),
          '<p><a href="http://dartlang.org/">text</a></p>\n');
      expect(markdownToHtml('[text](http://dartlang.org/)', baseUrl),
          '<p><a href="http://dartlang.org/">text</a></p>\n');
      expect(markdownToHtml('[text](http://dartlang.org/)', '$baseUrl/'),
          '<p><a href="http://dartlang.org/">text</a></p>\n');
    });

    test('sibling within site', () {
      expect(markdownToHtml('[text](README.md)', null),
          '<p><a href="README.md">text</a></p>\n');
      expect(markdownToHtml('[text](README.md)', baseUrl),
          '<p><a href="https://github.com/example/project/README.md">text</a></p>\n');
      expect(markdownToHtml('[text](README.md)', '$baseUrl/'),
          '<p><a href="https://github.com/example/project/README.md">text</a></p>\n');
    });

    test('sibling plus relative link', () {
      expect(markdownToHtml('[text](README.md#section)', null),
          '<p><a href="README.md#section">text</a></p>\n');
      expect(markdownToHtml('[text](README.md#section)', baseUrl),
          '<p><a href="https://github.com/example/project/README.md#section">text</a></p>\n');
      expect(markdownToHtml('[text](README.md#section)', '$baseUrl/'),
          '<p><a href="https://github.com/example/project/README.md#section">text</a></p>\n');
    });

    test('child within site', () {
      expect(markdownToHtml('[text](example/README.md)', null),
          '<p><a href="example/README.md">text</a></p>\n');
      expect(markdownToHtml('[text](example/README.md)', baseUrl),
          '<p><a href="https://github.com/example/project/example/README.md">text</a></p>\n');
      expect(markdownToHtml('[text](example/README.md)', '$baseUrl/'),
          '<p><a href="https://github.com/example/project/example/README.md">text</a></p>\n');
    });

    test('root within site', () {
      expect(markdownToHtml('[text](/README.md)', null),
          '<p><a href="/README.md">text</a></p>\n');
      expect(markdownToHtml('[text](example/README.md)', baseUrl),
          '<p><a href="https://github.com/example/project/example/README.md">text</a></p>\n');
      expect(markdownToHtml('[text](example/README.md)', '$baseUrl/'),
          '<p><a href="https://github.com/example/project/example/README.md">text</a></p>\n');
    });

    test('email', () {
      expect(markdownToHtml('[me](mailto:email@example.com)', null),
          '<p><a href="mailto:email@example.com">me</a></p>\n');
      expect(markdownToHtml('[me](mailto:email@example.com)', baseUrl),
          '<p><a href="mailto:email@example.com">me</a></p>\n');
    });
  });

  group('Bad custom base URL', () {
    test('not http(s)', () {
      expect(markdownToHtml('[text](README.md)', 'ftp://example.com/blah'),
          '<p><a href="README.md">text</a></p>\n');
    });

    test('not valid host', () {
      expect(markdownToHtml('[text](README.md)', 'http://com/blah'),
          '<p><a href="README.md">text</a></p>\n');
    });
  });

  group('Bad markdown', () {
    test('bad link', () {
      expect(markdownToHtml('[a][b]', 'http://www.example.com/'),
          '<p>[a][b]</p>\n');
    });
  });
}
