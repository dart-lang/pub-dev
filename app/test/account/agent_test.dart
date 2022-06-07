// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/account/agent.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:test/test.dart';

void main() {
  group('userId', () {
    test('valid UUID', () {
      expect(isValidUserId(createUuid()), isTrue);
    });

    test('invalid UUID', () {
      expect(isValidUserId(createUuid().replaceAll('-', '')), isFalse);
      expect(isValidUserId(createUuid().replaceAll('-', '.')), isFalse);
    });
  });

  group('service agents', () {
    test('valid agent', () {
      expect(isKnownServiceAgent('service:github-actions'), isTrue);
    });

    test('invalid agent', () {
      expect(isKnownServiceAgent('service:x'), isFalse);
      expect(isKnownServiceAgent('x'), isFalse);
      expect(isKnownServiceAgent(createUuid()), isFalse);
    });
  });

  group('agents', () {
    test('valid agents', () {
      expect(isValidUserIdOrServiceAgent(createUuid()), isTrue);
      expect(isValidUserIdOrServiceAgent('service:github-actions'), isTrue);
    });

    test('invalid agents', () {
      expect(isValidUserIdOrServiceAgent(createUuid().replaceAll('-', '')),
          isFalse);
      expect(isValidUserIdOrServiceAgent('service:x'), isFalse);
      expect(isValidUserIdOrServiceAgent('x'), isFalse);
    });
  });
}
