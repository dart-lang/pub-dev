// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert' show json;
import 'dart:io' show Directory, File, Platform, exit;

import 'package:logging/logging.dart' show Logger, Level, LogRecord;
import 'package:pana/pana.dart';
import 'package:path/path.dart' as p;
import 'package:pub_dartdoc_data/pub_dartdoc_data.dart';
import 'package:pub_worker/src/fetch_pubspec.dart';
import 'package:pub_worker/src/sdks.dart';

final _log = Logger('pana');

/// Program to be used as subprocess for running pana, ensuring that we capture
/// all the output, and only run analysis in a subprocess that can timeout and
/// be killed.
Future<void> main(List<String> args) async {
  if (args.length != 3) {
    print('Usage: pana_wrapper.dart <output-folder> <package> <version>');
    exit(1);
  }

  final outputFolder = args[0];
  final package = args[1];
  final version = args[2];
  final pubHostedUrl =
      Platform.environment['PUB_HOSTED_URL'] ?? 'https://pub.dartlang.org';
  final pubCache = Platform.environment['PUB_CACHE']!;

  // Setup logging
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
    if (rec.error != null) {
      print('ERROR: ${rec.error}, ${rec.stackTrace}');
    }
  });

  // Fetch the pubspec so we detect which SDK to use for analysis
  // TODO: Download the package, extract and load the pubspec.yaml, that way
  //       we won't have to list versions again later.
  final pubspec = await fetchPubspec(
    package: package,
    version: version,
    pubHostedUrl: pubHostedUrl,
  );

  // Discover installed Dart and Flutter SDKs.
  // This reads sibling folders to the Dart and Flutter SDK.
  // TODO: Install Dart / Flutter SDKs into these folders ondemand in the future!
  final dartSdks = await InstalledSdk.fromDirectory(
    kind: 'dart',
    path: Directory(
      Platform.environment['DART_SDK'] ??
          Directory(Platform.resolvedExecutable).parent.parent.path,
    ).parent,
  );
  final flutterSdks = await InstalledSdk.fromDirectory(
    kind: 'flutter',
    path: Directory(Platform.environment['FLUTTER_ROOT'] ?? '').parent,
  );

  // Choose Dart and Flutter SDKs for analysis
  final dartSdk = InstalledSdk.prioritizedSdk(
    dartSdks,
    pubspec.dartSdkConstraint,
  );
  final flutterSdk = InstalledSdk.prioritizedSdk(
    flutterSdks,
    pubspec.flutterSdkConstraint,
  );

  final toolEnv = await ToolEnvironment.create(
    dartSdkDir: dartSdk?.path,
    flutterSdkDir: flutterSdk?.path,
    pubCacheDir: pubCache,
    environment: {'CI': 'true'},
    useGlobalDartdoc: false,
  );

  //final dartdocOutputDir =
  //    await Directory(p.join(outputFolder, 'doc')).create();
  final resourcesOutputDir =
      await Directory(p.join(outputFolder, 'resources')).create();
  final pana = PackageAnalyzer(toolEnv);
  // TODO: add a cache purge + retry if the download would fail
  //       (e.g. the package version cache wasn't invalidated).
  final summary = await pana.inspectPackage(
    package,
    version: version,
    options: InspectOptions(
      //TODO: Add analysisOptionsYaml, or move the logic into pana
      pubHostedUrl: Platform.environment['PUB_HOSTED_URL']!,
      //TODO: Run dartdoc as part of pana
      checkRemoteRepository: true,
    ),
    logger: _log,
    storeResource: (filename, data) async {
      final file = File(p.join(resourcesOutputDir.path, filename));
      await file.parent.create(recursive: true);
      await file.writeAsBytes(data);
    },
  );

  // Load doc/pub-data.json created by dartdoc
  ReportSection docSection;
  try {
    final docData = PubDartdocData.fromJson(json.decode(
      await File(p.join(outputFolder, 'doc', 'pub-data.json')).readAsString(),
    ) as Map<String, dynamic>);
    docSection = documentationCoverageSection(
      documented: docData.coverage?.documented ?? 0,
      total: docData.coverage?.total ?? 0,
    );
  } catch (e) {
    // ignore the error
    // TODO: handle errors more gracefully, or just run dartdoc as part of pana.
    // TODO: make a proper link to the task-log, which isn't exposed yet.
    docSection = dartdocFailedSection('`dartdoc` failed, see task-log.');
  }

  final updatedReport = summary.report?.joinSection(docSection);
  final updatedSummary = summary.change(report: updatedReport);

  _log.info('Writing summary.json');
  await File(
    p.join(outputFolder, 'summary.json'),
  ).writeAsString(json.encode(updatedSummary));
}
