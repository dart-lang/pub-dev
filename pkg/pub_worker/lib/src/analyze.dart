// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert' show JsonUtf8Encoder, json;
import 'dart:io' show Directory, File, Process, Platform, ProcessSignal;
import 'dart:isolate' show Isolate;

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

final _log = Logger('pub_worker.process_payload');

const _analysisTimeout = Duration(minutes: 15);

List<int> encodeJson(Object json) => JsonUtf8Encoder().convert(json);

Future<void> analyze(Payload payload) async {
  _log.fine('Running analyze for payload with package:${payload.package}');
  final client = Client();
  try {
    for (final p in payload.versions) {
      final api = PubApiClient(
        // Documentation says [payload.callback] should not end with a slash,
        // but server has no out-going validation. So let's just be defensive
        // and strip trailing slashes for good measure.
        stripTrailingSlashes(payload.callback),
        client: client.withAuthorization(() => p.token),
      );

      try {
        await _analyzePackage(client, api, payload.package, p.version);
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
  _log.fine('Running analyze for $package / $version');

  final tempDir = await Directory.systemTemp.createTemp('pub_worker-');
  try {
    final logFile = File(p.join(tempDir.path, 'log.txt'));
    final log = logFile.openWrite();

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
    await log.close();

    // Upload results, if there is any
    _log.finest('api.taskUploadResult("$package", "$version")');
    final r = await api.taskUploadResult(package, version);

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
    _log.finest('api.taskUploadFinished("$package", "$version")');
    await api.taskUploadFinished(package, version);
  } finally {
    await tempDir.delete(recursive: true);
  }
}
