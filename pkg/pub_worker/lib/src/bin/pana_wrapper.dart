// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert' show json, utf8;
import 'dart:io' show Directory, File, Platform, exit, gzip;

import 'package:logging/logging.dart' show Logger, Level, LogRecord;
import 'package:pana/pana.dart';
import 'package:path/path.dart' as p;
import 'package:pub_worker/src/bin/dartdoc_wrapper.dart';
import 'package:pub_worker/src/fetch_pubspec.dart';
import 'package:pub_worker/src/sdks.dart';

final _log = Logger('pana');

/// The maximum of the compressed pana report. Larger reports will be dropped and
/// replaced with a placeholder report.
final _reportSizeDropThreshold = 32 * 1024;

/// Stop dartdoc if it takes more than 45 minutes.
const _dartdocTimeout = Duration(minutes: 45);

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
  final rawDartdocOutputFolder =
      await Directory.systemTemp.createTemp('dartdoc-$package');

  // Setup logging
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((LogRecord rec) {
    final prefix = '${rec.time} ${rec.level.name}:';
    final printLinesWithPrefix = (String lines) {
      for (final line in lines.split('\n')) {
        print('$prefix $line');
      }
    };

    printLinesWithPrefix(rec.message);
    final e = rec.error;
    if (e != null) {
      printLinesWithPrefix(e.toString());
      final st = rec.stackTrace;
      if (st != null) {
        printLinesWithPrefix(st.toString());
      }
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

  // NOTE: This is a temporary workaround to use a different config directory for preview SDKs.
  // TODO(https://github.com/dart-lang/pub-dev/issues/7270): Use per-SDK config directory.
  final isPreviewSdk = flutterSdk?.version.isPreRelease ??
      dartSdk?.version.isPreRelease ??
      false;
  final workerPreviewConfigDir = Directory('/home/worker/config/preview');
  String? configDir;
  if (isPreviewSdk && await workerPreviewConfigDir.exists()) {
    configDir = workerPreviewConfigDir.path;
  }

  final toolEnv = await ToolEnvironment.create(
    dartSdkDir: dartSdk?.path,
    flutterSdkDir: flutterSdk?.path,
    pubCacheDir: pubCache,
    panaCacheDir: Platform.environment['PANA_CACHE'],
    environment: {
      'CI': 'true',
      if (configDir != null) 'XDG_CONFIG_HOME': configDir,
    },
    useGlobalDartdoc: true,
    globalDartdocVersion: '8.0.0',
  );

  //final dartdocOutputDir =
  //    await Directory(p.join(outputFolder, 'doc')).create();
  final resourcesOutputDir =
      await Directory(p.join(outputFolder, 'resources')).create();
  final pana = PackageAnalyzer(toolEnv);
  // TODO: add a cache purge + retry if the download would fail
  //       (e.g. the package version cache wasn't invalidated).
  var summary = await pana.inspectPackage(
    package,
    version: version,
    options: InspectOptions(
      pubHostedUrl: Platform.environment['PUB_HOSTED_URL']!,
      checkRemoteRepository: true,
      dartdocTimeout: _dartdocTimeout,
      dartdocOutputDir: rawDartdocOutputFolder.path,
    ),
    logger: _log,
    storeResource: (filename, data) async {
      final file = File(p.join(resourcesOutputDir.path, filename));
      await file.parent.create(recursive: true);
      await file.writeAsBytes(data);
    },
  );

  await postPorcessDartdoc(
    outputFolder: outputFolder,
    package: package,
    version: version,
    docDir: rawDartdocOutputFolder.path,
  );
  await rawDartdocOutputFolder.delete(recursive: true);

  // sanity check on pana report size
  final reportSize =
      gzip.encode(utf8.encode(json.encode(summary.toJson()))).length;
  if (reportSize > _reportSizeDropThreshold) {
    summary = Summary(
      createdAt: summary.createdAt,
      runtimeInfo: summary.runtimeInfo,
      tags: ['has:pana-report-exceeds-size-threshold'],
      report: Report(
        sections: [
          ReportSection(
            id: 'error',
            title: 'Report exceeded size limit.',
            grantedPoints: summary.report?.grantedPoints ?? 0,
            maxPoints: summary.report?.maxPoints ?? 0,
            status: ReportStatus.partial,
            summary: 'The `pana` report exceeded size limit. '
                'Please review pana logs or contact the site admins.',
          )
        ],
      ),
    );
  }

  _log.info('Writing summary.json');
  await File(
    p.join(outputFolder, 'summary.json'),
  ).writeAsString(json.encode(summary));
}
