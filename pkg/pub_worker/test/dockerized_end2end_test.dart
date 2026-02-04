// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:_pub_shared/data/task_payload.dart';
import 'package:_pub_shared/worker/docker_utils.dart';
import 'package:http/http.dart' as http;
import 'package:pana/pana.dart';
import 'package:pub_worker/src/testing/server.dart';
import 'package:test/test.dart';

void main() {
  group('Dockerized end2end tests', () {
    final server = PubWorkerTestServer(
      [],
      fallbackPubHostedUrl: 'https://pub.dev',
    );
    setUpAll(() async {
      await server.start(listenOnAllInterface: true);
    });

    tearDownAll(() async {
      await server.stop();
    });

    Future<String> analyzePackage(String package, [String? version]) async {
      if (version == null) {
        final url = server.baseUrl.resolve('/api/packages/$package');
        final rs = await http.get(url);
        if (rs.statusCode != 200) {
          throw Exception('Unexpected status code on $url: ${rs.statusCode}');
        }
        final map = json.decode(rs.body) as Map;
        version = (map['latest'] as Map)['version'] as String;
      }

      final payload = Payload(
        package: package,
        pubHostedUrl: '${server.baseUrl}',
        versions: [VersionTokenPair(version: version, token: 'secret-token')],
      );

      final p = await startDockerAnalysis(payload);
      final exitCode = await p.exitCode;
      if (exitCode != 0) {
        throw Exception(
          'Failed to analyze $package $version with exitCode $exitCode',
        );
      }

      return version;
    }

    // TODO: investigate why this is not running on GitHub properly
    test(
      'build and use docker image to analyze packages',
      () async {
        await buildDockerImage();

        final packagesWithScreenshots = {'google_fonts'};
        final packages = ['retry', ...packagesWithScreenshots];
        final versions = await Future.wait(
          packages.map((p) => analyzePackage(p)),
        );

        for (var i = 0; i < packages.length; i++) {
          final package = packages[i];
          final version = versions[i];
          final result = await server.waitForResult(package, version);

          final logTxtBytes = result.lookup('log.txt');
          final logTxt = logTxtBytes == null
              ? '[no log.txt]'
              : utf8.decode(gzip.decode(logTxtBytes));

          // verify unexpected failures
          final unexpectedFragments = [
            'Failed to run',
            'certificate verification failed',
            'access denied',
          ];
          for (final fragment in unexpectedFragments) {
            if (logTxt.toLowerCase().contains(fragment.toLowerCase())) {
              fail('Log contains "$fragment":\n$logTxt');
            }
          }

          // verify log for sandboxed executions
          final expectedFragments = [
            // the exact binary location is not imporant, we must not see `dart ./bin/...`
            'PUB_WORKER_SUBPROCESS_BINARY: /home/worker/',
            'build/sandbox_runner /home/worker/dart/stable/bin/dart pub',
            'build/sandbox_runner git',
            'sandbox_runner /home/worker/dartdoc/build/dartdoc',
            if (packagesWithScreenshots.contains(package))
              'build/sandbox_runner webpinfo',
          ];
          for (final fragment in expectedFragments) {
            expect(logTxt, contains(fragment));
          }

          final docIndex = result.index.lookup('doc/index.html');
          expect(
            docIndex,
            isNotNull,
            reason: '$package must have documentation, see log:\n$logTxt',
          );

          final panaSummaryBytes = result.lookup('summary.json');
          expect(panaSummaryBytes, isNotNull);
          final summary = Summary.fromJson(
            json.decode(utf8.decode(gzip.decode(panaSummaryBytes!)))
                as Map<String, dynamic>,
          );
          final report = summary.report!;
          expect(report.maxPoints, greaterThan(100));

          // check the presence of a license
          expect(summary.tags, isNotNull);
          expect(
            summary.tags!.any(
              (tag) => tag.startsWith('license:') && tag != 'license:unknown',
            ),
            isTrue,
            reason: summary.tags.toString(),
          );

          if (packagesWithScreenshots.contains(package)) {
            expect(
              summary.screenshots ?? [],
              isNotEmpty,
              reason: '$package must have screenshots, see log:\n$logTxt',
            );
          }

          final failingReportSections = report.sections
              .where((s) => s.grantedPoints != s.maxPoints)
              .map((e) => e.summary)
              .join('\n');
          // allow points drop due to lints and other temporary issues
          var expectedDrop = 10;
          if (failingReportSections.contains(
            "Issue tracker URL doesn't exist.",
          )) {
            expectedDrop += 10;
          }
          if (failingReportSections.contains(
            "is deprecated and shouldn't be used",
          )) {
            expectedDrop += 10;
          }
          expect(
            report.grantedPoints,
            greaterThanOrEqualTo(report.maxPoints - expectedDrop),
            reason: failingReportSections,
          );
        }

        // TODO: consider docker cleanup
      },
      timeout: Timeout(Duration(minutes: 15)),
    );
  });
}
