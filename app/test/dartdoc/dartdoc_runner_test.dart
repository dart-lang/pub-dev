// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/dartdoc/backend.dart';
import 'package:pub_dev/dartdoc/dartdoc_runner.dart';
import 'package:pub_dev/fake/backend/fake_pana_runner.dart';
import 'package:pub_dev/scorecard/backend.dart';
import 'package:pub_dev/tool/test_profile/import_source.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import '../frontend/handlers/_utils.dart';
import '../shared/test_services.dart';

void main() {
  group('dartdoc runner', () {
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
        await processJobsWithFakePanaRunner();
        await processJobsWithDartdocRunner();
        final card = await scoreCardBackend.getScoreCardData(
          'retry',
          '3.1.0',
          skipSandboxOutput: true,
        );

        expect(card!.grantedPubPoints, greaterThan(25));
        expect(card.maxPubPoints, greaterThan(60));
        expect(card.dartdocReport!.documentationSection!.grantedPoints, 10);
        expect(card.dartdocReport!.documentationSection!.maxPoints, 10);

        // size checks
        final entry = card.dartdocReport!.dartdocEntry!;
        expect(entry.archiveSize, greaterThan(145000));
        expect(entry.archiveSize, lessThan(155000));
        expect(entry.totalSize, greaterThan(535000));
        expect(entry.totalSize, lessThan(555000));
        expect(entry.hasBlob, isTrue);
        expect(entry.blobSize, greaterThan(160000));
        expect(entry.blobSize, lessThan(180000));
        expect(entry.blobIndexSize, greaterThan(750));
        expect(entry.blobIndexSize, lessThan(1000));

        // uploaded content check
        final indexHtml = await dartdocBackend.getTextContent(
          'retry',
          '3.1.0',
          'index.html',
          timeout: Duration(seconds: 1),
        );
        expect(indexHtml, contains('retry/retry-library.html'));
        final libraryHtml = await dartdocBackend.getTextContent(
          'retry',
          '3.1.0',
          'retry/retry-library.html',
          timeout: Duration(seconds: 1),
        );
        expect(libraryHtml, contains('retry/RetryOptions-class.html'));
        expect(indexHtml == libraryHtml, isFalse);

        final rs = await issueGet(
            '/documentation/retry/latest/retry/retry-library.html',
            headers: {
              'Cookie': 'PUB_EXPERIMENTAL_INSECURE=nosandbox',
            });
        expect(rs.statusCode, 200);
        expect(await rs.readAsString(), libraryHtml);

        final rs2 =
            await issueGet('/documentation/retry/latest/log.txt', headers: {
          'Cookie': 'PUB_EXPERIMENTAL_INSECURE=nosandbox',
        });
        expect(rs2.statusCode, 200);
        expect(await rs2.readAsString(), contains('entry created:'));

        final rs3 = await issueGet('/documentation/retry/latest/package.tar.gz',
            headers: {
              'Cookie': 'PUB_EXPERIMENTAL_INSECURE=nosandbox',
            });
        expect(rs3.statusCode, 200);
        final body3 = await rs3.read().toList();
        final body3Length = body3.map((e) => e.length).reduce((a, b) => a + b);
        expect(body3Length, entry.archiveSize);
      },
      timeout: Timeout.factor(8),
    );
  });
}
