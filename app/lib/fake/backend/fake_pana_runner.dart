// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:crypto/crypto.dart';
import 'package:pana/pana.dart';
import 'package:pub_semver/pub_semver.dart';

import '../../package/backend.dart';
import '../../scorecard/backend.dart' show PackageStatus;
import '../../shared/versions.dart';

Future<Summary> fakePanaSummary({
  required String package,
  required String version,
  required PackageStatus packageStatus,
  required double documentedRatio,
}) async {
  final pv = await packageBackend.lookupPackageVersion(package, version);
  final pubspec = pv!.pubspec!;
  final hasher = createHasher([package, version].join('/'));
  final layoutPoints = hasher('points/layout', max: 30);
  final examplePoints =
      hasher('points/example', max: 30) + (documentedRatio >= 0.2 ? 10 : 0);
  final hasSdkDart = hasher('sdk:dart', max: 10) > 0;
  final hasSdkFlutter =
      hasher('sdk:flutter', max: packageStatus.usesFlutter ? 20 : 10) > 0;
  final hasValidSdk = hasSdkDart || hasSdkFlutter;
  final runtimeTags = hasSdkDart
      ? <String>[
          'runtime:native-aot',
          'runtime:native-jit',
          'runtime:web',
        ].where((p) => hasher(p, max: 5) > 0).toList()
      : <String>[];
  final platformTags = hasValidSdk
      ? <String>[
          'platform:android',
          'platform:ios',
          'platform:linux',
          'platform:macos',
          'platform:web',
          'platform:windows',
        ].where((p) => hasher(p, max: 5) > 0).toList()
      : <String>[];
  final licenseSpdx =
      hasher('license', max: 5) == 0 ? 'unknown' : 'BSD-3-Clause';

  String? fakeUrlCheck(String key, String? url) {
    return hasher(key, max: 20) > 0 ? url : null;
  }

  final homepageUrl = fakeUrlCheck('pubspec.homepage', pubspec.homepage);
  final repositoryUrl = fakeUrlCheck('pubspec.repository', pubspec.repository);
  final issueTrackerUrl =
      fakeUrlCheck('pubspec.issueTracker', pubspec.issueTracker);
  final documentationUrl =
      fakeUrlCheck('pubspec.documentation', pubspec.documentation);
  final verifiedUrl =
      Repository.tryParseUrl(repositoryUrl ?? homepageUrl ?? '');
  final hasVerifiedRepository =
      verifiedUrl != null && hasher('verifiedRepository', max: 20) > 0;
  Repository? repository;
  if (hasVerifiedRepository) {
    final verifiedRepositoryBranch = verifiedUrl.branch ??
        (hasher('verifiedRepository.branch', max: 5) > 0 ? 'main' : null);
    repository = Repository(
      provider: verifiedUrl.provider,
      host: verifiedUrl.host,
      repository: verifiedUrl.repository,
      branch: verifiedRepositoryBranch,
      path: verifiedUrl.path,
    );
  }

  final contributingUrl = fakeUrlCheck(
      'contributingUrl', repository?.tryResolveUrl('CONTRIBUTING.md'));

  final result = AnalysisResult(
    homepageUrl: homepageUrl,
    repositoryUrl: repositoryUrl,
    issueTrackerUrl: issueTrackerUrl,
    documentationUrl: documentationUrl,
    repository: repository,
    // TODO: add funding URLs
    fundingUrls: null,
    contributingUrl: contributingUrl,
  );
  return Summary(
    createdAt: clock.now().toUtc(),
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
          status: layoutPoints > 20 ? ReportStatus.passed : ReportStatus.failed,
        ),
        ReportSection(
          id: ReportSectionId.documentation,
          title: 'Fake documentation',
          grantedPoints: examplePoints,
          maxPoints: 40,
          summary: renderSimpleSectionSummary(
            title: 'Example',
            description: 'Example score randomly set to $examplePoints...',
            grantedPoints: examplePoints,
            maxPoints: 40,
          ),
          status:
              examplePoints > 20 ? ReportStatus.passed : ReportStatus.partial,
        ),
      ],
    ),
    result: result,
    licenseFile: LicenseFile('LICENSE', licenseSpdx),
    licenses: [
      License(path: 'LICENSE', spdxIdentifier: licenseSpdx),
    ],
    errorMessage: null,
    pubspec: null, // will be ignored
  );
}

/// Returns the hash of the [key]. When [max] is present, only
/// ints between 0 and max (exclusive) will be returned.
///
/// Throws [StateError] if it is called more than once with teh same [key].
typedef Hasher = int Function(String key, {int? max});

/// Creates a [Hasher] using the provided [seed].
Hasher createHasher(String seed) {
  final _keys = <String>{};
  return (key, {int? max}) {
    if (!_keys.add(key)) {
      throw StateError('Key "$key" already used.');
    }
    final content = [seed, key].join('/');
    final contentHash = sha256.convert(utf8.encode(content));
    final bytes = contentHash.bytes;
    final hash = (bytes[0] << 16) + (bytes[1] << 8) + bytes[2];
    return max == null ? hash : (hash % max);
  };
}
