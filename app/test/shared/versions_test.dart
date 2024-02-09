// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:pub_dev/shared/versions.dart';
import 'package:pub_dev/tool/utils/flutter_archive.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import 'utils.dart';

void main() {
  scopedTest('runtime pattern', () {
    expect(runtimeVersionPattern.hasMatch(runtimeVersion), isTrue);
    expect(runtimeVersionPattern.hasMatch('2018.09.13'), isTrue);
    expect(runtimeVersionPattern.hasMatch('2018 09 13'), isFalse);
    expect(runtimeVersionPattern.hasMatch('2018.09.13-dev'), isFalse);
    expect(runtimeVersionPattern.hasMatch('2018.09.13+1'), isFalse);
    expect(runtimeVersionPattern.hasMatch('2018'), isFalse);
    expect(runtimeVersionPattern.hasMatch('x.json'), isFalse);
  });

  scopedTest('do not forget to update CHANGELOG.md', () async {
    final lines = await File('../CHANGELOG.md').readAsLines();
    final nextRelease = lines
        .skipWhile((line) => !line.startsWith('##'))
        .skip(1)
        .takeWhile((line) => !line.startsWith('##'))
        .toList();
    var hasVersionChange = false;

    void check(String version, String label, {bool isRuntimeVersion = false}) {
      expect(lines.where((l) => l.contains(version) && l.contains(label)),
          isNotEmpty,
          reason: '$label should be present');
      if (!isRuntimeVersion) {
        hasVersionChange |=
            nextRelease.any((l) => l.contains(version) && l.contains(label));
      } else if (hasVersionChange) {
        expect(
            nextRelease.where((l) => l.contains(version) && l.contains(label)),
            isNotEmpty,
            reason: 'Missing runtimeVersion upgrade.');
      }
    }

    check(toolStableDartSdkVersion, 'stable Dart analysis SDK');
    check(toolPreviewDartSdkVersion, 'preview Dart analysis SDK');
    check(runtimeSdkVersion, 'runtime Dart SDK');
    check(toolStableFlutterSdkVersion, 'stable Flutter');
    check(toolPreviewFlutterSdkVersion, 'preview Flutter');
    check(panaVersion, 'pana');
    check(dartdocVersion, 'dartdoc');
    check(runtimeVersion, 'runtimeVersion', isRuntimeVersion: true);
  });

  scopedTest('accepted runtime versions should be lexicographically ordered',
      () {
    for (final version in acceptedRuntimeVersions) {
      expect(runtimeVersionPattern.hasMatch(version), isTrue);
    }
    final sorted = [...acceptedRuntimeVersions]
      ..sort((a, b) => -a.compareTo(b));
    expect(acceptedRuntimeVersions, sorted);
  });

  scopedTest('No more than 5 accepted runtimeVersions', () {
    expect(acceptedRuntimeVersions, hasLength(lessThan(6)));
  });

  test('runtime sdk version should match CI and dockerfile', () async {
    final String docker = await File('../Dockerfile.app').readAsString();
    expect(docker.contains('\nFROM dart:$runtimeSdkVersion\n'), isTrue);
    final String monoPkg = await File('mono_pkg.yaml').readAsString();
    expect(monoPkg.contains('$runtimeSdkVersion'), isTrue);
    final ci = await File('../.github/workflows/dart.yml').readAsString();
    expect(ci.contains('sdk:$runtimeSdkVersion'), isTrue);
  });

  test('Dart SDK versions should match Dockerfile.worker', () async {
    final dockerfileContent = await File('../Dockerfile.worker').readAsString();
    expect(
        dockerfileContent,
        contains(
            'RUN tool/setup-dart.sh /home/worker/dart/stable $toolStableDartSdkVersion'));
    expect(
        dockerfileContent,
        contains(
            'tool/setup-dart.sh /home/worker/dart/preview $toolPreviewDartSdkVersion'));
  });

  test('Flutter SDK versions should match Dockerfile.worker', () async {
    final dockerfileContent = await File('../Dockerfile.worker').readAsString();
    expect(
        dockerfileContent,
        contains(
            'RUN tool/setup-flutter.sh /home/worker/flutter/stable $toolStableFlutterSdkVersion'));
    expect(
        dockerfileContent,
        contains(
            'tool/setup-flutter.sh /home/worker/flutter/preview $toolPreviewFlutterSdkVersion'));
  });

  test('analyzer version should match resolved pana version', () async {
    final String lockContent = await File('pubspec.lock').readAsString();
    final lock = loadYaml(lockContent) as Map;
    expect(lock['packages']['pana']['version'], panaVersion);
  });

  test('Flutter is using a released version from any channel.', () async {
    final flutterArchive = await fetchFlutterArchive();
    expect(
        flutterArchive.releases!
            .any((fr) => fr.version == toolStableFlutterSdkVersion),
        isTrue);
    expect(
        flutterArchive.releases!
            .any((fr) => fr.version == toolPreviewFlutterSdkVersion),
        isTrue);
  });

  test(
    'Flutter is using the latest stable',
    () async {
      final flutterArchive = await fetchFlutterArchive();
      final currentStable = flutterArchive.releases!.firstWhereOrNull(
        (r) => r.hash == flutterArchive.currentRelease!.stable,
      )!;
      expect(
        toolStableFlutterSdkVersion,
        equals(currentStable.version),
        reason: '''Expected flutterVersion to be current stable
Please update flutterVersion in app/lib/shared/versions.dart
and do not format to also bump the runtimeVersion.''',
      );
    },
    tags: ['sanity'],
  );

  test('dartdoc version should match pkg/pub_worker', () async {
    final content =
        await File('../pkg/pub_worker/lib/src/bin/pana_wrapper.dart')
            .readAsString();
    expect(content, contains("dartdocVersion: '$dartdocVersion'"));
  });

  scopedTest('GC is not deleting currently accepted versions', () {
    for (final version in acceptedRuntimeVersions) {
      expect(shouldGCVersion(version), isFalse);
    }
  });

  scopedTest('gcBeforeRuntimeVersion != runtimeVersion', () {
    // gcBeforeRuntimeVersion must not be runtimeVersion
    // It is okay that acceptedRuntimeVersions only contains the current
    // runtimeVersion. This usually happens when we have breaking changes in
    // the data versioned by runtimeVersion.
    // BUT: gcBeforeRuntimeVersion MUST NOT BE EQUAL to runtimeVersion!
    // Otherwise, we will essentially have the latest version deleting the
    // runtimeVersion used by older versions. This will make it impossible to
    // roll traffic backwards.
    // Avoid this by temporarily hardcoding gcBeforeRuntimeVersion to not be
    // the last version of acceptedRuntimeVersions.
    expect(gcBeforeRuntimeVersion != runtimeVersion, isTrue);
  });

  scopedTest('GC is returning correct values for known versions', () {
    expect(shouldGCVersion('2000.01.01'), isTrue);
    expect(shouldGCVersion('3000.01.01'), isFalse);
  });
}
