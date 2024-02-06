// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/account/agent.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:test/test.dart';

void main() {
  group('userId', () {
    test('valid UUID', () {
      expect(looksLikeUserId(createUuid()), isTrue);
    });

    test('invalid UUID', () {
      expect(looksLikeUserId(createUuid().replaceAll('-', '')), isFalse);
      expect(looksLikeUserId(createUuid().replaceAll('-', '.')), isFalse);
    });
  });

  group('service agents', () {
    test('valid agent', () {
      expect(looksLikeServiceAgent('service:github-actions'), isTrue);
    });

    test('invalid agent', () {
      expect(looksLikeServiceAgent('service:x'), isFalse);
      expect(looksLikeServiceAgent('x'), isFalse);
      expect(looksLikeServiceAgent(createUuid()), isFalse);
    });
  });

  group('agents', () {
    test('valid agents', () {
      expect(looksLikeUserIdOrServiceAgent(createUuid()), isTrue);
      expect(looksLikeUserIdOrServiceAgent('service:github-actions'), isTrue);
    });

    test('invalid agents', () {
      expect(looksLikeUserIdOrServiceAgent(createUuid().replaceAll('-', '')),
          isFalse);
      expect(looksLikeUserIdOrServiceAgent('service:x'), isFalse);
      expect(looksLikeUserIdOrServiceAgent('x'), isFalse);
    });
  });
}
