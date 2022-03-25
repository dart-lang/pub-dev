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
          'fluent_ui': 0.75,
        },
      );
    });

    test('get vs get_it', () {
      expect(
        index.search('get').getValues(),
        {
          'get': 1.0,
          'get_it': 0.6,
        },
      );
    });

    test('modular vs modular_flutter', () {
      expect(
        index.search('modular').getValues(),
        {
          'modular': 1.0,
          'modular_flutter': 0.5,
        },
      );
    });

    test('mixed parts: fluent it', () {
      expect(
        index.search('fluent it').getValues(),
        {},
      );
    });

    test('mixed parts: fluent flutter', () {
      expect(
        index.search('fluent flutter').getValues(),
        {},
      );
    });

    test('prefix: f', () {
      expect(
        index.search('f').getValues(),
        {
          'fluent': closeTo(0.17, 0.01),
          'fluent_ui': 0.125,
          'modular_flutter': closeTo(0.07, 0.01),
        },
      );
    });

    test('prefix: fl', () {
      expect(
        index.search('fl').getValues(),
        {
          'fluent': closeTo(0.33, 0.01),
          'fluent_ui': 0.25,
          'modular_flutter': closeTo(0.14, 0.01),
        },
      );
    });

    test('prefix: flu', () {
      expect(
        index.search('flu').getValues(),
        {
          'fluent': 0.5,
          'fluent_ui': 0.375,
          'modular_flutter': closeTo(0.21, 0.01),
        },
      );
    });

    test('prefix: fluf', () {
      expect(
        index.search('fluf').getValues(),
        {},
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
