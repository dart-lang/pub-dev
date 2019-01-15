// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/shared/markdown.dart';

void main() {
  group('markup', () {
    test('emoji support', () {
      expect(markdownToHtml(':white_check_mark:', null), '<p>✅</p>\n');
    });

    test('do not render inline html', () {
      expect(markdownToHtml('<a></a>', null), '<p>&lt;a>&lt;/a></p>\n');
    });

    test('render link ids', () {
      expect(markdownToHtml('# ABC def', null),
          '<h1 class="hash-header" id="abc-def">ABC def <a class="hash-link" href="#abc-def">#</a></h1>\n');
    });
  });

  group('Valid custom base URL', () {
    final String baseUrl = 'https://github.com/example/project';

    test('relative link within page', () {
      expect(markdownToHtml('[text](#relative)', null),
          '<p><a href="#relative">text</a></p>\n');
      expect(markdownToHtml('[text](#relative)', baseUrl),
          '<p><a href="#relative">text</a></p>\n');
      expect(markdownToHtml('[text](#relative)', '$baseUrl/'),
          '<p><a href="#relative">text</a></p>\n');
    });

    test('absolute link URL', () {
      expect(markdownToHtml('[text](http://dartlang.org/)', null),
          '<p><a href="http://dartlang.org/">text</a></p>\n');
      expect(markdownToHtml('[text](http://dartlang.org/)', baseUrl),
          '<p><a href="http://dartlang.org/">text</a></p>\n');
      expect(markdownToHtml('[text](http://dartlang.org/)', '$baseUrl/'),
          '<p><a href="http://dartlang.org/">text</a></p>\n');
    });

    test('absolute image URL', () {
      expect(markdownToHtml('![text](http://dartlang.org/image.png)', null),
          '<p><img alt="text" src="http://dartlang.org/image.png" /></p>\n');
      expect(markdownToHtml('![text](http://dartlang.org/image.png)', baseUrl),
          '<p><img alt="text" src="http://dartlang.org/image.png" /></p>\n');
      expect(
          markdownToHtml('![text](http://dartlang.org/image.png)', '$baseUrl/'),
          '<p><img alt="text" src="http://dartlang.org/image.png" /></p>\n');
    });

    test('sibling link within site', () {
      expect(markdownToHtml('[text](README.md)', null),
          '<p><a href="README.md">text</a></p>\n');
      expect(markdownToHtml('[text](README.md)', baseUrl),
          '<p><a href="https://github.com/example/project/blob/master/README.md">text</a></p>\n');
      expect(markdownToHtml('[text](README.md)', '$baseUrl/'),
          '<p><a href="https://github.com/example/project/blob/master/README.md">text</a></p>\n');
    });

    test('sibling image within site', () {
      expect(markdownToHtml('![text](image.png)', null),
          '<p><img alt="text" src="image.png" /></p>\n');
      expect(markdownToHtml('![text](image.png)', baseUrl),
          '<p><img alt="text" src="https://github.com/example/project/raw/master/image.png" /></p>\n');
      expect(markdownToHtml('![text](image.png)', '$baseUrl/'),
          '<p><img alt="text" src="https://github.com/example/project/raw/master/image.png" /></p>\n');
    });

    test('sibling link plus relative link', () {
      expect(markdownToHtml('[text](README.md#section)', null),
          '<p><a href="README.md#section">text</a></p>\n');
      expect(markdownToHtml('[text](README.md#section)', baseUrl),
          '<p><a href="https://github.com/example/project/blob/master/README.md#section">text</a></p>\n');
      expect(markdownToHtml('[text](README.md#section)', '$baseUrl/'),
          '<p><a href="https://github.com/example/project/blob/master/README.md#section">text</a></p>\n');
    });

    test('child link within site', () {
      expect(markdownToHtml('[text](example/README.md)', null),
          '<p><a href="example/README.md">text</a></p>\n');
      expect(markdownToHtml('[text](example/README.md)', baseUrl),
          '<p><a href="https://github.com/example/project/blob/master/example/README.md">text</a></p>\n');
      expect(markdownToHtml('[text](example/README.md)', '$baseUrl/'),
          '<p><a href="https://github.com/example/project/blob/master/example/README.md">text</a></p>\n');
    });

    test('child image within site', () {
      expect(markdownToHtml('![text](example/image.png)', null),
          '<p><img alt="text" src="example/image.png" /></p>\n');
      expect(markdownToHtml('![text](example/image.png)', baseUrl),
          '<p><img alt="text" src="https://github.com/example/project/raw/master/example/image.png" /></p>\n');
      expect(markdownToHtml('![text](example/image.png)', '$baseUrl/'),
          '<p><img alt="text" src="https://github.com/example/project/raw/master/example/image.png" /></p>\n');
    });

    test('root link within site', () {
      expect(markdownToHtml('[text](/README.md)', null),
          '<p><a href="/README.md">text</a></p>\n');
      expect(markdownToHtml('[text](/example/README.md)', baseUrl),
          '<p><a href="https://github.com/example/README.md">text</a></p>\n');
      expect(markdownToHtml('[text](/example/README.md)', '$baseUrl/'),
          '<p><a href="https://github.com/example/README.md">text</a></p>\n');
    });

    test('root image within site', () {
      expect(markdownToHtml('![text](/image.png)', null),
          '<p><img alt="text" src="/image.png" /></p>\n');
      expect(markdownToHtml('![text](/example/image.png)', baseUrl),
          '<p><img alt="text" src="https://github.com/example/image.png" /></p>\n');
      expect(markdownToHtml('![text](/example/image.png)', '$baseUrl/'),
          '<p><img alt="text" src="https://github.com/example/image.png" /></p>\n');
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

  group('GitHub rewrites', () {
    test('absolute url: http://[..]/blob/master/[path].gif', () {
      expect(
          markdownToHtml(
              '![text](https://github.com/rcpassos/progress_hud/blob/master/progress_hud.gif)',
              null),
          '<p><img alt="text" src="https://github.com/rcpassos/progress_hud/raw/master/progress_hud.gif" /></p>\n');
    });

    test('root path: /[..]/blob/master/[path].gif', () {
      expect(
          markdownToHtml(
              '![text](/rcpassos/progress_hud/blob/master/progress_hud.gif)',
              'https://github.com/rcpassos/progress_hud'),
          '<p><img alt="text" src="https://github.com/rcpassos/progress_hud/raw/master/progress_hud.gif" /></p>\n');
    });

    test('relative path: [path].gif', () {
      expect(
          markdownToHtml('![text](progress_hud.gif)',
              'https://github.com/rcpassos/progress_hud'),
          '<p><img alt="text" src="https://github.com/rcpassos/progress_hud/raw/master/progress_hud.gif" /></p>\n');
    });
  });
}
