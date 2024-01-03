// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:clock/clock.dart';
import 'package:gcloud/storage.dart';
import 'package:pub_dev/package/export_api_to_bucket.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:test/test.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';
import 'backend_test_utils.dart';

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
        await exporter.uploadPkgNameCompletionData();
        await exporter.fullPkgScanAndUpload();

        final claim =
            FakeGlobalLockClaim(clock.now().add(Duration(seconds: 3)));
        await exporter.incrementalPkgScanAndUpload(
          claim,
          sleepDuration: Duration(milliseconds: 300),
        );
        await exporter.deleteObsoleteRuntimeContent();

        final files = await bucket
            .list(delimiter: 'bogus-delimiter-for-full-file-list')
            .map((e) => e.name)
            .toList();
        expect(files.toSet(), {
          '$runtimeVersion/api/package-name-completion-data',
          'current/api/package-name-completion-data',
          '$runtimeVersion/api/packages/flutter_titanium',
          '$runtimeVersion/api/packages/neon',
          '$runtimeVersion/api/packages/oxygen',
          'current/api/packages/flutter_titanium',
          'current/api/packages/neon',
          'current/api/packages/oxygen',
        });

        Future<Object?> readAndDecodeJson(String path) async => json
            .decode(utf8.decode(gzip.decode(await bucket.readAsBytes(path))));

        expect(
          await readAndDecodeJson('current/api/packages/neon'),
          {
            'name': 'neon',
            'latest': isNotEmpty,
            'versions': hasLength(1),
          },
        );

        expect(
          await readAndDecodeJson('current/api/package-name-completion-data'),
          {
            'packages': hasLength(3),
          },
        );
      },
    );

    testWithProfile('new upload', fn: () async {
      await apiExporter!.fullPkgScanAndUpload();

      final bucket =
          storageService.bucket(activeConfiguration.exportedApiBucketName!);
      final originalBytes =
          await bucket.readAsBytes('current/api/packages/oxygen');

      final pubspecContent = generatePubspecYaml('oxygen', '9.0.0');
      final message = await createPubApiClient(authToken: adminClientToken)
          .uploadPackageBytes(
              await packageArchiveBytes(pubspecContent: pubspecContent));
      expect(message.success.message, contains('Successfully uploaded'));

      await Future.delayed(Duration(seconds: 1));
      final updatedBytes =
          await bucket.readAsBytes('current/api/packages/oxygen');
      expect(originalBytes.length, lessThan(updatedBytes.length));
    });
  });
}
