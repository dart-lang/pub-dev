// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert' show json, utf8, Utf8Codec;
import 'dart:io';

import 'package:logging/logging.dart' show Logger, Level, LogRecord;
import 'package:pana/pana.dart';
import 'package:path/path.dart' as p;
import 'package:pub_dartdoc/pub_dartdoc.dart';
import 'package:pub_dartdoc_data/dartdoc_page.dart';
import 'package:pub_worker/src/fetch_pubspec.dart';
import 'package:pub_worker/src/sdks.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:tar/tar.dart';

final _log = Logger('dartdoc');
final _utf8 = Utf8Codec(allowMalformed: true);
final _jsonUtf8 = json.fuse(utf8);

const _defaultMaxFileCount = 10 * 1000 * 1000; // 10 million files

// TODO (sigurdm): reduce this back to 2 GiB when
// https://github.com/dart-lang/dartdoc/issues/3311 is resolved.
const _defaultMaxTotalLengthBytes =
    2 * 1024 * 1024 * 1024 + 300 * 1024 * 1024; // 2 GiB + 300 MiB

/// Program to be used as subprocess for running dartdoc, ensuring that we
/// capture all the output, and only run dartdoc in a subprocess that can
/// timeout and be killed.
Future<void> main(List<String> args) async {
  if (args.length != 3) {
    print('Usage: dartdoc_wrapper.dart <output-folder> <package> <version>');
    exit(1);
  }
  final outputFolder = args[0];
  final package = args[1];
  final version = args[2];
  final pubHostedUrl =
      Platform.environment['PUB_HOSTED_URL'] ?? 'https://pub.dartlang.org';
  final pubCache = Platform.environment['PUB_CACHE']!;

  // Setup logging
  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
    if (rec.error != null) {
      print('ERROR: ${rec.error}, ${rec.stackTrace}');
    }
  });

  final workDir = await Directory.systemTemp.createTemp('pkg-');
  try {
    await _dartdoc(
      outputFolder: outputFolder,
      package: package,
      version: version,
      pubHostedUrl: pubHostedUrl,
      pubCache: pubCache,
      workDir: workDir.path,
    );
  } finally {
    await workDir.delete(recursive: true);
  }
}

Future<void> _dartdoc({
  required String outputFolder,
  required String package,
  required String version,
  required String pubHostedUrl,
  required String pubCache,
  required String workDir,
}) async {
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

  final pkgDir = p.join(workDir, 'pkg');
  await Directory(pkgDir).create(recursive: true);
  // TODO: Ensure that we set User-Agent correctly here!
  await downloadPackage(
    package,
    version,
    destination: pkgDir,
    pubHostedUrl: pubHostedUrl,
  );

  _log.info('Running pub upgrade');
  final ret = await toolEnv.runUpgrade(pkgDir, pubspec.usesFlutter);
  if (ret.exitCode != 0) {
    _log.shout('Failed to run pub upgrade');
    return;
  }

  // Create and/or customize dartdoc_options.yaml
  final optionsFile = File(p.join(pkgDir, 'dartdoc_options.yaml'));
  Map<String, dynamic>? originalContent;
  try {
    originalContent = yamlToJson(await optionsFile.readAsString());
  } on IOException {
    // pass, ignore missing file
  } on FormatException {
    // pass, ignore broken file
  }
  final updatedContent = _customizeDartdocOptions(originalContent);
  await optionsFile.writeAsString(json.encode(updatedContent));

  final docDir = p.join(workDir, 'doc');
  await Directory(docDir).create(recursive: true);
  await pubDartDoc([
    '--input',
    pkgDir,
    '--output',
    docDir,
    '--no-validate-links',
    '--sanitize-html',
    '--max-file-count',
    '$_defaultMaxFileCount',
    '--max-total-size',
    '$_defaultMaxTotalLengthBytes',
    if (pubspec.usesFlutter) ...[
      '--sdk-dir',
      p.join(flutterSdk!.path, 'bin', 'cache', 'dart-sdk')
    ] else ...[
      '--sdk-dir',
      dartSdk!.path,
    ]
  ]);
  _log.info('Finished running dartdoc');

  _log.info('Running post-processing');
  final tmpOutDir = p.join(outputFolder, '_doc');
  await Directory(tmpOutDir).create(recursive: true);
  final files = Directory(docDir)
      .list(recursive: true, followLinks: false)
      .whereType<File>();
  await for (final file in files) {
    final suffix = file.path.substring(docDir.length + 1);
    final targetFile = File(p.join(tmpOutDir, suffix));
    await targetFile.parent.create(recursive: true);
    if (file.path.endsWith('.html')) {
      final page = DartDocPage.parse(await file.readAsString(encoding: _utf8));
      await targetFile.writeAsBytes(_jsonUtf8.encode(page.toJson()));
    } else {
      await file.copy(targetFile.path);
    }
  }
  // Move from temporary output directory to final one, ensuring that
  // documentation files won't be present unless all files have been processed.
  // This helps if there is a timeout along the way.
  await Directory(tmpOutDir).rename(p.join(outputFolder, 'doc'));
  _log.info('Finished post-processing');

  _log.info('Creating .tar.gz archive');
  Stream<TarEntry> _list() async* {
    final originalDocDir = Directory(docDir);
    final originalFiles = originalDocDir
        .list(recursive: true, followLinks: false)
        .whereType<File>();
    await for (final file in originalFiles) {
      // inside the archive prefix the name with <package>/version/
      final relativePath = p.relative(file.path, from: originalDocDir.path);
      final tarEntryPath = p.join(package, version, relativePath);
      final data = await file.readAsBytes();
      yield TarEntry.data(
        TarHeader(
          name: tarEntryPath,
          size: data.length,
        ),
        data,
      );
    }
  }

  final tmpTar = File(p.join(outputFolder, '_package.tar.gz'));
  await _list()
      .transform(tarWriter)
      .transform(gzip.encoder)
      .pipe(tmpTar.openWrite());
  await tmpTar.rename(p.join(outputFolder, 'doc', 'package.tar.gz'));

  _log.info('Finished .tar.gz archive');
}

/// Returns a new, pub-specific dartdoc options based on [original].
///
/// dartdoc_options.yaml allows to change how doc content is generated.
/// To provide uniform experience across the pub site, and to reduce the
/// potential attack surface (HTML-, and code-injections, code executions),
/// we do not support every option.
///
/// https://github.com/dart-lang/dartdoc#dartdoc_optionsyaml
///
/// Discussion on the enabled options:
/// https://github.com/dart-lang/pub-dev/issues/4521#issuecomment-779821098
Map<String, dynamic> _customizeDartdocOptions(Map<String, dynamic>? original) {
  final passThroughOptions = <String, dynamic>{};
  if (original != null &&
      original.containsKey('dartdoc') &&
      original['dartdoc'] is Map<String, dynamic>) {
    final dartdoc = original['dartdoc'] as Map<String, dynamic>;
    for (final key in _passThroughKeys) {
      if (dartdoc.containsKey(key)) {
        passThroughOptions[key] = dartdoc[key];
      }
    }
  }
  return <String, dynamic>{
    'dartdoc': <String, dynamic>{
      ...passThroughOptions,
      'showUndocumentedCategories': true,
    },
  };
}

final _passThroughKeys = <String>[
  'categories',
  'categoryOrder',
  // TODO: enable after checking that the relative path doesn't escape the package folder
  // 'examplePathPrefix',
  'exclude',
  'include',
  'nodoc',
];
