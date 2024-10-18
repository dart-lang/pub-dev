// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:_pub_shared/data/package_api.dart';
import 'package:gcloud/storage.dart';
import 'package:googleapis/storage/v1.dart' show DetailedApiRequestError;
import 'package:pub_dev/package/api_export/exported_api.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:test/test.dart';
import '../../shared/test_services.dart';

void main() {
  testWithFakeTime('ExportedApi', (fakeTime) async {
    await storageService.createBucket('exported-api');
    final bucket = storageService.bucket('exported-api');

    /// Read bytes from bucket
    Future<Uint8List?> readBytes(String path) async {
      try {
        return await bucket.readAsBytes(path);
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

    final exportedApi = ExportedApi(storageService, bucket);

    // Test that deletion works when bucket is empty
    await exportedApi.package('retry').delete();

    // Test that GC works when bucket is empty
    await exportedApi.garbageCollect({});

    final retryPkgData1 = PackageData(
      name: 'retry',
      latest: VersionInfo(
        version: '1.2.3',
        retracted: false,
        pubspec: {},
        archiveUrl: '-',
        archiveSha256: '-',
        published: DateTime.now(),
      ),
      versions: [],
    );

    await exportedApi.package('retry').versions.write(retryPkgData1);

    expect(
      await readGzippedJson('latest/api/packages/retry'),
      json.decode(json.encode(retryPkgData1.toJson())),
    );

    // Check that GC after 10 mins won't delete a package we don't recognize
    fakeTime.elapseSync(minutes: 10);
    await exportedApi.garbageCollect({});
    expect(
      await readGzippedJson('latest/api/packages/retry'),
      isNotNull,
    );

    // Check that GC after 2 days won't delete a package we know
    fakeTime.elapseSync(days: 2);
    await exportedApi.garbageCollect({'retry'});
    expect(
      await readGzippedJson('latest/api/packages/retry'),
      isNotNull,
    );

    // Check retry after 2 days will delete a package we don't know.
    await exportedApi.garbageCollect({});
    expect(
      await readGzippedJson('latest/api/packages/retry'),
      isNull,
    );
  });
}
