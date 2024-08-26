// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert' show json, utf8;
import 'dart:io' show Directory, File, Platform, exit, gzip;

import 'package:_pub_shared/utils/dart_sdk_version.dart';
import 'package:_pub_shared/utils/flutter_archive.dart';
import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:logging/logging.dart' show Logger, Level, LogRecord;
import 'package:pana/pana.dart';
import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';
import 'package:pub_worker/src/bin/dartdoc_wrapper.dart';
import 'package:pub_worker/src/fetch_pubspec.dart';
import 'package:pub_worker/src/sdks.dart';
import 'package:pub_worker/src/utils.dart';
import 'package:retry/retry.dart';

final _log = Logger('pana');

/// The maximum of the compressed pana report. Larger reports will be dropped and
/// replaced with a placeholder report.
final _reportSizeDropThreshold = 32 * 1024;

/// Stop dartdoc if it takes more than 30 minutes.
const _dartdocTimeout = Duration(minutes: 30);

/// Try to fit analysis into 50 minutes.
const _totalTimeout = Duration(minutes: 50);

/// The dartdoc version to use.
/// keep in-sync with app/lib/shared/versions.dart
const _dartdocVersion = '8.0.14';

/// Program to be used as subprocess for running pana, ensuring that we capture
/// all the output, and only run analysis in a subprocess that can timeout and
/// be killed.
Future<void> main(List<String> args) async {
  if (args.length != 3) {
    print('Usage: pana_wrapper.dart <output-folder> <package> <version>');
    exit(1);
  }

  final startedTimestamp = clock.now();

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
  // TODO(https://github.com/dart-lang/pub-dev/issues/7268): Download the archive,
  //       extract and load the pubspec.yaml, that way we won't have to list versions.
  final pubspec = await fetchPubspec(
    package: package,
    version: version,
    pubHostedUrl: pubHostedUrl,
  );

  final detected = await _detectSdks(pubspec);

  final toolEnv = await ToolEnvironment.create(
    dartSdkConfig: SdkConfig(
      rootPath: detected.dartSdkPath,
      configHomePath: _configHomePath('dart', detected.configKind),
    ),
    flutterSdkConfig: SdkConfig(
      rootPath: detected.flutterSdkPath,
      configHomePath: _configHomePath('flutter', detected.configKind),
    ),
    pubCacheDir: pubCache,
    dartdocVersion: _dartdocVersion,
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
      dartdocTimeout: _dartdocTimeout,
      dartdocOutputDir: rawDartdocOutputFolder.path,
      panaCacheDir: Platform.environment['PANA_CACHE'],
      resourcesOutputDir: resourcesOutputDir.path,
      totalTimeout: _totalTimeout,
    ),
    logger: _log,
  );

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

  // Post-processing of the dartdoc-generated files seems to take at least as
  // much time as running pana+dartdoc in the first place. If we don't seem to
  // have enough time to complete, it is better to not start at all.
  final cutoffTimestamp = startedTimestamp.add(_totalTimeout * 0.5);
  if (cutoffTimestamp.isBefore(clock.now())) {
    _log.warning(
        'Cut-off timestamp reached, skipping dartdoc post-processing.');
    return;
  }
  await postProcessDartdoc(
    outputFolder: outputFolder,
    package: package,
    version: version,
    docDir: rawDartdocOutputFolder.path,
  );

  await rawDartdocOutputFolder.delete(recursive: true);
}

final _workerConfigDirectory = Directory('/home/worker/config');
late final _workerConfigPath =
    _workerConfigDirectory.existsSync() ? _workerConfigDirectory.path : null;
late final _isInsideDocker = _workerConfigPath != null;
String? _configHomePath(String sdk, String kind) {
  if (!_isInsideDocker) {
    return null;
  }
  final path = p.join(_workerConfigPath!, '$sdk-$kind');
  Directory(path).createSync(recursive: true);
  return path;
}

Future<({String configKind, String? dartSdkPath, String? flutterSdkPath})>
    _detectSdks(Pubspec pubspec) async {
  // Discover installed Dart and Flutter SDKs.
  // This reads sibling folders to the Dart and Flutter SDK.
  final dartSdks = await InstalledSdk.scanDirectory(
    kind: 'dart',
    path: Directory(
      Platform.environment['DART_SDK'] ??
          Directory(Platform.resolvedExecutable).parent.parent.path,
    ).parent,
  );
  final flutterSdks = await InstalledSdk.scanDirectory(
    kind: 'flutter',
    path: Directory(Platform.environment['FLUTTER_ROOT'] ?? '').parent,
  );

  // Choose stable Dart and Flutter SDKs for analysis
  final installedDartSdk =
      dartSdks.firstWhereOrNull((sdk) => !sdk.version.isPreRelease) ??
          dartSdks.firstOrNull;
  final installedFlutterSdk =
      flutterSdks.firstWhereOrNull((sdk) => !sdk.version.isPreRelease) ??
          flutterSdks.firstOrNull;

  bool matchesSdks({
    required Version? dart,
    required Version? flutter,
    required Version? flutterDartSdk,
    bool allowsMissingVersion = false,
  }) {
    if (!allowsMissingVersion && (dart == null || flutter == null)) {
      return false;
    }

    // Dart SDK
    if (!sdkMatchesConstraint(
        sdkVersion: dart, constraint: pubspec.dartSdkConstraint)) {
      return false;
    }

    // Flutter SDK
    if (!sdkMatchesConstraint(
        sdkVersion: flutter, constraint: pubspec.flutterSdkConstraint)) {
      return false;
    }

    // Dart SDK inside the Flutter SDK
    if (flutterDartSdk != null &&
        !sdkMatchesConstraint(
            sdkVersion: flutterDartSdk,
            constraint: pubspec.dartSdkConstraint)) {
      return false;
    }

    // Otherwise accepting the analysis SDK bundle.
    return true;
  }

  // try to use the latest SDKs in the docker image
  final matchesInstalledSdks = matchesSdks(
    dart: installedDartSdk?.version,
    flutter: installedFlutterSdk?.version,
    flutterDartSdk: installedFlutterSdk?.embeddedDartSdkVersion,
    allowsMissingVersion: true,
  );
  if (matchesInstalledSdks) {
    return (
      configKind: 'stable',
      dartSdkPath: installedDartSdk?.path,
      flutterSdkPath: installedFlutterSdk?.path,
    );
  }

  // try to use the latest stable downloadable SDKs, or
  // try to use the latest beta/preview SDKs, or
  // fall back to the latest dev/master branch (last item always present and matching)
  final latestSdkBundles = await _detectSdkBundles();
  for (final bundle in latestSdkBundles) {
    final matchesBundle = bundle.configKind == 'master' ||
        matchesSdks(
          dart: bundle.semanticDartVersion,
          flutter: bundle.semanticFlutterVersion,
          flutterDartSdk: bundle.semanticFlutterDartSdkVersion,
        );
    if (matchesBundle) {
      final dartSdkPath = await _installSdk(
        sdkKind: 'dart',
        configKind: bundle.configKind,
        version: bundle.dart,
        channel: bundle.channel,
      );
      final flutterSdkPath = await _installSdk(
        sdkKind: 'flutter',
        configKind: bundle.configKind,
        version: bundle.flutter,
        channel: bundle.channel,
      );

      return (
        configKind: bundle.configKind,
        dartSdkPath: dartSdkPath,
        flutterSdkPath: flutterSdkPath,
      );
    }
  }

  // should not happen, but instead of failing, let's return the installed SDKs
  return (
    configKind: 'stable',
    dartSdkPath: installedDartSdk?.path,
    flutterSdkPath: installedFlutterSdk?.path,
  );
}

Future<String?> _installSdk({
  required String sdkKind,
  required String channel,
  required String configKind,
  required String version,
}) async {
  if (!_isInsideDocker) {
    return null;
  }
  final sdkPath = p.join('/home/worker', sdkKind, configKind);
  final sdkDir = Directory(sdkPath);
  if (await sdkDir.exists()) {
    return sdkPath;
  }
  await RetryOptions(maxAttempts: 3).retry(
    () async {
      try {
        final configHomePath = _configHomePath(sdkKind, configKind);
        await runConstrained(
          [
            'tool/setup-$sdkKind.sh',
            sdkPath,
            version,
            channel,
          ],
          workingDirectory: '/home/worker/pub-dev',
          environment: {
            if (configHomePath != null) 'XDG_CONFIG_HOME': configHomePath,
            'PUB_HOSTED_URL': 'https://pub.dev',
          },
          timeout: const Duration(minutes: 5),
          throwOnError: true,
        );
      } catch (_) {
        // on any failure clearing the target directory
        if (await sdkDir.exists()) {
          await sdkDir.delete(recursive: true);
        }
      }
    },
    retryIf: (_) => true,
  );
  return sdkPath;
}

class _SdkBundle {
  final String channel;
  final String configKind;
  final String dart;
  final String flutter;
  final Version? semanticFlutterDartSdkVersion;

  _SdkBundle({
    required this.channel,
    required this.configKind,
    required this.dart,
    required this.flutter,
    required this.semanticFlutterDartSdkVersion,
  });

  late final semanticDartVersion = Version.parse(dart);
  late final semanticFlutterVersion = Version.parse(flutter);
}

Future<List<_SdkBundle>> _detectSdkBundles() async {
  final flutterArchive = await fetchFlutterArchive();
  final latestStableFlutterSdkVersion = flutterArchive?.latestStable?.version;
  final latestBetaFlutterSdkVersion = flutterArchive?.latestBeta?.version;

  final latestStableDartSdk =
      await fetchLatestDartSdkVersion(channel: 'stable');
  final latestStableDartSdkVersion = latestStableDartSdk?.version;

  final latestBetaDartSdk = await fetchLatestDartSdkVersion(channel: 'beta');
  final latestBetaDartSdkVersion = latestBetaDartSdk?.version;

  return [
    if (latestStableDartSdkVersion != null &&
        latestStableFlutterSdkVersion != null)
      _SdkBundle(
        channel: 'stable',
        configKind: 'latest-stable',
        dart: latestStableDartSdkVersion,
        flutter: latestStableFlutterSdkVersion,
        semanticFlutterDartSdkVersion:
            flutterArchive?.latestStable?.semanticDartSdkVersion,
      ),
    if (latestBetaDartSdkVersion != null && latestBetaFlutterSdkVersion != null)
      _SdkBundle(
        channel: 'beta',
        configKind: 'latest-beta',
        dart: latestBetaDartSdkVersion,
        flutter: latestBetaFlutterSdkVersion,
        semanticFlutterDartSdkVersion:
            flutterArchive?.latestBeta?.semanticDartSdkVersion,
      ),
    _SdkBundle(
      channel: 'master',
      configKind: 'master',
      dart: 'master',
      flutter: 'master',
      semanticFlutterDartSdkVersion: null,
    ),
  ];
}
