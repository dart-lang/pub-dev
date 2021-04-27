// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:meta/meta.dart';
import 'package:pana/pana.dart' show ToolEnvironment;
import 'package:path/path.dart' as p;
import 'package:pub_dartdoc_data/pub_dartdoc_data.dart';

import '../../dartdoc/dartdoc_runner.dart';
import '../../job/job.dart';
import '../../shared/datastore.dart';

/// Generates package documentation for all packages with fake dartdoc runner.
Future<void> processJobsWithFakeDartdocRunner() async {
  final jobProcessor = DartdocJobProcessor(
    aliveCallback: null,
    runner: FakeDartdocRunner(),
  );
  // ignore: invalid_use_of_visible_for_testing_member
  await JobMaintenance(dbService, jobProcessor).scanUpdateAndRunOnce();
}

/// Generates dartdoc content and results based on a deterministic random seed.
class FakeDartdocRunner implements DartdocRunner {
  @override
  Future<DartdocRunnerResult> generateSdkDocs({
    @required String outputDir,
  }) async {
    final file = File(p.join(outputDir, 'pub-data.json'));
    final pubData = PubDartdocData(
      coverage: Coverage(documented: 1000, total: 1000),
      apiElements: [
        // TODO: add fake Dart SDK library elements.
      ],
    );
    await file.writeAsString(json.encode(pubData.toJson()));
    return DartdocRunnerResult(
      args: ['fake_dartdoc', '--sdk'],
      processResult: ProcessResult(0, 0, 'OK', ''),
    );
  }

  @override
  Future<void> downloadAndExtract({
    @required String package,
    @required String version,
    @required String destination,
  }) async {
    // no-op
  }

  @override
  Future<ProcessResult> runPubUpgrade({
    @required ToolEnvironment toolEnv,
    @required String pkgPath,
    @required bool usesFlutter,
  }) async {
    // no-op
    return ProcessResult(0, 0, 'OK', '');
  }

  @override
  Future<DartdocRunnerResult> generatePackageDocs({
    @required String package,
    @required String version,
    @required String pkgPath,
    @required String canonicalUrl,
    @required bool usesPreviewSdk,
    @required ToolEnvironment toolEnv,
    @required bool useLongerTimeout,
    @required String outputDir,
  }) async {
    final random = Random('$package/$version'.hashCode);

    // basic content, existence checked by the job processor
    await File(p.join(outputDir, 'index.html'))
        .writeAsString('<html><head></head><body>index.html</body></html>');
    // JS search index, existence checked by the job processor
    await File(p.join(outputDir, 'index.json')).writeAsString(json.encode({}));
    // pub search data
    final pubData = PubDartdocData(
      coverage: Coverage(documented: random.nextInt(21), total: 20),
      apiElements: [
        // TODO: add fake library elements
      ],
    );
    await File(p.join(outputDir, 'pub-data.json'))
        .writeAsString(json.encode(pubData));

    return DartdocRunnerResult(
      args: ['fake_dartdoc', '--input', pkgPath, '--output', outputDir],
      processResult: ProcessResult(0, 0, 'OK', ''),
    );
  }
}
