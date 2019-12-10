// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Runs integration tests that use fake_pub_server, and collects code coverage
/// on such test runs.

import 'dart:io';
import 'dart:math';

import 'package:args/args.dart';

final _random = Random.secure();
final _argParser = ArgParser()
  ..addOption('package', help: 'The package directory.')
  ..addOption('test', help: 'The relative path inside the package directory.')
  ..addOption('prefix', help: 'The file name prefix to use.')
  ..addFlag('fake-pub-server',
      defaultsTo: false, help: 'Indicates the use of fake_pub_server.');

Future<void> main(List<String> args) async {
  final buildDir = '${Directory.current.path}/build';

  final argv = _argParser.parse(args);
  final packageDir = argv['package'] as String;
  final testPath = argv['test'] as String;
  final outputPrefix = argv['prefix'] as String;
  final usesFakePubServer = argv['fake-pub-server'] as bool;

  ArgumentError.checkNotNull(packageDir);
  ArgumentError.checkNotNull(testPath);
  ArgumentError.checkNotNull(outputPrefix);

  final testVmPort = _random.nextInt(990) + 19000;
  final fakePubServerVmPort = testVmPort + 1;
  final testCollectProcess =
      await _startCollect(testVmPort, '$buildDir/raw/$outputPrefix-test.json');
  Process fakePubServerCollectProcess;
  if (usesFakePubServer) {
    fakePubServerCollectProcess = await _startCollect(fakePubServerVmPort,
        '$buildDir/raw/$outputPrefix-fake-pub-server.json');
  }

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
      'COVERAGE_DIR': '$buildDir/browser',
      'FAKE_PUB_SERVER_VM_ARGS':
          '--pause-isolates-on-exit --enable-vm-service=$fakePubServerVmPort --disable-service-auth-codes',
    },
  );
  await testProcess.exitCode;

  await testCollectProcess.exitCode;
  await fakePubServerCollectProcess?.exitCode;

  await _convertToLcov(
    packageDir,
    '$buildDir/raw/$outputPrefix-test.json',
    '$buildDir/lcov/$outputPrefix-test.json.info',
  );

  if (usesFakePubServer) {
    await _convertToLcov(
      '../fake_pub_server',
      '$buildDir/raw/$outputPrefix-fake-pub-server.json',
      '$buildDir/lcov/$outputPrefix-fake-pub-server.json.info',
    );
  }
}

Future<Process> _startCollect(int port, String outputFile) async {
  await File(outputFile).parent.create(recursive: true);
  return Process.start(
    'pub',
    [
      'run',
      'coverage:collect_coverage',
      '--uri=http://localhost:$port',
      '-o',
      outputFile,
      '--wait-paused',
      '--resume-isolates',
    ],
  );
}

Future<void> _convertToLcov(
    String packageDir, String inputFile, String outputFile) async {
  await File(outputFile).create(recursive: true);
  await Process.run(
    'pub',
    [
      'run',
      'coverage:format_coverage',
      '--packages',
      '$packageDir/.packages',
      '-i',
      inputFile,
      '--base-directory',
      '../../',
      '--lcov',
      '--out',
      outputFile,
    ],
  );
}
