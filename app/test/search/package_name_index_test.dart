// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/search/mem_index.dart';
import 'package:test/test.dart';

void main() {
  group('PackageNameIndex', () {
    final index = PackageNameIndex([
      'fluent',
      'fluent_ui',
      'get',
      'get_it',
      'modular',
      'modular_flutter',
    ]);

    test('fluent vs fluent_ui', () {
      expect(
        index.search('fluent'),
        {
          'fluent': 1.0,
          'fluent_ui': 1.0,
        },
      );
    });

    test('get vs get_it', () {
      expect(
        index.search('get'),
        {
          'get': 1.0,
          'get_it': 1.0,
        },
      );
    });

    test('get_it', () {
      expect(index.search('get_it'), {
        'get_it': 1.0,
      });
    });

    test('modular vs modular_flutter', () {
      expect(
        index.search('modular'),
        {
          'modular': 1.0,
          'modular_flutter': 1.0,
        },
      );
    });

    test('mixed parts: fluent it', () {
      expect(
        index.search('fluent it'),
        {},
      );
    });

    test('mixed parts: fluent flutter', () {
      expect(
        index.search('fluent flutter'),
        {},
      );
    });

    test('prefix: f', () {
      expect(
        index.search('f'),
        {
          'fluent': 1.0,
          'fluent_ui': 1.0,
          'modular_flutter': 1.0,
        },
      );
    });

    test('prefix: fl', () {
      expect(
        index.search('fl'),
        {
          'fluent': 1.0,
          'fluent_ui': 1.0,
          'modular_flutter': 1.0,
        },
      );
    });

    test('prefix: flu', () {
      expect(
        index.search('flu'),
        {
          'fluent': 1.0,
          'fluent_ui': 1.0,
          'modular_flutter': 1.0,
        },
      );
    });

    test('prefix: fluf', () {
      expect(
        index.search('fluf'),
        {'fluent': 0.5, 'fluent_ui': 0.5, 'modular_flutter': 0.5},
      );
    });

    test('prefix: fluff', () {
      expect(
        index.search('fluff'),
        {},
      );
    });

    test('prefix: fluffy', () {
      expect(
        index.search('fluffy'),
        {},
      );
    });
  });
}
