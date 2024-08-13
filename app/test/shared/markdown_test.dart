// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/shared/markdown.dart';
import 'package:test/test.dart';

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

  group('Valid custom base URL', () {
    final baseUrl = 'https://github.com/example/project';
    final urlResolverFn = fallbackUrlResolverFn(baseUrl);

    test('relative link within page', () {
      expect(markdownToHtml('[text](#relative)'),
          '<p><a href="#relative">text</a></p>\n');
      expect(markdownToHtml('[text](#relative)', urlResolverFn: urlResolverFn),
          '<p><a href="#relative">text</a></p>\n');
    });

    test('absolute link URL', () {
      expect(markdownToHtml('[text](http://dartlang.org/)'),
          '<p><a href="http://dartlang.org/" rel="ugc">text</a></p>\n');
      expect(
          markdownToHtml('[text](http://dartlang.org/)',
              urlResolverFn: urlResolverFn),
          '<p><a href="http://dartlang.org/" rel="ugc">text</a></p>\n');
    });

    test('absolute image URL', () {
      expect(markdownToHtml('![text](http://dartlang.org/image.png)'),
          '<p><img src="http://dartlang.org/image.png" alt="text"></p>\n');
      expect(
          markdownToHtml('![text](http://dartlang.org/image.png)',
              urlResolverFn: urlResolverFn),
          '<p><img src="http://dartlang.org/image.png" alt="text"></p>\n');
    });

    test('sibling link within site', () {
      expect(markdownToHtml('[text](README.md)'), '<p>text</p>\n');
      expect(markdownToHtml('[text](README.md)', urlResolverFn: urlResolverFn),
          '<p><a href="https://github.com/example/project/blob/master/README.md" rel="ugc">text</a></p>\n');
    });

    test('sibling image within site', () {
      expect(markdownToHtml('![text](image.png)'), '<p>[text]</p>\n');
      expect(markdownToHtml('![text](image.png)', urlResolverFn: urlResolverFn),
          '<p><img src="https://github.com/example/project/raw/master/image.png" alt="text"></p>\n');
    });

    test('sibling image inside a relative directory', () {
      expect(
          markdownToHtml('![text](image.png)',
              relativeFrom: 'example/README.md'),
          '<p>[text]</p>\n');
      expect(
          markdownToHtml('![text](image.png)',
              urlResolverFn: urlResolverFn, relativeFrom: 'example/README.md'),
          '<p><img src="https://github.com/example/project/raw/master/example/image.png" alt="text"></p>\n');
    });

    test('sibling link plus relative link', () {
      expect(markdownToHtml('[text](README.md#section)'), '<p>text</p>\n');
      expect(
          markdownToHtml('[text](README.md#section)',
              urlResolverFn: urlResolverFn),
          '<p><a href="https://github.com/example/project/blob/master/README.md#section" rel="ugc">text</a></p>\n');
    });

    test('child link within site', () {
      expect(markdownToHtml('[text](example/README.md)'), '<p>text</p>\n');
      expect(
          markdownToHtml('[text](example/README.md)',
              urlResolverFn: urlResolverFn),
          '<p><a href="https://github.com/example/project/blob/master/example/README.md" rel="ugc">text</a></p>\n');
    });

    test('child image within site', () {
      expect(markdownToHtml('![text](example/image.png)'), '<p>[text]</p>\n');
      expect(
          markdownToHtml('![text](example/image.png)',
              urlResolverFn: urlResolverFn),
          '<p><img src="https://github.com/example/project/raw/master/example/image.png" alt="text"></p>\n');
    });

    test('root link within site', () {
      expect(markdownToHtml('[text](/README.md)'), '<p>text</p>\n');
      expect(
          markdownToHtml('[text](/example/README.md)',
              urlResolverFn: urlResolverFn),
          '<p><a href="https://github.com/example/README.md" rel="ugc">text</a></p>\n');
    });

    test('root image within site', () {
      expect(markdownToHtml('![text](/image.png)'), '<p>[text]</p>\n');
      expect(
          markdownToHtml('![text](/example/image.png)',
              urlResolverFn: urlResolverFn),
          '<p><img src="https://github.com/example/image.png" alt="text"></p>\n');
    });

    test('email', () {
      expect(markdownToHtml('[me](mailto:email@example.com)'),
          '<p><a href="mailto:email@example.com">me</a></p>\n');
      expect(
          markdownToHtml('[me](mailto:email@example.com)',
              urlResolverFn: urlResolverFn),
          '<p><a href="mailto:email@example.com">me</a></p>\n');
    });
  });

  group('Bad custom base URL', () {
    test('not http(s)', () {
      expect(
          markdownToHtml('[text](README.md)',
              urlResolverFn: fallbackUrlResolverFn('ftp://example.com/blah')),
          '<p>text</p>\n');
    });

    test('not valid host', () {
      expect(
          markdownToHtml('[text](README.md)',
              urlResolverFn: fallbackUrlResolverFn('http://com/blah')),
          '<p>text</p>\n');
    });
  });

  group('Unsafe markdown', () {
    test('javascript link', () {
      expect(markdownToHtml('[a](javascript:alert("x"))'), '<p><a>a</a></p>\n');
    });
  });

  group('Bad markdown', () {
    test('bad link', () {
      expect(
          markdownToHtml('[a][b]',
              urlResolverFn: fallbackUrlResolverFn('http://www.example.com/')),
          '<p>[a][b]</p>\n');
    });

    test('bad link, keeping link text', () {
      expect(markdownToHtml('[my illegal url](http://illegal@@thing)'),
          '<p>my illegal url</p>\n');
    });

    test('complex link inside a quote, keeping link content', () {
      expect(
          markdownToHtml(
              '> [**awesome**](href="https://github.com/a/b/c.gif")'),
          '<blockquote>\n<p><strong>awesome</strong></p>\n</blockquote>\n');
    });

    test('bad image link with attribute', () {
      expect(markdownToHtml('![demo](src="https://github.com/a/b/c.gif")'),
          '<p>[demo]</p>\n');
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
        '<p><a href="https://google.com" rel="ugc">link</a></p>\n',
      );
    });

    test('<br/>', () {
      expect(markdownToHtml('a <br>b'), '<p>a <br>b</p>\n');
      expect(markdownToHtml('a <br  />b'), '<p>a <br>b</p>\n');
    });
  });

  group('<summary>', () {
    test('FIXME: <summary> must not exists in a list item', () {
      expect(
        markdownToHtml('- a<summary>b\n- c'),
        '<ul>\n'
        '<li>a<summary>b</summary></li>\n'
        '<li>c</li>\n'
        '</ul>\n',
      );
    });

    test('FIXME: <summary> must not exists without <details>', () {
      expect(
        markdownToHtml('A <summary>b</summary>.'),
        '<p>A </p><summary>b</summary>.<p></p>\n',
      );
    });

    test('FIXME: <summary> should be the first child of details', () {
      expect(
        markdownToHtml('A <details> <b>bold</b> <summary>b</summary>.'),
        '<p>A </p><details> <b>bold</b> <summary>b</summary>.<p></p></details>\n',
      );
    });

    test('FIXME: <summary> should render <code> blocks inside', () {
      expect(
        '<details>\n'
            '<summary>\n'
            'Package language version (indicated by the sdk constraint `>=2.0.0-dev.48.0 <3.0.0`) is less than 2.12.\n'
            '</summary>\n\n'
            'Consider [migrating](https://dart.dev/null-safety/migration-guide).\n'
            '</details>',
        '<details>\n'
            '<summary>\n'
            'Package language version (indicated by the sdk constraint `>=2.0.0-dev.48.0 <3.0.0`) is less than 2.12.\n'
            '</summary>\n\n'
            'Consider [migrating](https://dart.dev/null-safety/migration-guide).\n'
            '</details>',
      );
    });

    test('<details> and <summary>', () {
      expect(
        markdownToHtml('<details><summary>A</summary>B</details>'),
        '<details><summary>A</summary>B</details>\n',
      );
    });
  });

  group('GitHub rewrites', () {
    test('absolute url: http://[..]/blob/master/[path].gif', () {
      expect(
          markdownToHtml(
              '![text](https://github.com/rcpassos/progress_hud/blob/master/progress_hud.gif)'),
          '<p><img src="https://github.com/rcpassos/progress_hud/blob/master/progress_hud.gif" alt="text"></p>\n');
    });

    test('root path: /[..]/blob/master/[path].gif', () {
      expect(
          markdownToHtml(
              '![text](/rcpassos/progress_hud/blob/master/progress_hud.gif)',
              urlResolverFn: fallbackUrlResolverFn(
                  'https://github.com/rcpassos/progress_hud')),
          '<p><img src="https://github.com/rcpassos/progress_hud/raw/master/progress_hud.gif" alt="text"></p>\n');
    });

    test('relative path: [path].gif', () {
      expect(
          markdownToHtml('![text](progress_hud.gif)',
              urlResolverFn: fallbackUrlResolverFn(
                  'https://github.com/rcpassos/progress_hud')),
          '<p><img src="https://github.com/rcpassos/progress_hud/raw/master/progress_hud.gif" alt="text"></p>\n');
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
          '<h1 class="hash-header" id="changelog">Changelog <a href="#changelog" class="hash-link">#</a></h1>\n'
          '<div class="changelog-entry">\n'
          '<h2 class="changelog-version hash-header" id="100">1.0.0 <a href="#100" class="hash-link">#</a></h2>\n'
          '<div class="changelog-content">\n'
          '<ul>\n'
          '<li>change1</li>\n'
          '</ul>\n'
          '</div>\n'
          '</div>\n');
    });

    test('multiple entries', () {
      expect(
          markdownToHtml(
              '# Changelog\n\n'
              '## 1.0.0\n\n- change1\n\n- change2\n\n'
              '## 0.9.0\n\nMostly refactoring',
              isChangelog: true),
          '<h1 class="hash-header" id="changelog">Changelog <a href="#changelog" class="hash-link">#</a></h1>\n'
          '<div class="changelog-entry">\n'
          '<h2 class="changelog-version hash-header" id="100">1.0.0 <a href="#100" class="hash-link">#</a></h2>\n'
          '<div class="changelog-content">\n'
          '<ul>\n'
          '<li>\n<p>change1</p>\n</li>\n'
          '<li>\n<p>change2</p>\n</li>\n'
          '</ul>\n'
          '</div>\n'
          '</div>\n'
          '<div class="changelog-entry">\n'
          '<h2 class="changelog-version hash-header" id="090">0.9.0 <a href="#090" class="hash-link">#</a></h2>\n'
          '<div class="changelog-content">\n'
          '<p>Mostly refactoring</p>\n'
          '</div>\n'
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
        '<h2 class="changelog-version hash-header" id="210">2.1.0 <a href="#210" class="hash-link">#</a></h2>',
        '<h2 class="changelog-version hash-header" id="200">2.0.0 <a href="#200" class="hash-link">#</a></h2>',
        '<h2 class="changelog-version hash-header" id="100-2">1.0.0 <a href="#100" class="hash-link">#</a></h2>',
      ]);
    });

    test('extra text after version', () {
      final output = markdownToHtml(
          '# Changelog\n\n'
          '## 1.0.0 (retracted)\n'
          '\n'
          '- change1',
          isChangelog: true);
      final lines = output
          .split('\n')
          .where((l) => l.contains('changelog-version'))
          .toList();
      expect(
        lines.single,
        '<h2 class="changelog-version hash-header" id="100-retracted">'
        '1.0.0 (retracted) '
        '<a href="#100-retracted" class="hash-link">#</a>'
        '</h2>',
      );
    });

    test('fancy format', () {
      final output = markdownToHtml(
          '# Changelog\n\n'
          '## [1.0.0] - 2022-05-30\n'
          '\n'
          '- change1',
          isChangelog: true);
      final lines = output
          .split('\n')
          .where((l) => l.contains('changelog-version'))
          .toList();
      expect(
        lines.single,
        '<h2 class="changelog-version hash-header" id="100---2022-05-30">'
        '[1.0.0] - 2022-05-30 '
        '<a href="#100---2022-05-30" class="hash-link">#</a>'
        '</h2>',
      );
    });
  });
}
