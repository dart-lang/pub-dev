// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert' show JsonUtf8Encoder, json, utf8;
import 'dart:io'
    show Directory, File, IOException, Platform, Process, ProcessSignal;
import 'dart:isolate' show Isolate;

import 'package:clock/clock.dart' show clock;
import 'package:http/http.dart' show Client;
import 'package:indexed_blob/indexed_blob.dart';
import 'package:logging/logging.dart' show Logger;
import 'package:pana/pana.dart';
import 'package:path/path.dart' as p;
import 'package:pub_worker/pana_report.dart' show PanaReport;
import 'package:pub_worker/payload.dart';
import 'package:pub_worker/src/http.dart';
import 'package:pub_worker/src/pubapi.client.dart';
import 'package:pub_worker/src/upload.dart';
import 'package:pub_worker/src/utils.dart' show stripTrailingSlashes;
import 'package:retry/retry.dart';

final _log = Logger('pub_worker.process_payload');

/// Gracefully shutdown and report versions as done without results, if
/// processing takes more than 45 minutes.
const _workerTimeout = Duration(minutes: 45);

/// Stop analysis if it takes more than 15 minutes.
const _analysisTimeout = Duration(minutes: 15);

List<int> encodeJson(Object json) => JsonUtf8Encoder().convert(json);

/// Retry request if it fails because of an [IOException] or status is 5xx.
bool _retryIf(Exception e) =>
    e is IOException || (e is RequestException && e.status >= 500);

Future<void> analyze(Payload payload) async {
  _log.info('Running analyze for payload with package:${payload.package}');
  final workerDeadline = clock.now().add(_workerTimeout);
  final client = Client();
  try {
    for (final p in payload.versions) {
      final api = PubApiClient(
        // Documentation says [payload.callbackUrl] should not end with a slash,
        // but server has no out-going validation. So let's just be defensive
        // and strip trailing slashes for good measure.
        stripTrailingSlashes(payload.callbackUrl),
        client: client.withAuthorization(() => p.token),
      );

      try {
        // Skip analysis, if we're past the worker deadline
        if (clock.now().isBefore(workerDeadline)) {
          await _analyzePackage(client, api, payload.package, p.version);
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
  }
}

Future<void> _analyzePackage(
  Client client,
  PubApiClient api,
  String package,
  String version,
) async {
  _log.info('Running analyze for $package / $version');

  final tempDir = await Directory.systemTemp.createTemp('pub_worker-');
  try {
    final logFile = File(p.join(tempDir.path, 'log.txt'));
    final log = logFile.openWrite();

    log.writeln('## Running analysis for "$package" version "$version"');
    log.writeln('STARTED: ${clock.now().toUtc().toIso8601String()}');
    log.writeln(''); // empty-line before the next headline

    // Run the analysis
    log.writeln('### Starting pana');
    final panaWrapper = await Isolate.resolvePackageUri(Uri.parse(
      'package:pub_worker/src/bin/pana_wrapper.dart',
    ));
    final pana = await Process.start(
      Platform.resolvedExecutable,
      [
        panaWrapper!.toFilePath(),
        tempDir.path,
        package,
        version,
      ],
      workingDirectory: tempDir.path,
      includeParentEnvironment: true,
    );
    await pana.stdin.close();

    var done = false;
    scheduleMicrotask(() async {
      await Future.delayed(_analysisTimeout);
      if (done) {
        return;
      }
      log.writeln('TIMEOUT: Sending SIGTERM to pana');
      pana.kill(ProcessSignal.sigterm);

      // Give 30 seconds for graceful termination
      await Future.delayed(Duration(seconds: 30));
      // ignore: invariant_booleans
      if (done) {
        return;
      }
      log.writeln('TIMEOUT: Sending SIGKILL to pana');
      pana.kill(ProcessSignal.sigkill);
    });
    await Future.wait([
      pana.stderr.forEach(log.add),
      pana.stdout.forEach(log.add),
      pana.exitCode,
    ]).catchError((e) {/* ignore */});
    done = true;
    final exitCode = await pana.exitCode;

    log.writeln('### Execution of pana exited $exitCode');
    log.writeln('STOPPED: ${clock.now().toUtc().toIso8601String()}');

    // Check if we got any results
    final dartdocDir = Directory(p.join(tempDir.path, 'dartdoc'));
    final panaSummaryFile = File(p.join(tempDir.path, 'pana-summary.json'));
    final hasPanaSummary = await panaSummaryFile.exists();
    final hasDartDoc = await dartdocDir.exists();

    log.writeln('has dartdoc: $hasDartDoc');
    log.writeln('has pana summary: $hasPanaSummary');

    Summary? summary;
    if (hasPanaSummary) {
      try {
        final summaryJson = json.decode(await panaSummaryFile.readAsString());
        if (summaryJson != null) {
          summary = Summary.fromJson(summaryJson as Map<String, dynamic>);
        }
      } on Exception catch (e) {
        log.writeln('ERROR: unable to load pana-summary.json, $e');
      }
    }

    // Close the log
    log.writeln(); // always end with a newline
    await log.close();

    // Upload results, if there is any
    _log.info('api.taskUploadResult("$package", "$version")');
    final r = await retry(
      () => api.taskUploadResult(package, version),
      retryIf: _retryIf,
    );

    await Future.wait([
      () async {
        if (!hasDartDoc) {
          return;
        }

        // Upload dartdoc results
        final dartdoc = await BlobIndexPair.folderToIndexedBlob(
          r.dartdocBlobId,
          dartdocDir.path,
        );

        await upload(
          client,
          r.dartdocBlob,
          dartdoc.blob,
          filename: 'dartdoc-data.blob',
        );

        await upload(
          client,
          r.dartdocIndex,
          dartdoc.index.asBytes(),
          filename: 'dartdoc-index.json',
          contentType: 'application/json',
        );
      }(),
      () async {
        // Upload the log
        await upload(
          client,
          r.panaLog,
          await logFile.readAsBytes(),
          filename: 'pana-log.txt',
          contentType: 'text/plain',
        );

        await upload(
          client,
          r.panaReport,
          encodeJson(PanaReport(
            logId: r.panaLogId,
            summary: summary,
          )),
          filename: 'pana-summary.json',
          contentType: 'application/json',
        );
      }(),
    ]);

    // Report that we're done processing the package / version.
    _log.info('api.taskUploadFinished("$package", "$version")');
    await retry(
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

  final r = await retry(
    () => api.taskUploadResult(package, version),
    retryIf: _retryIf,
  );

  // Upload the log
  await upload(
    client,
    r.panaLog,
    utf8.encode([
      '## Skipping analysis for "$package" version "$version"',
      'date-time: ${clock.now().toUtc().toIso8601String()}',
      '',
      'reason:',
      reason,
      '', // always end with a newline
    ].join('\n')),
    filename: 'pana-log.txt',
    contentType: 'text/plain',
  );

  await upload(
    client,
    r.panaReport,
    encodeJson(PanaReport(
      logId: r.panaLogId,
      summary: null, // we have no summary to attach
    )),
    filename: 'pana-summary.json',
    contentType: 'application/json',
  );

  // Report that we're done processing the package / version.
  _log.info('api.taskUploadFinished("$package", "$version") - skipped');
  await retry(
    () => api.taskUploadFinished(package, version),
    retryIf: _retryIf,
  );
}
