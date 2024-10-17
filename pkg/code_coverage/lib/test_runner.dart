// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: dangling_library_doc_comments

/// Runs integration tests that use fake_pub_server, and collects code coverage
/// on such test runs.

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:args/args.dart';

final _random = Random.secure();
final _argParser = ArgParser()
  ..addOption('package', help: 'The package directory.')
  ..addOption('test', help: 'The relative path inside the package directory.')
  ..addOption('prefix', help: 'The file name prefix to use.')
  ..addOption('app-dir', help: 'The directory of app/.');

Future<void> main(List<String> args) async {
  final buildDir = '${Directory.current.path}/build';

  final argv = _argParser.parse(args);
  final packageDir = argv['package'] as String;
  final testPath = argv['test'] as String;
  final outputPrefix = argv['prefix'] as String;
  final appDir = argv['app-dir'] as String;

  ArgumentError.checkNotNull(packageDir);
  ArgumentError.checkNotNull(testPath);
  ArgumentError.checkNotNull(outputPrefix);

  final testVmPort = _random.nextInt(990) + 19000;
  print('Running $testPath ...');
  final testProcess = await Process.start(
    'dart',
    [
      '--pause-isolates-on-exit',
      '--enable-vm-service=$testVmPort',
      '--disable-service-auth-codes',
      testPath,
    ],
    workingDirectory: packageDir,
    environment: {
      'COVERAGE_DIR': buildDir,
      'COVERAGE_SESSION': outputPrefix,
    },
  );

  _writeLogs(testProcess.stdout, '[$testPath][OUT]');
  _writeLogs(testProcess.stderr, '[$testPath][ERR]');

  await Future.delayed(Duration(seconds: 15));
  final testCollectProcess =
      await _startCollect(testVmPort, '$buildDir/raw/$outputPrefix-test.json');

  final testOutput = await testProcess.exitCode;
  print('$testPath exited with code $testOutput');

  print('Waiting for test coverage...');
  await testCollectProcess.exitCode;

  final dir = Directory('$buildDir/raw');
  final files = dir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.split('/').last.startsWith('$outputPrefix-'));
  for (final file in files) {
    final name = file.path.split('/').last;
    await _convertToLcov(
      name.contains('fake-pub-server') ? appDir : packageDir,
      '$buildDir/raw/$name',
      '$buildDir/lcov/$name.info',
    );
  }
}

void _writeLogs(Stream<List<int>> stream, String prefix) {
  stream.transform(utf8.decoder).transform(LineSplitter()).listen(
    (s) {
      s = s.trim();
      if (s.isNotEmpty) {
        print('  $prefix ${s.trim()}');
      }
    },
    onDone: () {
      print('  $prefix[DONE]');
    },
  );
}

Future<Process> _startCollect(int port, String outputFile) async {
  await File(outputFile).parent.create(recursive: true);
  print('[collect-$port-$outputFile] starting...');
  final p = await Process.start(
    'dart',
    [
      'pub',
      'run',
      'coverage:collect_coverage',
      '--uri=http://localhost:$port',
      '-o',
      outputFile,
      '--wait-paused',
      '--resume-isolates',
    ],
  );
  _writeLogs(p.stdout, '[collect-$port-$outputFile-out]');
  _writeLogs(p.stderr, '[collect-$port-$outputFile-err]');
  return p;
}

Future<void> _convertToLcov(
    String packageDir, String inputFile, String outputFile) async {
  final out = File(outputFile);
  if (await out.exists()) return;
  await out.parent.create(recursive: true);
  await Process.run(
    'dart',
    [
      'pub',
      'run',
      'coverage:format_coverage',
      '--packages',
      '$packageDir/.dart_tool/package_config.json',
      '-i',
      inputFile,
      '--base-directory',
      packageDir.contains('/app') ? '../' : '../../',
      '--lcov',
      '--out',
      outputFile,
    ],
    workingDirectory: packageDir,
  );
}
