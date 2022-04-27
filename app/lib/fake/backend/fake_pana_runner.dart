// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:pana/pana.dart';
import 'package:pub_semver/pub_semver.dart';

import '../../analyzer/pana_runner.dart';
import '../../scorecard/backend.dart' show PackageStatus;
import '../../shared/versions.dart';

/// Runs package analysis for all packages with fake pana runner.
Future<void> processJobsWithFakePanaRunner() async {
  // ignore: invalid_use_of_visible_for_testing_member
  await processJobsWithPanaRunner(runner: FakePanaRunner());
}

/// Generates pana analysis result based on a deterministic random seed.
class FakePanaRunner implements PanaRunner {
  @override
  Future<Summary> analyze({
    required String package,
    required String version,
    required PackageStatus packageStatus,
  }) async {
    final random = Random('$package/$version'.hashCode);
    final layoutPoints = random.nextInt(30);
    final examplePoints = random.nextInt(30);
    final hasSdkDart = random.nextInt(10) > 0;
    final hasSdkFlutter =
        random.nextInt(packageStatus.usesFlutter ? 20 : 10) > 0;
    final hasValidSdk = hasSdkDart || hasSdkFlutter;
    final runtimeTags = hasSdkDart
        ? <String>[
            if (random.nextInt(5) > 0) 'runtime:native-aot',
            if (random.nextInt(5) > 0) 'runtime:native-jit',
            if (random.nextInt(5) > 0) 'runtime:web',
          ]
        : <String>[];
    final platformTags = hasValidSdk
        ? <String>[
            if (random.nextInt(5) > 0) 'platform:android',
            if (random.nextInt(5) > 0) 'platform:ios',
            if (random.nextInt(5) > 0) 'platform:linux',
            if (random.nextInt(5) > 0) 'platform:macos',
            if (random.nextInt(5) > 0) 'platform:web',
            if (random.nextInt(5) > 0) 'platform:windows',
          ]
        : <String>[];
    final licenseSpdx = random.nextInt(5) == 0 ? 'unknown' : 'BSD-3-Clause';
    return Summary(
      packageName: package,
      packageVersion: Version.parse(version),
      runtimeInfo: PanaRuntimeInfo(
        sdkVersion: packageStatus.usesPreviewAnalysisSdk
            ? toolPreviewDartSdkVersion
            : toolStableDartSdkVersion,
        panaVersion: panaVersion,
        flutterVersions: {},
      ),
      allDependencies: <String>[],
      tags: <String>[
        if (hasSdkDart) 'sdk:dart',
        if (hasSdkFlutter) 'sdk:flutter',
        ...runtimeTags,
        ...platformTags,
        'license:${licenseSpdx.toLowerCase()}',
        if (licenseSpdx != 'unknown') 'license:fsf-libre',
        if (licenseSpdx != 'unknown') 'license:osi-approved',
      ],
      report: Report(
        sections: [
          ReportSection(
            id: ReportSectionId.convention,
            title: 'Fake conventions',
            grantedPoints: layoutPoints,
            maxPoints: 30,
            summary: renderSimpleSectionSummary(
              title: 'Package layout',
              description:
                  'Package layout score randomly set to $layoutPoints...',
              grantedPoints: layoutPoints,
              maxPoints: 30,
            ),
            status:
                layoutPoints > 20 ? ReportStatus.passed : ReportStatus.failed,
          ),
          ReportSection(
            id: ReportSectionId.documentation,
            title: 'Fake documentation',
            grantedPoints: examplePoints,
            maxPoints: 30,
            summary: renderSimpleSectionSummary(
              title: 'Example',
              description: 'Example score randomly set to $examplePoints...',
              grantedPoints: examplePoints,
              maxPoints: 30,
            ),
            status:
                examplePoints > 20 ? ReportStatus.passed : ReportStatus.partial,
          ),
        ],
      ),
      licenseFile: LicenseFile('LICENSE', 'BSD'),
      licenses: [
        License(path: 'LICENSE', spdxIdentifier: licenseSpdx),
      ],
      errorMessage: null,
      pubspec: null, // will be ignored
    );
  }
}
