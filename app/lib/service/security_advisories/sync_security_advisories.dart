// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:_pub_shared/data/advisories_api.dart';
import 'package:clock/clock.dart';
import 'package:gcloud/storage.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as path;
import 'package:pub_dev/service/security_advisories/backend.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:pub_dev/shared/utils.dart';

/// Loads security advisories from osv.dev into [targetDir].
Future<void> fetchAdvisories(Directory targetDir) async {
  final bucketName = 'osv-vulnerabilities';
  final allPubAdvisoriesPath = 'Pub/all.zip';
  final storage = Storage(Client(), 'project');
  final bucket = storage.bucket(bucketName);
  final zipFile = File(path.join(targetDir.path, 'all.zip'));

  final bytes = await bucket.readAsBytes(allPubAdvisoriesPath);
  zipFile.writeAsBytesSync(bytes);

  ProcessResult processResult;
  processResult = await Process.run('unzip', [zipFile.path],
      workingDirectory: targetDir.path);

  if (processResult.exitCode != 0) {
    throw Exception(
        'Unzipping advisories failed with exitcode ${processResult.exitCode}.\n'
        '${processResult.stdout}\n${processResult.stderr}');
  }
}

Future<(Map<String, OSV>, List<String>)> loadAdvisoriesFromDir(
    Directory advisoriesDir) async {
  final osvs = <String, OSV>{};
  final failedFiles = <String>[];

  await advisoriesDir.list().forEach((advisory) async {
    if (advisory.path.endsWith('json')) {
      OSV osv;
      try {
        final file = File(advisory.path).readAsBytesSync();
        final decoded = utf8JsonDecoder.convert(file) as Map<String, dynamic>;
        osv = OSV.fromJson(decoded);
      } catch (e) {
        failedFiles.add(advisory.path);
        return;
      }
      osvs[osv.id] = osv;
    }
  });
  return (osvs, failedFiles);
}

Future<void> updateAdvisories(Map<String, OSV> osvs) async {
  final syncTime = clock.now();

  final oldAdvisories = await securityAdvisoryBackend.listAdvisories();

  for (final advisory in oldAdvisories) {
    if (!osvs.containsKey(advisory.id)) {
      await securityAdvisoryBackend.deleteAdvisory(advisory, syncTime);
    }
  }

  for (final osv in osvs.values) {
    await securityAdvisoryBackend.ingestSecurityAdvisory(osv, syncTime);
  }
}

/// Synchronizes the security advisory backend with security advisories from
/// osv.dev.
Future<void> syncSecurityAdvisories() async {
  final tempDir = await Directory.systemTemp.createTemp();
  try {
    await fetchAdvisories(tempDir);
    final (osvs, failedFiles) = await loadAdvisoriesFromDir(tempDir);
    await updateAdvisories(osvs);

    if (failedFiles.isNotEmpty) {
      throw Exception(
          'Advisory ingestion was partial. The following advisories failed '
          '$failedFiles');
    }
  } finally {
    await tempDir.delete(recursive: true);
  }
}
