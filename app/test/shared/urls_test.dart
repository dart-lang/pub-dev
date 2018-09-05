// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/shared/urls.dart';

void main() {
  group('package page', () {
    test('without host', () {
      expect(pkgPageUrl('foo_bar'), '/packages/foo_bar');
      expect(pkgPageUrl('foo_bar', version: '1.0.0'),
          '/packages/foo_bar/versions/1.0.0');
    });

    test('with host', () {
      expect(pkgPageUrl('foo_bar', includeHost: true),
          'https://pub.dartlang.org/packages/foo_bar');
      expect(pkgPageUrl('foo_bar', version: '1.0.0', includeHost: true),
          'https://pub.dartlang.org/packages/foo_bar/versions/1.0.0');
    });
  });

  group('documentation page', () {
    test('without host', () {
      expect(pkgDocUrl('foo_bar'), '/documentation/foo_bar/');
      expect(pkgDocUrl('foo_bar', version: '1.0.0'),
          '/documentation/foo_bar/1.0.0/');
      expect(pkgDocUrl('foo_bar', version: '1.0.0', omitTrailingSlash: true),
          '/documentation/foo_bar/1.0.0');
    });

    test('with host', () {
      expect(pkgDocUrl('foo_bar', includeHost: true),
          'https://pub.dartlang.org/documentation/foo_bar/');
      expect(pkgDocUrl('foo_bar', version: '1.0.0', includeHost: true),
          'https://pub.dartlang.org/documentation/foo_bar/1.0.0/');
      expect(
          pkgDocUrl('foo_bar',
              version: '1.0.0', includeHost: true, omitTrailingSlash: true),
          'https://pub.dartlang.org/documentation/foo_bar/1.0.0');
    });
  });

  group('homepage syntax check', () {
    test('no url is not accepted', () {
      expect(() => syntaxCheckHomepageUrl(null), throwsException);
    });

    test('example urls that are accepted', () {
      syntaxCheckHomepageUrl('http://github.com/user/repo/');
      syntaxCheckHomepageUrl('https://github.com/user/repo/');
      syntaxCheckHomepageUrl('http://some.domain.com');
    });

    test('urls without valid scheme are not accepted', () {
      expect(() => syntaxCheckHomepageUrl('github.com/x/y'), throwsException);
      expect(() => syntaxCheckHomepageUrl('ftp://github.com/x/y'),
          throwsException);
    });

    test('urls without valid host are not accepted', () {
      expect(() => syntaxCheckHomepageUrl('http://none/x/'), throwsException);
      expect(() => syntaxCheckHomepageUrl('http://example.com/x/'),
          throwsException);
      expect(
          () => syntaxCheckHomepageUrl('http://localhost/x/'), throwsException);
      expect(() => syntaxCheckHomepageUrl('http://.../x/'), throwsException);
    });
  });

  group('SDK urls', () {
    test('dev', () {
      expect(dartSdkMainUrl('2.1.0-dev.3.1'),
          'https://api.dartlang.org/dev/2.1.0-dev.3.1/');
    });

    test('stable', () {
      expect(dartSdkMainUrl('2.0.0'), 'https://api.dartlang.org/stable/2.0.0/');
    });
  });
}
