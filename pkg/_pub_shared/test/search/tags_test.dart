// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/search/tags.dart';
import 'package:test/test.dart';

void main() {
  group('Tags', () {
    test('may be included in preview or prerelease versions', () {
      final included = [
        'runtime:native-jit',
        'sdk:dart',
        'is:null-safe',
        'platform:linux',
      ];
      final excluded = [
        'license:x',
        'is:other',
      ];

      for (final tag in included) {
        expect(isFutureVersionTag(tag), true, reason: tag);
      }

      for (final tag in excluded) {
        expect(isFutureVersionTag(tag), false, reason: tag);
      }
    });
  });
}
