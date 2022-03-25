// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/search/mem_index.dart';
import 'package:test/test.dart';

void main() {
  group('PackageNameIndex', () {
    final index = PackageNameIndex()
      ..addAll([
        'fluent',
        'fluent_ui',
        'get',
        'get_it',
        'modular',
        'modular_flutter',
      ]);

    test('fluent vs fluent_ui', () {
      expect(
        index.search('fluent').getValues(),
        {
          'fluent': 1.0,
          'fluent_ui': closeTo(0.85, 0.01),
        },
      );
    });

    test('get vs get_it', () {
      expect(
        index.search('get').getValues(),
        {
          'get': 1.0,
          'get_it': closeTo(0.75, 0.01),
        },
      );
    });

    test('modular vs modular_flutter', () {
      expect(
        index.search('modular').getValues(),
        {
          'modular': 1.0,
          'modular_flutter': closeTo(0.67, 0.01),
        },
      );
    });

    test('mixed parts: fluent it', () {
      expect(
        index.search('fluent it').getValues(),
        {
          'fluent': closeTo(0.92, 0.01),
          'fluent_ui': closeTo(0.80, 0.01),
        },
      );
    });

    test('mixed parts: fluent flutter', () {
      expect(
        index.search('fluent flutter').getValues(),
        {
          'fluent': closeTo(0.76, 0.01),
          'fluent_ui': closeTo(0.68, 0.01),
          'modular_flutter': closeTo(0.60, 0.01),
        },
      );
    });

    test('prefix: f', () {
      expect(
        index.search('f').getValues(),
        {},
      );
    });

    test('prefix: fl', () {
      expect(
        index.search('fl').getValues(),
        {
          'fluent': 0.5,
        },
      );
    });

    test('prefix: flu', () {
      expect(
        index.search('flu').getValues(),
        {
          'fluent': closeTo(0.67, 0.01),
          'fluent_ui': closeTo(0.55, 0.01),
        },
      );
    });

    test('prefix: fluf', () {
      expect(
        index.search('fluf').getValues(),
        {
          'fluent': closeTo(0.50, 0.01),
        },
      );
    });

    test('prefix: fluff', () {
      expect(
        index.search('fluff').getValues(),
        {},
      );
    });

    test('prefix: fluffy', () {
      expect(
        index.search('fluffy').getValues(),
        {},
      );
    });
  });
}
