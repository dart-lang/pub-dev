// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:_pub_shared/data/advisories_api.dart';
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

  final retryPkgData2 = PackageData(
    name: 'retry',
    latest: VersionInfo(
      version: '1.2.3',
      retracted: false,
      pubspec: {},
      archiveUrl: '-',
      archiveSha256: '-',
      published: clock.now(),
    ),
    versions: [
      VersionInfo(
        version: '1.2.3',
        retracted: false,
        pubspec: {},
        archiveUrl: '-',
        archiveSha256: '-',
        published: clock.now(),
      )
    ],
  );

  final retryAdvisoryData1 = ListAdvisoriesResponse(
    advisories: [],
  );

  testWithProfile('ExportedApi.package().versions/advisories', fn: () async {
    await storageService.createBucket('exported-api');
    final bucket = storageService.bucket('exported-api');
    final exportedApi = ExportedApi(storageService, bucket);

    // Check that we can write JSON files
    await exportedApi.package('retry').versions.write(retryPkgData1);
    await exportedApi.package('retry').advisories.write(retryAdvisoryData1);

    // Check contents of the files
    expect(
      await bucket.readGzippedJson('latest/api/packages/retry'),
      json.decode(json.encode(retryPkgData1.toJson())),
    );
    expect(
      await bucket.readGzippedJson('latest/api/packages/retry/advisories'),
      json.decode(json.encode(retryAdvisoryData1.toJson())),
    );

    // Check that we can update JSON files
    await exportedApi.package('retry').versions.write(retryPkgData2);
    expect(
      await bucket.readGzippedJson('latest/api/packages/retry'),
      json.decode(json.encode(retryPkgData2.toJson())),
    );

    // CHeck that we can delete files
    await exportedApi.package('retry').versions.delete();
    await exportedApi.package('retry').advisories.delete();
    expect(
      await bucket.readGzippedJson('latest/api/packages/retry'),
      isNull,
    );
    expect(
      await bucket.readGzippedJson('latest/api/packages/retry/advisories'),
      isNull,
    );
  });

  testWithProfile('ExportedApi.package().tarball().write/copyFrom',
      fn: () async {
    await storageService.createBucket('exported-api');
    final bucket = storageService.bucket('exported-api');
    final exportedApi = ExportedApi(storageService, bucket);

    // Check that we can write tarballs
    await exportedApi.package('retry').tarball('1.2.3').write([1, 2, 3]);
    // Check that we can copy tarballs
    await exportedApi.package('retry').tarball('1.2.4').copyFrom(
          SourceObjectInfo.fromObjectInfo(
            bucket,
            await bucket.info('latest/api/archives/retry-1.2.3.tar.gz'),
          ),
        );

    // Check files created
    expect(
      await bucket.readBytes('latest/api/archives/retry-1.2.3.tar.gz'),
      [1, 2, 3],
    );
    expect(
      await bucket.readBytes('latest/api/archives/retry-1.2.4.tar.gz'),
      [1, 2, 3],
    );

    // Check that we can update tarballs, but writing or copying
    await exportedApi.package('retry').tarball('1.2.3').write([1, 2, 4]);
    await exportedApi.package('retry').tarball('1.2.4').copyFrom(
          SourceObjectInfo.fromObjectInfo(
            bucket,
            await bucket.info('latest/api/archives/retry-1.2.3.tar.gz'),
          ),
        );

    // Check files are updated
    expect(
      await bucket.readBytes('latest/api/archives/retry-1.2.3.tar.gz'),
      [1, 2, 4],
    );
    expect(
      await bucket.readBytes('latest/api/archives/retry-1.2.4.tar.gz'),
      [1, 2, 4],
    );

    // Check that we can delete files
    await exportedApi.package('retry').tarball('1.2.3').delete();
    await exportedApi.package('retry').tarball('1.2.4').delete();
    expect(
      await bucket.readBytes('latest/api/archives/retry-1.2.3.tar.gz'),
      isNull,
    );
    expect(
      await bucket.readBytes('latest/api/archives/retry-1.2.4.tar.gz'),
      isNull,
    );
  });

  testWithProfile('ExportedApi.package().tarball() version encoding',
      fn: () async {
    await storageService.createBucket('exported-api');
    final bucket = storageService.bucket('exported-api');
    final exportedApi = ExportedApi(storageService, bucket);

    await exportedApi.package('_foo').tarball('1.2.3').write([1, 2, 3]);
    await exportedApi.package('_foo').tarball('1.2.3-dev+2').copyFrom(
          SourceObjectInfo.fromObjectInfo(
            bucket,
            await bucket.info('latest/api/archives/_foo-1.2.3.tar.gz'),
          ),
        );
    await exportedApi.package('_foo').tarball('1.2.3-d.tar.gz').write([42]);
    await exportedApi.package('_foo').tarball('1.2.3-d+4.tar.gz').write([42]);

    expect(
      await bucket.readBytes('latest/api/archives/_foo-1.2.3.tar.gz'),
      [1, 2, 3],
    );
    expect(
      await bucket.readBytes('latest/api/archives/_foo-1.2.3-dev+2.tar.gz'),
      [1, 2, 3],
    );
    expect(
      await bucket.readBytes('latest/api/archives/_foo-1.2.3-d.tar.gz.tar.gz'),
      [42],
    );
    expect(
      await bucket
          .readBytes('latest/api/archives/_foo-1.2.3-d+4.tar.gz.tar.gz'),
      [42],
    );
  });

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

  testWithFakeTime('ExportedApi.package().synchronizeTarballs()',
      (fakeTime) async {
    await storageService.createBucket('exported-api');
    final bucket = storageService.bucket('exported-api');
    final exportedApi = ExportedApi(storageService, bucket);

    await storageService.createBucket('canonical-packages');
    final canonical = storageService.bucket('canonical-packages');

    final src1 = SourceObjectInfo.fromObjectInfo(
      canonical,
      await canonical.writeBytes('packages/retry-1.0.0.tar.gz', [1, 0, 0]),
    );
    final src2 = SourceObjectInfo.fromObjectInfo(
      canonical,
      await canonical.writeBytes('packages/retry-2.0.0.tar.gz', [2, 0, 0]),
    );
    final src3 = SourceObjectInfo.fromObjectInfo(
      canonical,
      await canonical.writeBytes('packages/retry-3.0.0+1.tar.gz', [3, 0, 0]),
    );

    await exportedApi.package('retry').tarball('1.0.0').copyFrom(src1);
    await exportedApi.package('retry').tarball('1.0.5').copyFrom(src2);

    expect(
      await bucket.readBytes('latest/api/archives/retry-1.0.0.tar.gz'),
      [1, 0, 0],
    );
    expect(
      await bucket.readBytes('latest/api/archives/retry-1.0.5.tar.gz'),
      [2, 0, 0],
    );

    await exportedApi.package('retry').synchronizeTarballs({
      '1.0.0': src1,
      '2.0.0': src2,
      '3.0.0+1': src3,
    });

    expect(
      await bucket.readBytes('latest/api/archives/retry-1.0.0.tar.gz'),
      [1, 0, 0],
    );
    expect(
      await bucket.readBytes('latest/api/archives/retry-1.0.5.tar.gz'),
      [2, 0, 0],
    );
    expect(
      await bucket.readBytes('latest/api/archives/retry-2.0.0.tar.gz'),
      [2, 0, 0],
    );
    expect(
      await bucket.readBytes('latest/api/archives/retry-3.0.0+1.tar.gz'),
      [3, 0, 0],
    );

    fakeTime.elapseSync(days: 2);

    await exportedApi.package('retry').synchronizeTarballs({
      '1.0.0': src1,
      '2.0.0': src2,
      '3.0.0+1': src3,
    });
    expect(
      await bucket.readBytes('latest/api/archives/retry-1.0.0.tar.gz'),
      [1, 0, 0],
    );
    expect(
      await bucket.readBytes('latest/api/archives/retry-1.0.5.tar.gz'),
      isNull,
    );
    expect(
      await bucket.readBytes('latest/api/archives/retry-2.0.0.tar.gz'),
      [2, 0, 0],
    );
    expect(
      await bucket.readBytes('latest/api/archives/retry-3.0.0+1.tar.gz'),
      [3, 0, 0],
    );
  });

  testWithFakeTime('ExportedApi.package().garbageCollect()', (fakeTime) async {
    await storageService.createBucket('exported-api');
    final bucket = storageService.bucket('exported-api');
    final exportedApi = ExportedApi(storageService, bucket);

    await exportedApi.package('retry').tarball('1.2.3').write([1, 2, 3]);

    await exportedApi.package('retry').tarball('1.2.4').copyFrom(
          SourceObjectInfo.fromObjectInfo(
            bucket,
            await bucket.info('latest/api/archives/retry-1.2.3.tar.gz'),
          ),
        );

    // Files are present
    expect(
      await bucket.readBytes('latest/api/archives/retry-1.2.3.tar.gz'),
      [1, 2, 3],
    );
    expect(
      await bucket.readBytes('latest/api/archives/retry-1.2.4.tar.gz'),
      [1, 2, 3],
    );

    // Nothing is GC'ed after 10 mins
    fakeTime.elapseSync(minutes: 10);
    await exportedApi.package('retry').garbageCollect({'1.2.3'});
    expect(
      await bucket.readBytes('latest/api/archives/retry-1.2.3.tar.gz'),
      [1, 2, 3],
    );
    expect(
      await bucket.readBytes('latest/api/archives/retry-1.2.4.tar.gz'),
      [1, 2, 3],
    );

    // Something is GC'ed after 2 days
    fakeTime.elapseSync(days: 2);
    await exportedApi.package('retry').garbageCollect({'1.2.3'});
    expect(
      await bucket.readBytes('latest/api/archives/retry-1.2.3.tar.gz'),
      [1, 2, 3],
    );
    expect(
      await bucket.readBytes('latest/api/archives/retry-1.2.4.tar.gz'),
      isNull,
    );
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
