// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/admin_api.dart';
import 'package:clock/clock.dart';
import 'package:pub_dev/admin/actions/migration_phase_list.dart';
import 'package:pub_dev/admin/actions/migration_phase_set.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/migration_phases.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:test/test.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('migration-phase admin actions', () {
    testWithProfile(
      'lists defaults and sets phases via admin API',
      fn: () async {
        final api = createPubApiClient(authToken: siteAdminToken);

        final initial = await api.adminInvokeAction(
          'migration-phase-list',
          AdminInvokeActionArguments(arguments: {}),
        );
        final initialPhases = (initial.output['phases'] as List)
            .cast<Map<String, Object?>>();
        expect(
          initialPhases.map((e) => e['entity']),
          MigrationEntity.values.map((e) => e.key),
        );
        expect(
          initialPhases,
          everyElement(
            allOf(
              containsPair('phase', 'datastore-primary'),
              containsPair('updatedAt', isNull),
            ),
          ),
        );

        final setSqlPrimary = await api.adminInvokeAction(
          'migration-phase-set',
          AdminInvokeActionArguments(
            arguments: {'entity': 'package_likes', 'phase': 'sql-primary'},
          ),
        );
        expect(setSqlPrimary.output, {
          'entity': 'package_likes',
          'before': 'datastore-primary',
          'after': 'sql-primary',
          'updatedAt': isA<String>(),
        });
        expect(await isDatastorePrimary(MigrationEntity.packageLikes), isFalse);
        expect(await isDatastorePrimary(MigrationEntity.packages), isTrue);

        final afterSet = await migrationPhaseList.invoke({});
        final afterPhases = (afterSet['phases'] as List)
            .cast<Map<String, Object?>>();
        final likesEntry = afterPhases.singleWhere(
          (e) => e['entity'] == 'package_likes',
        );
        expect(likesEntry['phase'], 'sql-primary');
        expect(likesEntry['updatedAt'], setSqlPrimary.output['updatedAt']);

        final revert = await migrationPhaseSet.invoke({
          'entity': 'package_likes',
          'phase': 'datastore-primary',
        });
        expect(revert, {
          'entity': 'package_likes',
          'before': 'sql-primary',
          'after': 'datastore-primary',
          'updatedAt': isA<String>(),
        });
        expect(await isDatastorePrimary(MigrationEntity.packageLikes), isTrue);
      },
    );

    testWithProfile(
      'validates required and known options',
      fn: () async {
        await expectLater(
          migrationPhaseSet.invoke({}),
          throwsA(isA<InvalidInputException>()),
        );
        await expectLater(
          migrationPhaseSet.invoke({
            'entity': 'unknown',
            'phase': 'sql-primary',
          }),
          throwsA(isA<InvalidInputException>()),
        );
        await expectLater(
          migrationPhaseSet.invoke({'entity': 'package_likes'}),
          throwsA(isA<InvalidInputException>()),
        );
        await expectLater(
          migrationPhaseSet.invoke({
            'entity': 'package_likes',
            'phase': 'unknown-phase',
          }),
          throwsA(isA<InvalidInputException>()),
        );
      },
    );

    testWithProfile(
      'unknown stored phase fails closed and is surfaced by list',
      fn: () async {
        final now = clock.now().toUtc();
        await primaryDatabase.withRetry((db) async {
          await db.migrationPhases
              .upsertValue(
                entity: MigrationEntity.packages.key,
                phase: 'sql-only',
                updatedAt: now,
              )
              .execute();
          await db.migrationPhases
              .upsertValue(
                entity: 'future_entity',
                phase: 'sql-primary',
                updatedAt: now,
              )
              .execute();
        });

        expect(await isDatastorePrimary(MigrationEntity.packages), isFalse);

        final list = await migrationPhaseList.invoke({});
        final phases = (list['phases'] as List).cast<Map<String, Object?>>();
        expect(
          phases.singleWhere((e) => e['entity'] == 'packages')['phase'],
          'sql-only',
        );
        expect(
          phases.singleWhere((e) => e['entity'] == 'future_entity')['phase'],
          'sql-primary',
        );

        final setResult = await migrationPhaseSet.invoke({
          'entity': 'packages',
          'phase': 'sql-primary',
        });
        expect(setResult['before'], 'sql-only');
        expect(setResult['after'], 'sql-primary');
      },
    );
  });
}
