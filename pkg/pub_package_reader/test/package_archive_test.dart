// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_package_reader/pub_package_reader.dart';

void main() {
  group('package name validation', () {
    test('reject unknown mixed-case', () {
      expect(validatePackageName('myNewPackage'), isNotEmpty);
    });

    test('accept only lower-case babylon (original author continues it)', () {
      expect(validatePackageName('Babylon'), isNotEmpty);
      expect(validatePackageName('babylon'), isEmpty);
    });

    test('accept only upper-case Pong (no contact with author)', () {
      expect(validatePackageName('pong'), isNotEmpty);
      expect(validatePackageName('Pong'), isEmpty);
    });

    test('reject unknown mixed-case', () {
      expect(validatePackageName('pong'), isNotEmpty);
    });

    test('accept lower-case', () {
      expect(validatePackageName('my_package'), isEmpty);
    });

    test('reject reserved words', () {
      expect(validatePackageName('do'), isNotEmpty);
      expect(validatePackageName('d_o'), isNotEmpty);
    });
  });

  group('homepage syntax check', () {
    test('no url is not accepted', () {
      expect(syntaxCheckHomepageUrl(null), isNotEmpty);
    });

    test('example urls that are accepted', () {
      expect(syntaxCheckHomepageUrl('http://github.com/user/repo/'), isEmpty);
      expect(syntaxCheckHomepageUrl('https://github.com/user/repo/'), isEmpty);
      expect(syntaxCheckHomepageUrl('http://some.domain.com'), isEmpty);
    });

    test('urls without valid scheme are not accepted', () {
      expect(syntaxCheckHomepageUrl('github.com/x/y'), isNotEmpty);
      expect(syntaxCheckHomepageUrl('httpx://github.com/x/y'), isNotEmpty);
      expect(syntaxCheckHomepageUrl('ftp://github.com/x/y'), isNotEmpty);
    });

    test('urls without valid host are not accepted', () {
      expect(syntaxCheckHomepageUrl('http://none/x/'), isNotEmpty);
      expect(syntaxCheckHomepageUrl('http://example.com/x/'), isNotEmpty);
      expect(syntaxCheckHomepageUrl('http://localhost/x/'), isNotEmpty);
      expect(syntaxCheckHomepageUrl('http://.../x/'), isNotEmpty);
    });
  });
}
