// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:pub_dev/shared/versions.dart';
import 'package:pub_dev/tool/utils/flutter_archive.dart';
import 'package:pubspec_parse/pubspec_parse.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  test('runtime pattern', () {
    expect(runtimeVersionPattern.hasMatch(runtimeVersion), isTrue);
    expect(runtimeVersionPattern.hasMatch('2018.09.13'), isTrue);
    expect(runtimeVersionPattern.hasMatch('2018 09 13'), isFalse);
    expect(runtimeVersionPattern.hasMatch('2018.09.13-dev'), isFalse);
    expect(runtimeVersionPattern.hasMatch('2018.09.13+1'), isFalse);
    expect(runtimeVersionPattern.hasMatch('2018'), isFalse);
    expect(runtimeVersionPattern.hasMatch('x.json'), isFalse);
  });

  test('do not forget to update CHANGELOG.md', () async {
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

  test('accepted runtime versions should be lexicographically ordered', () {
    for (final version in acceptedRuntimeVersions) {
      expect(runtimeVersionPattern.hasMatch(version), isTrue);
    }
    final sorted = [...acceptedRuntimeVersions]
      ..sort((a, b) => -a.compareTo(b));
    expect(acceptedRuntimeVersions, sorted);
  });

  test('No more than 5 accepted runtimeVersions', () {
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

  test('dartdoc version should match pkg/pub_dartdoc', () async {
    final yamlContent =
        await File('../pkg/pub_dartdoc/pubspec.yaml').readAsString();
    final pubspec = Pubspec.parse(yamlContent);
    final dependency = pubspec.dependencies['dartdoc'] as HostedDependency;
    expect(dependency.version.toString(), dartdocVersion);
  });

  test('GC is not deleting currently accepted versions', () {
    for (final version in acceptedRuntimeVersions) {
      expect(shouldGCVersion(version), isFalse);
    }
  });

  test('GC is returning correct values for known versions', () {
    expect(shouldGCVersion('2000.01.01'), isTrue);
    expect(shouldGCVersion('3000.01.01'), isFalse);
  });

  group('dartdoc serving', () {
    test('old versions are no longer serving', () {
      expect(shouldServeDartdoc(null), isFalse);
      expect(shouldServeDartdoc('2017.1.1'), isFalse);
    });

    test('current version is serving', () {
      expect(shouldServeDartdoc(runtimeVersion), isTrue);
    });

    test('next version is not serving', () {
      expect(shouldServeDartdoc('2099.12.31'), isFalse);
    });
  });
}
