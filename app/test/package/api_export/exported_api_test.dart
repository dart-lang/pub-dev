// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:_pub_shared/data/package_api.dart';
import 'package:clock/clock.dart';
import 'package:gcloud/storage.dart';
import 'package:googleapis/storage/v1.dart' show DetailedApiRequestError;
import 'package:pub_dev/package/api_export/exported_api.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:test/test.dart';
import '../../shared/test_services.dart';

void main() {
  final retryPkgData1 = PackageData(
    name: 'retry',
    latest: VersionInfo(
      version: '1.2.3',
      retracted: false,
      pubspec: {},
      archiveUrl: '-',
      archiveSha256: '-',
      published: clock.now(),
    ),
    versions: [],
  );

  testWithFakeTime('ExportedApi.garbageCollect()', (fakeTime) async {
    await storageService.createBucket('exported-api');
    final bucket = storageService.bucket('exported-api');
    final exportedApi = ExportedApi(storageService, bucket);

    // Test that deletion works when bucket is empty
    await exportedApi.package('retry').delete();

    // Test that GC works when bucket is empty
    await exportedApi.garbageCollect({});

    await exportedApi.package('retry').versions.write(retryPkgData1);

    expect(
      await bucket.readGzippedJson('latest/api/packages/retry'),
      json.decode(json.encode(retryPkgData1.toJson())),
    );

    // Check that GC after 10 mins won't delete a package we don't recognize
    fakeTime.elapseSync(minutes: 10);
    await exportedApi.garbageCollect({});
    expect(
      await bucket.readGzippedJson('latest/api/packages/retry'),
      isNotNull,
    );

    // Check that GC after 2 days won't delete a package we know
    fakeTime.elapseSync(days: 2);
    await exportedApi.garbageCollect({'retry'});
    expect(
      await bucket.readGzippedJson('latest/api/packages/retry'),
      isNotNull,
    );

    // Check retry after 2 days will delete a package we don't know.
    await exportedApi.garbageCollect({});
    expect(
      await bucket.readGzippedJson('latest/api/packages/retry'),
      isNull,
    );

    // Check that stray files in old-runtimeVersions will be GC'ed
    final oldFiles = [
      '2023.08.10/api/packages/retry',
      '2023.08.10/api/stray-file1',
      '2023.08.10/stray-file2',
    ];
    for (final f in oldFiles) {
      await bucket.writeBytes(f, [0]);
      expect(
        await bucket.readBytes(f),
        isNotNull,
      );
    }

    // Run GC to delete all stray files
    await exportedApi.garbageCollect({});

    for (final f in oldFiles) {
      expect(
        await bucket.readBytes(f),
        isNull,
        reason: 'expected "$f" to be GCed',
      );
    }
  });
}

extension on Bucket {
  /// Read bytes from bucket, retur null if missing
  Future<Uint8List?> readBytes(String path) async {
    try {
      return await readAsBytes(path);
    } on DetailedApiRequestError catch (e) {
      if (e.status == 404) return null;
      rethrow;
    }
  }

  /// Read gzipped JSON from bucket
  Future<Object?> readGzippedJson(String path) async {
    final bytes = await readBytes(path);
    if (bytes == null) {
      return null;
    }
    return utf8JsonDecoder.convert(gzip.decode(bytes));
  }
}
