// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert' show JsonUtf8Encoder, LineSplitter, Utf8Decoder, utf8;
import 'dart:io'
    show Directory, File, IOException, Platform, Process, ProcessSignal, gzip;
import 'dart:isolate' show Isolate;

import 'package:_pub_shared/data/task_payload.dart';
import 'package:_pub_shared/pubapi.dart';
import 'package:clock/clock.dart' show clock;
import 'package:http/http.dart' show Client, ClientException;
import 'package:indexed_blob/indexed_blob.dart';
import 'package:logging/logging.dart' show Logger;
import 'package:path/path.dart' as p;
import 'package:pub_worker/src/http.dart';
import 'package:pub_worker/src/upload.dart';
import 'package:pub_worker/src/utils.dart' show stripTrailingSlashes;
import 'package:retry/retry.dart';

final _log = Logger('pub_worker.process_payload');

/// Gracefully shutdown and report versions as done without results, if
/// processing takes more than 55 minutes.
const _workerTimeout = Duration(minutes: 55);

/// Stop pana if it takes more than 50 minutes.
/// This also includes pana running dartdoc.
const _panaTimeout = Duration(minutes: 50);

List<int> encodeJson(Object json) => JsonUtf8Encoder().convert(json);

/// Retry requests with a longer delay between them.
final _retryOptions = RetryOptions(delayFactor: Duration(seconds: 5));

/// Retry request if it fails because of an [IOException] or status is 5xx.
bool _retryIf(Exception e) =>
    e is IOException ||
    (e is RequestException && e.status >= 500) ||
    e is ClientException ||
    e is TimeoutException;

Future<void> analyze(Payload payload) async {
  _log.info('Running analyze for payload with package:${payload.package}');

  // Create a single PUB_CACHE and PANA_CACHE that can be reused for analysis
  // of each package version:
  // - re-using the same PUB_CACHE avoids downloading packages again,
  // - re-using the same PANA_CACHE avoids analyzing the same external URLs again.
  final tempDir = await Directory.systemTemp.createTemp('analyzer');
  final pubCacheDir = Directory(p.join(tempDir.path, 'pub-cache'));
  await pubCacheDir.create(recursive: true);
  final panaCacheDir = Directory(p.join(tempDir.path, 'pana-cache'));
  await panaCacheDir.create(recursive: true);

  final workerDeadline = clock.now().add(_workerTimeout);
  final client = Client().withUserAgent(pubWorkerUserAgent);
  try {
    for (final p in payload.versions) {
      final api = PubApiClient(
        // Documentation says [payload.pubHostedUrl] should not end with a slash,
        // but server has no out-going validation. So let's just be defensive
        // and strip trailing slashes for good measure.
        stripTrailingSlashes(payload.pubHostedUrl),
        client: client.withAuthorization(() => p.token),
      );

      try {
        // Skip analysis, if we're past the worker deadline
        if (clock.now().isBefore(workerDeadline)) {
          await _analyzePackage(
            client,
            api,
            package: payload.package,
            version: p.version,
            pubHostedUrl: payload.pubHostedUrl,
            pubCache: pubCacheDir.path,
            panaCache: panaCacheDir.path,
          );
        } else {
          await _reportPackageSkipped(
            client,
            api,
            payload.package,
            p.version,
            reason:
                'Processing of package versions exceeded allocated duration.\n'
                'This is because all versions are analyzed in a single batch,\n'
                'the other versions of this package took too long time to '
                'analyze.',
          );
        }
      } catch (e, st) {
        _log.shout(
          'failed to process ${payload.package} / ${p.version}',
          e,
          st,
        );
      }
    }
  } finally {
    client.close();
    await tempDir.delete(recursive: true);
  }
  _log.info('Finished analysis of package:${payload.package}');
}

Future<void> _analyzePackage(
  Client client,
  PubApiClient api, {
  required String package,
  required String version,
  required String pubHostedUrl,
  required String pubCache,
  required String panaCache,
}) async {
  _log.info('Running analyze for $package / $version');

  final tempDir = await Directory.systemTemp.createTemp('pub_worker-');

  final outDir = await Directory(p.join(tempDir.path, 'out')).create();
  try {
    final logFile = File(p.join(outDir.path, 'log.txt'));
    final log = logFile.openWrite();

    log.writeln('## Running analysis for "$package" version "$version"');
    log.writeln('STARTED: ${clock.now().toUtc().toIso8601String()}');
    log.writeln(''); // empty-line before the next headline

    // Run the analysis
    {
      log.writeln('### Starting pana');
      final panaWrapper = await Isolate.resolvePackageUri(Uri.parse(
        'package:pub_worker/src/bin/pana_wrapper.dart',
      ));
      final pana = await Process.start(
        Platform.resolvedExecutable,
        [
          panaWrapper!.toFilePath(),
          outDir.path,
          package,
          version,
        ],
        workingDirectory: outDir.path,
        includeParentEnvironment: true,
        environment: {
          'CI': 'true',
          'PUB_HOSTED_URL': pubHostedUrl,
          'PUB_CACHE': pubCache,
          'PANA_CACHE': panaCache,
        },
      );
      await pana.stdin.close();

      await Future.wait<void>([
        pana.stderr
            .transform(Utf8Decoder(allowMalformed: true))
            .transform(LineSplitter())
            .forEach(log.writeln),
        pana.stdout
            .transform(Utf8Decoder(allowMalformed: true))
            .transform(LineSplitter())
            .forEach(log.writeln),
        pana.exitOrTimeout(_panaTimeout, () {
          log.writeln('TIMEOUT: pana sending SIGTERM/SIGKILL');
        }),
      ]).catchError((e) => const [/* ignore */]);
      final exitCode = await pana.exitCode;

      log.writeln('### Execution of pana exited $exitCode');
      log.writeln('STOPPED: ${clock.now().toUtc().toIso8601String()}');
    }

    // Create a file to store the blob, and add everything to it.
    final blobFile = File(p.join(tempDir.path, 'files.blob'));
    final builder = IndexedBlobBuilder(blobFile.openWrite());

    await for (final f in outDir.list(recursive: true, followLinks: false)) {
      if (f is File) {
        final path = p.relative(f.path, from: outDir.path);
        if (path == 'log.txt') {
          continue; // We'll add this at the very end!
        }
        try {
          await builder.addFile(path, f.openRead().transform(gzip.encoder));
        } on IOException {
          log.writeln('ERROR: Failed to read output file at "$path"');
        }
      }
    }

    // Close the log
    log.writeln(); // always end with a newline
    await log.flush();
    await log.close();

    // Add the log file to the blob, this allows us to write any errors we found
    // along the way to the log file which is nice.
    await builder.addFile(
      'log.txt',
      logFile.openRead().transform(gzip.encoder),
    );

    // Upload results, if there is any
    _log.info('api.taskUploadResult("$package", "$version")');
    final r = await _retryOptions.retry(
      () => api.taskUploadResult(package, version),
      retryIf: _retryIf,
    );

    // Create BlobIndex
    final index = await builder.buildIndex(r.blobId);

    // Upload blob and index
    await upload(
      client,
      r.blob,
      () => blobFile.openRead(),
      blobFile.statSync().size,
      filename: r.blobId,
      contentType: 'application/octet-stream',
    );
    // Always upload the index last, this references the blobId, and when we
    // upload this we will overwrite the previous value. So we have atomicity
    // even though we're uploading two files.
    await upload(
      client,
      r.index,
      () => Stream.value(index.asBytes()),
      index.asBytes().length,
      filename: 'index.json',
      contentType: 'application/json',
    );

    // Report that we're done processing the package / version.
    _log.info('api.taskUploadFinished("$package", "$version")');
    await _retryOptions.retry(
      () => api.taskUploadFinished(package, version),
      retryIf: _retryIf,
    );
  } finally {
    await tempDir.delete(recursive: true);
  }
}

/// Report that analysis of [package] / [version] was skipped,
/// because of [reason].
///
/// The [reason] will be printed to the log file, and empty results will be
/// uploaded / omitted for the other files.
Future<void> _reportPackageSkipped(
  Client client,
  PubApiClient api,
  String package,
  String version, {
  required String reason,
}) async {
  _log.info('Skipping analysis of "$package" version "$version"');

  _log.info('api.taskUploadResult("$package", "$version") - skipping');

  final r = await _retryOptions.retry(
    () => api.taskUploadResult(package, version),
    retryIf: _retryIf,
  );

  final output = await BlobIndexPair.build(r.blobId, (addFile) async {
    await addFile(
      'log.txt',
      Stream.value([
        '## Skipping analysis for "$package" version "$version"',
        'date-time: ${clock.now().toUtc().toIso8601String()}',
        '',
        'reason:',
        reason,
        '', // always end with a newline
      ].join('\n'))
          .transform(utf8.fuse(gzip).encoder),
    );
  });

  // Upload blob and index
  await upload(
    client,
    r.blob,
    () => Stream.value(output.blob),
    output.blob.length,
    filename: r.blobId,
    contentType: 'application/octet-stream',
  );
  await upload(
    client,
    r.index,
    () => Stream.value(output.index.asBytes()),
    output.index.asBytes().length,
    filename: 'index.json',
    contentType: 'application/json',
  );

  // Report that we're done processing the package / version.
  _log.info('api.taskUploadFinished("$package", "$version") - skipped');
  await _retryOptions.retry(
    () => api.taskUploadFinished(package, version),
    retryIf: _retryIf,
  );
}

extension on Process {
  /// Return [exitCode] or send SIGTERM after [timeout].
  ///
  /// After SIGTERM, this method will wait 30s before sending SIGKILL.
  ///
  /// Returns [exitCode].
  Future<int> exitOrTimeout(
    Duration timeout, [
    void Function()? onTimeout,
  ]) async =>
      exitCode.timeout(timeout, onTimeout: () async {
        if (onTimeout != null) {
          onTimeout();
        }
        // Send SIGTERM
        kill(ProcessSignal.sigterm);

        // Wait 30s and then SIGKILL
        return await exitCode.timeout(
          Duration(seconds: 30),
          onTimeout: () async {
            kill(ProcessSignal.sigkill);
            return exitCode;
          },
        );
      });
}
