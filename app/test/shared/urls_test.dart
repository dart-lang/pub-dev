// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/shared/urls.dart';
import 'package:test/test.dart';

void main() {
  group('package page', () {
    test('without host', () {
      expect(pkgPageUrl('foo_bar'), '/packages/foo_bar');
      expect(pkgPageUrl('foo_bar', version: '1.0.0'),
          '/packages/foo_bar/versions/1.0.0');
    });

    test('with host', () {
      expect(pkgPageUrl('foo_bar', includeHost: true),
          'https://pub.dev/packages/foo_bar');
      expect(pkgPageUrl('foo_bar', version: '1.0.0', includeHost: true),
          'https://pub.dev/packages/foo_bar/versions/1.0.0');
    });
  });

  group('documentation page', () {
    test('without host', () {
      expect(pkgDocUrl('foo_bar'), '/documentation/foo_bar/latest/');
      expect(pkgDocUrl('foo_bar', version: '1.0.0'),
          '/documentation/foo_bar/1.0.0/');
      expect(pkgDocUrl('foo_bar', version: '1.0.0', omitTrailingSlash: true),
          '/documentation/foo_bar/1.0.0');
    });

    test('with host', () {
      expect(pkgDocUrl('foo_bar', includeHost: true),
          'https://pub.dev/documentation/foo_bar/latest/');
      expect(pkgDocUrl('foo_bar', version: '1.0.0', includeHost: true),
          'https://pub.dev/documentation/foo_bar/1.0.0/');
      expect(
          pkgDocUrl('foo_bar',
              version: '1.0.0', includeHost: true, omitTrailingSlash: true),
          'https://pub.dev/documentation/foo_bar/1.0.0');
    });
  });

  group('SDK urls', () {
    test('dev', () {
      expect(dartSdkMainUrl('2.1.0-dev.3.1'),
          'https://api.dart.dev/dev/2.1.0-dev.3.1/');
    });

    test('stable', () {
      expect(dartSdkMainUrl('2.0.0'), 'https://api.dart.dev/stable/2.0.0/');
    });
  });

  group('search urls', () {
    test('non-identifier characters', () {
      expect(searchUrl(q: 'a b'), '/packages?q=a+b');
      expect(searchUrl(q: '<a>'), '/packages?q=%3Ca%3E');
      expect(searchUrl(q: 'ó'), '/packages?q=%C3%B3');
    });

    test('sdk:*', () {
      expect(searchUrl(), '/packages');
      expect(searchUrl(q: 'abc'), '/packages?q=abc');
    });
  });

  group('archive url', () {
    test('without base uri', () {
      expect(pkgArchiveDownloadUrl('foo', '1.0.0+1'),
          '/packages/foo/versions/1.0.0%2B1.tar.gz');
    });

    test('with base uri', () {
      expect(
        pkgArchiveDownloadUrl('foo', '1.0.0+1',
            baseUri: Uri.parse('https://pub.dev/')),
        'https://pub.dev/packages/foo/versions/1.0.0%2B1.tar.gz',
      );
    });
  });

  group('local redirect url', () {
    test('accepted', () {
      final values = [
        '/',
        '/packages/http/versions',
        '/my-packages',
        '/packages?q=sdk:dart',
      ];
      for (final v in values) {
        expect(isValidLocalRedirectUrl(v), true, reason: v);
      }
    });

    test('rejected', () {
      final values = [
        'https://pub.dev/',
        '//',
        '/../',
        '/packages#id',
      ];
      for (final v in values) {
        expect(isValidLocalRedirectUrl(v), false, reason: v);
      }
    });
  });
}
