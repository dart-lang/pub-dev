// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:pana/pana.dart' show ToolEnvironment;
import 'package:path/path.dart' as p;
import 'package:pub_dartdoc_data/pub_dartdoc_data.dart';

import '../../dartdoc/dartdoc_runner.dart';

/// Generates package documentation for all packages with fake dartdoc runner.
Future<void> processJobsWithFakeDartdocRunner() async {
  // ignore: invalid_use_of_visible_for_testing_member
  await processJobsWithDartdocRunner(runner: FakeDartdocRunner());
}

/// Generates dartdoc content and results based on a deterministic random seed.
class FakeDartdocRunner implements DartdocRunner {
  @override
  Future<void> downloadAndExtract({
    required String package,
    required String version,
    required String destination,
  }) async {
    // no-op
  }

  @override
  Future<PanaProcessResult> runPubUpgrade({
    required ToolEnvironment toolEnv,
    required String package,
    required String version,
    required String pkgPath,
    required bool usesFlutter,
  }) async {
    // no-op
    return PanaProcessResult(0, 0, 'OK', '');
  }

  @override
  Future<DartdocRunnerResult> generatePackageDocs({
    required String package,
    required String version,
    required String pkgPath,
    required String canonicalUrl,
    required bool usesPreviewSdk,
    required ToolEnvironment toolEnv,
    required bool useLongerTimeout,
    required String outputDir,
  }) async {
    final files = fakeDartdocFiles(package, version);
    for (final e in files.entries) {
      await File(p.join(outputDir, e.key)).writeAsString(e.value);
    }

    return DartdocRunnerResult(
      args: ['fake_dartdoc', '--input', pkgPath, '--output', outputDir],
      processResult: PanaProcessResult(0, 0, 'OK', ''),
    );
  }
}

Map<String, String> fakeDartdocFiles(String package, version) {
  final random = Random('$package/$version'.hashCode);
  final pubData = PubDartdocData(
    coverage: Coverage(documented: random.nextInt(21), total: 20),
    apiElements: [
      // TODO: add fake library elements
    ],
  );
  return {
    'index.html': '<html><head></head><body>index.html</body></html>',
    'index.json': '{}',
    'pub-data.json': json.encode(pubData),
  };
}
