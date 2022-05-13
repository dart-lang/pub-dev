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

  group('robot agents', () {
    test('valid agent', () {
      expect(isValidRobotAgent('robot:github-actions'), isTrue);
    });

    test('invalid agent', () {
      expect(isValidRobotAgent('robot:x'), isFalse);
      expect(isValidRobotAgent('x'), isFalse);
      expect(isValidRobotAgent(createUuid()), isFalse);
    });
  });

  group('agents', () {
    test('valid agents', () {
      expect(isValidUserIdOrRobotAgent(createUuid()), isTrue);
      expect(isValidUserIdOrRobotAgent('robot:github-actions'), isTrue);
    });

    test('invalid agents', () {
      expect(
          isValidUserIdOrRobotAgent(createUuid().replaceAll('-', '')), isFalse);
      expect(isValidUserIdOrRobotAgent('robot:x'), isFalse);
      expect(isValidUserIdOrRobotAgent('x'), isFalse);
    });
  });
}
