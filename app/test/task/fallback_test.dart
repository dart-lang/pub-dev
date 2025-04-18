// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/fake/backend/fake_pub_worker.dart';
import 'package:pub_dev/scorecard/backend.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:pub_dev/task/backend.dart';
import 'package:pub_dev/tool/test_profile/importer.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('task fallback test', () {
    test('analysis fallback', () async {
      final env = FakeAppengineEnv();
      await env.run(
        testProfile: TestProfile(
          generatedPackages: [
            GeneratedTestPackage(
              name: 'oxygen',
              versions: [
                GeneratedTestVersion(version: '1.0.0'),
              ],
            ),
          ],
          defaultUser: adminAtPubDevEmail,
        ),
        processJobsWithFakeRunners: true,
        runtimeVersions: ['2023.08.24'],
        () async {
          final card =
              await scoreCardBackend.getScoreCardData('oxygen', '1.0.0');
          expect(card.runtimeVersion, '2023.08.24');
        },
      );

      await env.run(
        runtimeVersions: ['2023.08.25', '2023.08.24'],
        () async {
          // fallback into accepted runtime works
          final card =
              await scoreCardBackend.getScoreCardData('oxygen', '1.0.0');
          expect(card.runtimeVersion, '2023.08.24');
        },
      );

      await env.run(
        runtimeVersions: ['2023.08.26', '2023.08.23'],
        () async {
          // fallback into non-accepted runtime doesn't work
          final card =
              await scoreCardBackend.getScoreCardData('oxygen', '1.0.0');
          expect(card.runtimeVersion, '2023.08.26');
        },
      );
    });
  });

  group('latest analyzed version', () {
    testWithProfile('no analysis yet', fn: () async {
      expect(await taskBackend.latestFinishedVersion('oxygen'), isNull);
      expect(await taskBackend.latestFinishedVersion('neon'), isNull);
    });

    testWithProfile(
      'with current analysis',
      fn: () async {
        expect(await taskBackend.latestFinishedVersion('oxygen'), '1.2.0');
        expect(await taskBackend.latestFinishedVersion('neon'), '1.0.0');
      },
      processJobsWithFakeRunners: true,
    );

    testWithProfile(
      'runtime version fallback',
      fn: () async {
        final currentRVs = acceptedRuntimeVersions;
        await withRuntimeVersions(
          ['2099.12.31', ...currentRVs],
          () async {
            expect(await taskBackend.latestFinishedVersion('oxygen'), '1.2.0');
            expect(await taskBackend.latestFinishedVersion('neon'), '1.0.0');
          },
        );
      },
      processJobsWithFakeRunners: true,
    );

    testWithProfile(
      'new version',
      fn: () async {
        expect(await taskBackend.latestFinishedVersion('oxygen'), '1.2.0');
        await importProfile(
          profile: TestProfile(
            generatedPackages: [
              GeneratedTestPackage(name: 'oxygen', versions: [
                GeneratedTestVersion(version: '9.0.0'),
              ]),
            ],
            defaultUser: adminAtPubDevEmail,
          ),
        );
        expect(await taskBackend.latestFinishedVersion('oxygen'), '1.2.0');
        await processTasksWithFakePanaAndDartdoc();
        expect(await taskBackend.latestFinishedVersion('oxygen'), '9.0.0');
      },
      processJobsWithFakeRunners: true,
    );
  });
}
