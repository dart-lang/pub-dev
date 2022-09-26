// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:pana/pana.dart';
import 'package:pub_dev/analyzer/pana_runner.dart';
import 'package:pub_dev/fake/backend/fake_dartdoc_runner.dart';
import 'package:pub_dev/package/screenshots/backend.dart';
import 'package:pub_dev/scorecard/backend.dart';
import 'package:pub_dev/tool/test_profile/import_source.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import '../shared/test_services.dart';

void main() {
  test('static analysis options is available', () async {
    final content = await getDefaultAnalysisOptionsYaml();
    expect(content.trim(), isNotEmpty);
    expect(content, contains('void_checks'));
  });

  group('pana runner', () {
    testWithProfile(
      'end2end test',
      testProfile: TestProfile(
        packages: [
          TestPackage(name: 'retry', versions: [TestVersion(version: '3.1.0')]),
        ],
        defaultUser: 'admin@pub.dev',
      ),
      importSource: ImportSource.fromPubDev(),
      fn: () async {
        await processJobsWithPanaRunner();
        await processJobsWithFakeDartdocRunner();
        final card = await scoreCardBackend.getScoreCardData('retry', '3.1.0');

        expect(card!.grantedPubPoints, greaterThan(120));
        expect(card.maxPubPoints, card.grantedPubPoints);
        expect(
            card.derivedTags?.toSet(),
            containsAll([
              'sdk:dart',
              'sdk:flutter',
              'platform:android',
              'platform:ios',
              'platform:windows',
              'platform:linux',
              'platform:macos',
              'platform:web',
              'runtime:native-aot',
              'runtime:native-jit',
              'runtime:web',
              'is:null-safe',
              'license:osi-approved',
            ]));
      },
      timeout: Timeout.factor(8),
    );

    testWithProfile(
      'screenshot test',
      testProfile: TestProfile(
        packages: [
          TestPackage(
              name: '_dummy_pkg', versions: [TestVersion(version: '0.0.193')]),
        ],
        defaultUser: 'admin@pub.dev',
      ),
      fn: () async {
        bool tryWebpTool() {
          try {
            Process.runSync('cwebp', []);
            Process.runSync('dwebp', []);
            Process.runSync('webpinfo', []);
            Process.runSync('gif2webp', []);
            Process.runSync('webpmux', []);
          } on ProcessException catch (_) {
            return false;
          }
          return true;
        }

        final package = '_dummy_pkg';
        final packageVersion = '0.0.193';

        await processJobsWithPanaRunner();
        await processJobsWithFakeDartdocRunner();

        final card =
            await scoreCardBackend.getScoreCardData(package, packageVersion);

        if (!tryWebpTool()) {
          expect(card!.panaReport!.screenshots, isEmpty);
          final docSection = card.panaReport!.report!.sections
              .firstWhere((s) => s.id == ReportSectionId.documentation);
          expect(docSection.grantedPoints, 0);
          return;
        }

        expect(card!.panaReport!.screenshots!.length, 1);
        final processedScreenshot = card.panaReport!.screenshots!.first;

        expect(
            (await imageStorage.bucket
                    .read([
              package,
              packageVersion,
              processedScreenshot.webpImage
            ].join('/'))
                    .fold<List<int>>(
                        <int>[], (buffer, data) => buffer..addAll(data)))
                .length,
            3352);
        expect(
            (await imageStorage.bucket
                    .read([
              package,
              packageVersion,
              processedScreenshot.webp100Thumbnail
            ].join('/'))
                    .fold<List<int>>(
                        <int>[], (buffer, data) => buffer..addAll(data)))
                .length,
            greaterThan(570)); // There is a slight variation in size depending
        // on where this test is run.
        expect(
            (await imageStorage.bucket
                    .read([
              package,
              packageVersion,
              processedScreenshot.png100Thumbnail
            ].join('/'))
                    .fold<List<int>>(
                        <int>[], (buffer, data) => buffer..addAll(data)))
                .length,
            2663);
      },
      timeout: Timeout.factor(8),
    );
  });
}
