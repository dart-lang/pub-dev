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
    });

    test('with host', () {
      expect(pkgDocUrl('foo_bar', includeHost: true),
          'https://pub.dartlang.org/documentation/foo_bar/');
      expect(pkgDocUrl('foo_bar', version: '1.0.0', includeHost: true),
          'https://pub.dartlang.org/documentation/foo_bar/1.0.0/');
    });
  });
}
