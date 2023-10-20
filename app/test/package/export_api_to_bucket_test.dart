// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:clock/clock.dart';
import 'package:gcloud/storage.dart';
import 'package:pub_dev/package/export_api_to_bucket.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:test/test.dart';

import '../shared/test_services.dart';

void main() {
  group('export API to bucket', () {
    testWithProfile(
      'export and cleanup',
      fn: () async {
        await storageService.createBucket('bucket');
        final bucket = storageService.bucket('bucket');
        final exporter = ApiExporter(
          bucket: bucket,
          concurrency: 2,
        );
        await exporter.fullScanAndUpload();

        final claim =
            FakeGlobalLockClaim(clock.now().add(Duration(seconds: 3)));
        await exporter.incrementalScanAndUpload(
          claim,
          sleepDuration: Duration(milliseconds: 300),
        );
        await exporter.deleteObsoleteRuntimeContent();

        final files = await bucket
            .list(delimiter: 'bogus-delimiter-for-full-file-list')
            .map((e) => e.name)
            .toList();
        expect(files.toSet(), {
          '$runtimeVersion/api/packages/flutter_titanium',
          '$runtimeVersion/api/packages/neon',
          '$runtimeVersion/api/packages/oxygen',
          'current/api/packages/flutter_titanium',
          'current/api/packages/neon',
          'current/api/packages/oxygen',
        });

        final currentNeon = json.decode(utf8.decode(gzip
            .decode(await bucket.readAsBytes('current/api/packages/neon'))));
        expect(currentNeon, {
          'name': 'neon',
          'latest': isNotEmpty,
          'versions': isNotEmpty,
        });
      },
    );
  });
}
