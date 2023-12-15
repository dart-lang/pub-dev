import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart' as p;
import 'package:pub_worker/payload.dart';
import 'package:pub_worker/src/testing/docker_utils.dart';
import 'package:pub_worker/src/testing/server.dart';

final _argParser = ArgParser()
  ..addFlag('observe',
      negatable: false, help: 'start pub_worker with --observe')
  ..addFlag('docker',
      negatable: false, help: 'run pub_worker in docker container')
  ..addFlag('help', negatable: false)
  ..addOption('output',
      abbr: 'o',
      help: 'folder output should be written to',
      valueHelp: 'folder');

void main(List<String> args) async {
  ArgResults argResults;
  try {
    argResults = _argParser.parse(args);
    if (argResults['help'] == true) {
      print('dart tool/trypkg.dart <package> <version>\n${_argParser.usage}');
      return;
    }
    if (argResults.rest.length != 2) {
      throw FormatException('Expected two arguments');
    }
  } on FormatException catch (e) {
    print('Error: ${e.message}\n');
    print('dart tool/trypkg.dart <package> <version>\n${_argParser.usage}');
    return;
  }

  final package = argResults.rest[0];
  final version = argResults.rest[1];

  final pubHostedUrl =
      Platform.environment['PUB_HOSTED_URL'] ?? 'https://pub.dev';
  final server = PubWorkerTestServer([], fallbackPubHostedUrl: pubHostedUrl);

  await server.start();
  final payload = Payload(
    package: package,
    pubHostedUrl: '${server.baseUrl}',
    versions: [
      VersionTokenPair(
        version: version,
        token: 'secret-token',
      ),
    ],
  );

  final Process worker;
  if (argResults['docker'] == true) {
    try {
      print('Building worker docker image');
      await buildDockerImage();
    } catch (e) {
      print('Building worker docker image failed: $e');
      exit(-1);
    }
    worker = await startDockerAnalysis(payload);
  } else {
    worker = await Process.start(
      Platform.resolvedExecutable,
      [
        'run',
        if (argResults['observe'] == true) '--observe',
        'pub_worker',
        json.encode(payload),
      ],
      mode: ProcessStartMode.inheritStdio,
    );
  }
  try {
    print('Starting worker');
    final exitCode = await worker.exitCode;
    print('Worker finished, exiting $exitCode');

    final result = await server.waitForResult(package, version);
    print('Result was uploaded');
    if (argResults.wasParsed('output')) {
      final output = Directory(argResults['output'] as String);
      await output.create(recursive: true);
      print('Writing output:');
      for (final entry in result.index.files) {
        print(' - ${entry.path}');
        final f = File(p.join(output.path, entry.path));
        await f.parent.create(recursive: true);
        await f.writeAsBytes(gzip.decode(entry.slice(result.blob)));
      }
    }
  } finally {
    await server.stop();
  }
}
