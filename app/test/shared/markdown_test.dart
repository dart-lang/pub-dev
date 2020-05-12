// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dev/shared/markdown.dart';

void main() {
  group('markup', () {
    test('emoji support', () {
      expect(markdownToHtml(':white_check_mark:'), '<p>✅</p>\n');
    });

    test('render link id and class', () {
      expect(markdownToHtml('# ABC def'),
          '<h1 class="hash-header" id="abc-def">ABC def <a href="#abc-def" class="hash-link">#</a></h1>\n');
    });
  });

  group('inline only', () {
    String inline(String source) => markdownToHtml(source, inlineOnly: true);

    test('empty lines', () {
      expect(inline('abcd\nefg'), 'abcd\nefg');
      expect(inline('abcd\r\nefg'), 'abcd\nefg');
      expect(inline('abcd\n\nefg'), 'abcd<br>\nefg');
      expect(inline('abcd\n\n\n\nefg'), 'abcd<br>\nefg');
      expect(inline('abcd\r\n\r\nefg'), 'abcd<br>\nefg');
      expect(inline('abcd\r\n\r\n\r\n\r\nefg'), 'abcd<br>\nefg');
    });

    test('*text*', () {
      expect(inline('*'), '*');
      expect(inline('*a'), '*a');
      expect(inline('a*'), 'a*');
      expect(inline('a*a'), 'a*a');
      expect(inline('*a*'), '<em>a</em>');
      expect(inline('b *a* b'), 'b <em>a</em> b');
    });

    test('**text**', () {
      expect(inline('**'), '**');
      expect(inline('**a'), '**a');
      expect(inline('a**'), 'a**');
      expect(inline('a**a'), 'a**a');
      expect(inline('**a**'), '<strong>a</strong>');
      expect(inline('b **a** b'), 'b <strong>a</strong> b');
    });

    test('mixed markup: **text*', () {
      expect(inline('**a*'), '*<em>a</em>');
      expect(inline('*a**'), '<em>a</em>*');
    });

    test('link is not transformed', () {
      expect(inline('[text](http://example.com/)'), 'text');
    });

    test('image is not transformed', () {
      expect(inline('![text](http://example.com/image.png)'), '');
    });

    test('link inside strong is not transformed', () {
      expect(
          inline('**[text](http://example.com/)**'), '<strong>text</strong>');
    });

    test('a reasonable text', () {
      expect(inline('We are a **Flutter developer shop**. Blah, blah, blah...'),
          'We are a <strong>Flutter developer shop</strong>. Blah, blah, blah...');
    });
  });

  group('Valid custom base URL', () {
    final String baseUrl = 'https://github.com/example/project';

    test('relative link within page', () {
      expect(markdownToHtml('[text](#relative)'),
          '<p><a href="#relative">text</a></p>\n');
      expect(markdownToHtml('[text](#relative)', baseUrl: baseUrl),
          '<p><a href="#relative">text</a></p>\n');
      expect(markdownToHtml('[text](#relative)', baseUrl: '$baseUrl/'),
          '<p><a href="#relative">text</a></p>\n');
    });

    test('absolute link URL', () {
      expect(markdownToHtml('[text](http://dartlang.org/)'),
          '<p><a href="http://dartlang.org/">text</a></p>\n');
      expect(markdownToHtml('[text](http://dartlang.org/)', baseUrl: baseUrl),
          '<p><a href="http://dartlang.org/">text</a></p>\n');
      expect(
          markdownToHtml('[text](http://dartlang.org/)', baseUrl: '$baseUrl/'),
          '<p><a href="http://dartlang.org/">text</a></p>\n');
    });

    test('absolute image URL', () {
      expect(markdownToHtml('![text](http://dartlang.org/image.png)'),
          '<p><img src="http://dartlang.org/image.png" alt="text" /></p>\n');
      expect(
          markdownToHtml('![text](http://dartlang.org/image.png)',
              baseUrl: baseUrl),
          '<p><img src="http://dartlang.org/image.png" alt="text" /></p>\n');
      expect(
          markdownToHtml('![text](http://dartlang.org/image.png)',
              baseUrl: '$baseUrl/'),
          '<p><img src="http://dartlang.org/image.png" alt="text" /></p>\n');
    });

    test('sibling link within site', () {
      expect(markdownToHtml('[text](README.md)'),
          '<p><a href="README.md">text</a></p>\n');
      expect(markdownToHtml('[text](README.md)', baseUrl: baseUrl),
          '<p><a href="https://github.com/example/project/blob/master/README.md">text</a></p>\n');
      expect(markdownToHtml('[text](README.md)', baseUrl: '$baseUrl/'),
          '<p><a href="https://github.com/example/project/blob/master/README.md">text</a></p>\n');
    });

    test('sibling image within site', () {
      expect(markdownToHtml('![text](image.png)'),
          '<p><img src="image.png" alt="text" /></p>\n');
      expect(markdownToHtml('![text](image.png)', baseUrl: baseUrl),
          '<p><img src="https://github.com/example/project/raw/master/image.png" alt="text" /></p>\n');
      expect(markdownToHtml('![text](image.png)', baseUrl: '$baseUrl/'),
          '<p><img src="https://github.com/example/project/raw/master/image.png" alt="text" /></p>\n');
    });

    test('sibling image inside a relative directory', () {
      expect(markdownToHtml('![text](image.png)', baseDir: 'example'),
          '<p><img src="image.png" alt="text" /></p>\n');
      expect(
          markdownToHtml('![text](image.png)',
              baseUrl: baseUrl, baseDir: 'example'),
          '<p><img src="https://github.com/example/project/raw/master/example/image.png" alt="text" /></p>\n');
      expect(
          markdownToHtml('![text](img/image.png)',
              baseUrl: '$baseUrl/', baseDir: 'example'),
          '<p><img src="https://github.com/example/project/raw/master/example/img/image.png" alt="text" /></p>\n');
    });

    test('sibling link plus relative link', () {
      expect(markdownToHtml('[text](README.md#section)'),
          '<p><a href="README.md#section">text</a></p>\n');
      expect(markdownToHtml('[text](README.md#section)', baseUrl: baseUrl),
          '<p><a href="https://github.com/example/project/blob/master/README.md#section">text</a></p>\n');
      expect(markdownToHtml('[text](README.md#section)', baseUrl: '$baseUrl/'),
          '<p><a href="https://github.com/example/project/blob/master/README.md#section">text</a></p>\n');
    });

    test('child link within site', () {
      expect(markdownToHtml('[text](example/README.md)'),
          '<p><a href="example/README.md">text</a></p>\n');
      expect(markdownToHtml('[text](example/README.md)', baseUrl: baseUrl),
          '<p><a href="https://github.com/example/project/blob/master/example/README.md">text</a></p>\n');
      expect(markdownToHtml('[text](example/README.md)', baseUrl: '$baseUrl/'),
          '<p><a href="https://github.com/example/project/blob/master/example/README.md">text</a></p>\n');
    });

    test('child image within site', () {
      expect(markdownToHtml('![text](example/image.png)'),
          '<p><img src="example/image.png" alt="text" /></p>\n');
      expect(markdownToHtml('![text](example/image.png)', baseUrl: baseUrl),
          '<p><img src="https://github.com/example/project/raw/master/example/image.png" alt="text" /></p>\n');
      expect(markdownToHtml('![text](example/image.png)', baseUrl: '$baseUrl/'),
          '<p><img src="https://github.com/example/project/raw/master/example/image.png" alt="text" /></p>\n');
    });

    test('root link within site', () {
      expect(markdownToHtml('[text](/README.md)'),
          '<p><a href="/README.md">text</a></p>\n');
      expect(markdownToHtml('[text](/example/README.md)', baseUrl: baseUrl),
          '<p><a href="https://github.com/example/README.md">text</a></p>\n');
      expect(markdownToHtml('[text](/example/README.md)', baseUrl: '$baseUrl/'),
          '<p><a href="https://github.com/example/README.md">text</a></p>\n');
    });

    test('root image within site', () {
      expect(markdownToHtml('![text](/image.png)'),
          '<p><img src="/image.png" alt="text" /></p>\n');
      expect(markdownToHtml('![text](/example/image.png)', baseUrl: baseUrl),
          '<p><img src="https://github.com/example/image.png" alt="text" /></p>\n');
      expect(
          markdownToHtml('![text](/example/image.png)', baseUrl: '$baseUrl/'),
          '<p><img src="https://github.com/example/image.png" alt="text" /></p>\n');
    });

    test('email', () {
      expect(markdownToHtml('[me](mailto:email@example.com)'),
          '<p><a href="mailto:email@example.com">me</a></p>\n');
      expect(markdownToHtml('[me](mailto:email@example.com)', baseUrl: baseUrl),
          '<p><a href="mailto:email@example.com">me</a></p>\n');
    });
  });

  group('Bad custom base URL', () {
    test('not http(s)', () {
      expect(
          markdownToHtml('[text](README.md)',
              baseUrl: 'ftp://example.com/blah'),
          '<p><a href="README.md">text</a></p>\n');
    });

    test('not valid host', () {
      expect(markdownToHtml('[text](README.md)', baseUrl: 'http://com/blah'),
          '<p><a href="README.md">text</a></p>\n');
    });
  });

  group('Unsafe markdown', () {
    test('javascript link', () {
      expect(markdownToHtml('[a](javascript:alert("x"))'), '<p><a>a</a></p>\n');
    });
  });

  group('Bad markdown', () {
    test('bad link', () {
      expect(markdownToHtml('[a][b]', baseUrl: 'http://www.example.com/'),
          '<p>[a][b]</p>\n');
    });
  });

  group('non-whitelisted inline HTML', () {
    test('script', () {
      expect(markdownToHtml('<script></script>'), '\n');
    });
  });

  group('whitelisted inline HTML', () {
    test('a', () {
      expect(
        markdownToHtml('<a href="https://google.com">link</a>'),
        '<p><a href="https://google.com">link</a></p>\n',
      );
    });

    test('<br/>', () {
      expect(markdownToHtml('a <br>b'), '<p>a <br />b</p>\n');
      expect(markdownToHtml('a <br  />b'), '<p>a <br />b</p>\n');
    });
  });

  group('GitHub rewrites', () {
    test('absolute url: http://[..]/blob/master/[path].gif', () {
      expect(
          markdownToHtml(
              '![text](https://github.com/rcpassos/progress_hud/blob/master/progress_hud.gif)'),
          '<p><img src="https://github.com/rcpassos/progress_hud/raw/master/progress_hud.gif" alt="text" /></p>\n');
    });

    test('root path: /[..]/blob/master/[path].gif', () {
      expect(
          markdownToHtml(
              '![text](/rcpassos/progress_hud/blob/master/progress_hud.gif)',
              baseUrl: 'https://github.com/rcpassos/progress_hud'),
          '<p><img src="https://github.com/rcpassos/progress_hud/raw/master/progress_hud.gif" alt="text" /></p>\n');
    });

    test('relative path: [path].gif', () {
      expect(
          markdownToHtml('![text](progress_hud.gif)',
              baseUrl: 'https://github.com/rcpassos/progress_hud'),
          '<p><img src="https://github.com/rcpassos/progress_hud/raw/master/progress_hud.gif" alt="text" /></p>\n');
    });
  });

  group('changelog', () {
    test('no structure', () {
      expect(
          markdownToHtml(
              'a\n\n'
              'b\n\n'
              'c',
              isChangelog: true),
          '<p>a</p>\n'
          '<p>b</p>\n'
          '<p>c</p>\n');
    });

    test('single entry', () {
      expect(
          markdownToHtml(
              '# Changelog\n\n'
              '## 1.0.0\n'
              '\n'
              '- change1',
              isChangelog: true),
          '<h1 class="hash-header" id="changelog">Changelog <a href="#changelog" class="hash-link">#</a></h1>'
          '<div class="changelog-entry">\n'
          '<h2 class="changelog-version hash-header" id="100">1.0.0 <a href="#100" class="hash-link">#</a></h2>'
          '<div class="changelog-content">\n'
          '<ul>\n'
          '<li>change1</li>\n'
          '</ul>'
          '</div>'
          '</div>\n');
    });

    test('multiple entries', () {
      expect(
          markdownToHtml(
              '# Changelog\n\n'
              '## 1.0.0\n\n- change1\n\n- change2\n\n'
              '## 0.9.0\n\nMostly refatoring',
              isChangelog: true),
          '<h1 class="hash-header" id="changelog">Changelog <a href="#changelog" class="hash-link">#</a></h1>'
          '<div class="changelog-entry">\n'
          '<h2 class="changelog-version hash-header" id="100">1.0.0 <a href="#100" class="hash-link">#</a></h2>'
          '<div class="changelog-content">\n'
          '<ul>\n'
          '<li>\n<p>change1</p>\n</li>\n'
          '<li>\n<p>change2</p>\n</li>\n'
          '</ul>'
          '</div>'
          '</div>'
          '<div class="changelog-entry">\n'
          '<h2 class="changelog-version hash-header" id="090">0.9.0 <a href="#090" class="hash-link">#</a></h2>'
          '<div class="changelog-content">\n'
          '<p>Mostly refatoring</p>'
          '</div>'
          '</div>\n');
    });

    test('zebras', () {
      final output = markdownToHtml(
        '''# 2.1.0
 * Zebras can now encode bar-codes
## Upgrading from
### 1.0.0
 * Elephants are now scared of mice. 
### 0.9.0
 * Take care to feed lion before releasing mice.

-------

# 2.0.0
 * Zebras have been added.
 * Elephants are now scared of mice. 

-------

# 1.0.0
 * Take care to feed lion before releasing mice.''',
        isChangelog: true,
      );
      final lines = output.split('\n');

      // Only 2.1.0, 2.0.0 and 1.0.0 should be recognized as versions.
      expect(lines.where((l) => l.contains('changelog-version')), [
        '<h2 class="changelog-version hash-header" id="210">2.1.0 <a href="#210" class="hash-link">#</a></h2><div class="changelog-content">',
        '<h2 class="changelog-version hash-header" id="200">2.0.0 <a href="#200" class="hash-link">#</a></h2><div class="changelog-content">',
        '<h2 class="changelog-version hash-header" id="100-2">1.0.0 <a href="#100" class="hash-link">#</a></h2><div class="changelog-content">',
      ]);
    });
  });
}
