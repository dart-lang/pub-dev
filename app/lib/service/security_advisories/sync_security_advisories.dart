// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'dart:typed_data';

import 'package:_pub_shared/data/advisories_api.dart';
import 'package:clock/clock.dart';
import 'package:gcloud/storage.dart';
import 'package:pub_dev/service/security_advisories/backend.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:retry/retry.dart';
import 'package:unzip/unzip.dart';

Future<(Map<String, OSV>, List<String>)> loadAdvisoriesFromDir(
  Directory advisoriesDir,
) async {
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

Future<T> _retry<T>(Future<T> Function() fn) async {
  return await retry(fn);
}

/// Creates the `osv-vulnerabilities` bucket in the active storage service for testing.
Future<void> createOsvBucketWithretryAsyncForTesting() async {
  await _retry(() => storageService.createBucket('osv-vulnerabilities'));
}

/// Exposes the `osv-vulnerabilities` bucket for testing purposes.
Bucket getOsvBucketForTesting() => storageService.bucket('osv-vulnerabilities');

/// Synchronizes the security advisory backend with security advisories from
/// osv.dev, overwriting existing advisories with the same id, if the fetched
/// advisories are newer.
Future<void> syncSecurityAdvisories() async {
  final uri = Uri.parse('gs://osv-vulnerabilities/Pub/all.zip');
  final bucketName = uri.host;
  final allPubAdvisoriesPath = uri.path.substring(1);

  final bucket = storageService.bucket(bucketName);
  final bytes = await bucket.readAsBytes(allPubAdvisoriesPath);
  final zipReader = await ZipReader.fromBytes(Uint8List.fromList(bytes));

  int totalUncompressedSize = 0;
  final maxTotalSize = 100 * 1024 * 1024; // 100 MB
  final maxFileSize = 10 * 1024 * 1024; // 10 MB

  final osvs = <String, OSV>{};
  final failedFiles = <String>[];

  try {
    for (final f in zipReader.files) {
      if (!f.header.name.endsWith('.json')) continue;

      final usize = f.header.uncompressedSize64;
      totalUncompressedSize += usize;

      if (usize > maxFileSize) {
        throw Exception('File ${f.header.name} exceeds maximum allowed size');
      }
      if (totalUncompressedSize > maxTotalSize) {
        throw Exception('Archive exceeds maximum total uncompressed size');
      }

      try {
        final bytesBuilder = BytesBuilder();
        await for (final b in f.read()) {
          bytesBuilder.add(b);
        }
        final decoded =
            utf8JsonDecoder.convert(bytesBuilder.takeBytes())
                as Map<String, Object?>;
        final osv = OSV.fromJson(decoded);
        osvs[osv.id] = osv;
      } catch (e) {
        failedFiles.add(f.header.name);
      }
    }
  } finally {
    await zipReader.close();
  }

  await updateAdvisories(osvs);

  if (failedFiles.isNotEmpty) {
    throw Exception(
      'Advisory ingestion was partial. The following advisories failed '
      '$failedFiles',
    );
  }
}
