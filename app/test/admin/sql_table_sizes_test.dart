// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/actions/sql_table_sizes.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:test/test.dart';

import '../shared/test_services.dart';

void main() {
  group('sql-table-sizes', () {
    testWithProfile(
      'single table',
      fn: () async {
        final result = await sqlTableSizes.invoke({'table': 'packages'});
        expect(result['table'], 'packages');
        final sizes = result['sizes'] as Map;
        expect(sizes.keys, ['packages']);
        expect(sizes['packages'], greaterThan(0));
      },
    );

    testWithProfile(
      'prefix with trailing star',
      fn: () async {
        final result = await sqlTableSizes.invoke({
          'table': 'package_version*',
        });
        expect((result['sizes'] as Map).keys, [
          'package_version_assets',
          'package_versions',
        ]);
      },
    );

    testWithProfile(
      'all tables',
      fn: () async {
        final result = await sqlTableSizes.invoke({'table': '*'});
        final sizes = result['sizes'] as Map;
        expect(sizes.length, greaterThan(10));
        expect(sizes['users'], greaterThan(0));
        expect(sizes.values, everyElement(isA<int>()));
      },
    );

    testWithProfile(
      'missing table option',
      fn: () async {
        await expectLater(
          sqlTableSizes.invoke({}),
          throwsA(isA<InvalidInputException>()),
        );
      },
    );

    testWithProfile(
      'unknown table',
      fn: () async {
        await expectLater(
          sqlTableSizes.invoke({'table': 'none'}),
          throwsA(isA<NotFoundException>()),
        );
        await expectLater(
          sqlTableSizes.invoke({'table': 'none*'}),
          throwsA(isA<NotFoundException>()),
        );
      },
    );
  });
}
