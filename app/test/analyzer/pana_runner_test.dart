// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/analyzer/pana_runner.dart';
import 'package:pub_dev/fake/backend/fake_dartdoc_runner.dart';
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
          TestPackage(name: 'retry', versions: ['3.1.0']),
        ],
        defaultUser: 'admin@pub.dev',
      ),
      importSource: ImportSource.fromPubDev(),
      fn: () async {
        await processJobsWithPanaRunner();
        await processJobsWithFakeDartdocRunner();
        final card = await scoreCardBackend.getScoreCardData('retry', '3.1.0');

        expect(card!.grantedPubPoints, greaterThan(125));
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
            ]));
      },
      timeout: Timeout.factor(8),
    );
  });
}
