// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/shared/cookie_utils.dart';
import 'package:test/test.dart';

void main() {
  group('parseCookieHeader', () {
    test('no value', () {
      expect(parseCookieHeader(null), {});
      expect(parseCookieHeader(' '), {});
    });

    test('single value', () {
      expect(parseCookieHeader('a=b'), {'a': 'b'});
    });

    test('two values', () {
      expect(parseCookieHeader('a=b; c=dd'), {'a': 'b', 'c': 'dd'});
    });
  });
}
