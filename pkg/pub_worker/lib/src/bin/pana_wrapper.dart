// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert' show json;
import 'dart:io' show Directory, File, IOException, Platform, exit;

import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart' show Logger, Level, LogRecord;
import 'package:meta/meta.dart';
import 'package:pana/pana.dart';
import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart' show Version, VersionConstraint;
import 'package:retry/retry.dart';

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
  final pubspec = await _fetchPubspec(
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
    environment: {
      'CI': 'true',
      'PUB_CACHE': pubCache,
    },
    useGlobalDartdoc: false,
  );

  final dartdocOutputDir =
      await Directory(p.join(outputFolder, 'doc')).create();
  final resourcesOutputDir =
      await Directory(p.join(outputFolder, 'resources')).create();
  final pana = PackageAnalyzer(toolEnv);
  final summary = await pana.inspectPackage(
    package,
    version: version,
    options: InspectOptions(
      isInternal: true,
      //TODO: Add analysisOptionsYaml, or move the logic into pana
      pubHostedUrl: Platform.environment['PUB_HOSTED_URL']!,
      dartdocOutputDir: dartdocOutputDir.path,
      dartdocRetry: 2,
      dartdocTimeout: Duration(minutes: 15),
      checkRemoteRepository: true,
    ),
    logger: _log,
    storeResource: (filename, data) async {
      final file = File(p.join(resourcesOutputDir.path, filename));
      await file.parent.create(recursive: true);
      await file.writeAsBytes(data);
    },
  );

  _log.info('Writing summary.json');
  await File(
    p.join(outputFolder, 'summary.json'),
  ).writeAsString(json.encode(summary));
}

@sealed
class InstalledSdk {
  final String path;
  final Version version;
  final String kind;
  InstalledSdk(this.kind, this.path, this.version);

  /// List SDKs installed into [path].
  ///
  /// This looks for sub-folders containing `version` files.
  static Future<List<InstalledSdk>> fromDirectory({
    required String kind,
    required Directory path,
  }) async {
    final sdks = <InstalledSdk>[];
    if (!await path.exists()) {
      return sdks;
    }
    await for (final d in path.list()) {
      if (d is! Directory) {
        continue;
      }
      final v = await File(p.join(d.path, 'version')).readAsString();
      try {
        sdks.add(InstalledSdk(kind, d.path, Version.parse(v)));
      } on FormatException {
        continue;
      }
    }
    sdks.sortByCompare((s) => s.version, Version.prioritize);
    return sdks;
  }

  static InstalledSdk? prioritizedSdk(
    List<InstalledSdk> sdks,
    VersionConstraint? constraint,
  ) {
    constraint ??= VersionConstraint.any;
    sdks = [...sdks]..sortByCompare((s) => s.version, Version.prioritize);
    return sdks.where((s) => constraint!.allows(s.version)).firstOrNull ??
        maxBy(sdks, (s) => s.version);
  }
}

/// Fetch pubspec for the given version
Future<Pubspec> _fetchPubspec({
  required String package,
  required String version,
  required String pubHostedUrl,
}) async {
  final c = http.Client();
  try {
    final result = await retry(
      () async {
        // TODO: Make some reusable HTTP request logic
        final u = Uri.parse(_urlJoin(pubHostedUrl, 'api/packages/$package'));
        final r = await c.get(u);
        if (r.statusCode >= 500) {
          throw _IntermittentHttpException._(
            'Failed to list versions, got ${r.statusCode} from "$u"',
          );
        }
        if (r.statusCode != 200) {
          throw Exception(
            'Failed to list versions, got ${r.statusCode} from "$u"',
          );
        }
        return json.decode(r.body);
      },
      retryIf: (e) =>
          e is _IntermittentHttpException ||
          e is FormatException ||
          e is IOException,
    );

    final versions = result['versions'] as List? ?? [];

    final v = Version.parse(version);
    return versions.map((e) => Pubspec(e['pubspec'] as Map)).firstWhere(
        (p) => p.version == v,
        orElse: () => throw Exception('could not find $version'));
  } finally {
    c.close();
  }
}

String _urlJoin(String url, String suffix) {
  if (!url.endsWith('/')) {
    url += '/';
  }
  return url + suffix;
}

class _IntermittentHttpException implements Exception {
  final String _message;
  _IntermittentHttpException._(this._message);
  @override
  String toString() => _message;
}
