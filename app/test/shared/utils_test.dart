// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/shared/utils.dart';

void main() {
  group('package name validation', () {
    test('reject unknown mixed-case', () {
      expect(() => validatePackageName('myNewPackage'), throwsException);
    });

    test('accept only lower-case babylon (original author continues it)', () {
      expect(() => validatePackageName('Babylon'), throwsException);
      validatePackageName('babylon'); // does not throw
    });

    test('accept only upper-case Pong (no contact with author)', () {
      expect(() => validatePackageName('pong'), throwsException);
      validatePackageName('Pong'); // does not throw
    });

    test('reject unknown mixed-case', () {
      expect(() => validatePackageName('pong'), throwsException);
    });

    test('accept lower-case', () {
      validatePackageName('my_package'); // does not throw
    });
  });
}
