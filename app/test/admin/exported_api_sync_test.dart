// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/admin_api.dart';
import 'package:gcloud/storage.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:test/test.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('Exported API sync admin action', () {
    /// Invoke exported-api-sync action
    Future<void> syncExportedApi({
      List<String>? packages,
      bool forceWrite = false,
    }) async {
      final api = createPubApiClient(authToken: siteAdminToken);
      await api.adminInvokeAction(
        'exported-api-sync',
        AdminInvokeActionArguments(arguments: {
          'packages': packages?.join(' ') ?? 'ALL',
          if (forceWrite) 'force-write': 'true',
        }),
      );
    }

    /// Return map of all objects in the Exported API bucket.
    ///
    /// Returns a map from object name to JSON on the form:
    /// ```js
    /// {
    ///   'updated': '<date-time>',
    ///   'metadata': {
    ///     'contentType': '<contentType>',
    ///     'custom': {...},
    ///   },
    ///   'length': <length>,
    ///   'bytes': [...],
    /// }
    /// ```
    Future<Map<String, dynamic>> listExportedApi() async {
      final data = <String, dynamic>{};
      final bucket =
          storageService.bucket(activeConfiguration.exportedApiBucketName!);
      await for (final entry in bucket.list(delimiter: '')) {
        if (!entry.isObject) continue;
        final info = await bucket.info(entry.name);
        final bytes = await bucket.readAsBytes(entry.name);
        data[entry.name] = {
          'updated': info.updated.toIso8601String(),
          'metadata': {
            'contentType': info.metadata.contentType,
            'custom': info.metadata.custom,
          },
          'length': bytes.length,
          'bytes': bytes.toList(),
        };
      }
      return data;
    }

    testWithProfile('baseline checks', fn: () async {
      await syncExportedApi();
      final data = await listExportedApi();
      expect(data.keys, hasLength(greaterThan(20)));
      expect(data.keys, hasLength(lessThan(40)));

      final oxygenFiles = data.keys.where((k) => k.contains('oxygen')).toSet();
      expect(oxygenFiles, hasLength(greaterThan(5)));
      expect(oxygenFiles, {
        '$runtimeVersion/api/archives/oxygen-1.0.0.tar.gz',
        '$runtimeVersion/api/archives/oxygen-1.2.0.tar.gz',
        '$runtimeVersion/api/archives/oxygen-2.0.0-dev.tar.gz',
        '$runtimeVersion/api/packages/oxygen',
        '$runtimeVersion/api/packages/oxygen/advisories',
        'latest/api/archives/oxygen-1.0.0.tar.gz',
        'latest/api/archives/oxygen-1.2.0.tar.gz',
        'latest/api/archives/oxygen-2.0.0-dev.tar.gz',
        'latest/api/packages/oxygen',
        'latest/api/packages/oxygen/advisories',
      });

      final oxygenDataJson = data['latest/api/packages/oxygen'];
      expect(oxygenDataJson, {
        'updated': isNotEmpty,
        'metadata': {
          'contentType': 'application/json; charset="utf-8"',
          'custom': {
            'validated': isNotEmpty,
          },
        },
        'length': greaterThan(100),
        'bytes': isNotEmpty,
      });
    });

    testWithProfile('deleted files + full sync', expectedLogMessages: [
      // TODO: review why we have unhandled errors here
      RegExp(r'^SEVERE Unhandled error in API handler \(incidentId: .*\)'),
    ], fn: () async {
      await syncExportedApi();
      final oldRoot = await listExportedApi();

      for (final e in oldRoot.entries) {
        final path = e.key;
        final oldData = e.value as Map;

        final bucket =
            storageService.bucket(activeConfiguration.exportedApiBucketName!);
        await bucket.delete(path);

        await syncExportedApi();
        final newRoot = await listExportedApi();
        expect(newRoot.containsKey(path), true);
        final newData = newRoot[path] as Map;
        expect(oldData['bytes'], isNotEmpty);
        expect(oldData['bytes'], newData['bytes']);
      }
    });

    testWithProfile('delete files + selective sync', fn: () async {
      await syncExportedApi();
      final oldRoot = await listExportedApi();

      final oxygenFiles =
          oldRoot.keys.where((k) => k.contains('oxygen')).toList();
      expect(oxygenFiles, hasLength(greaterThan(5)));

      for (final path in oxygenFiles) {
        final bucket =
            storageService.bucket(activeConfiguration.exportedApiBucketName!);
        await bucket.delete(path);

        await syncExportedApi(packages: ['neon']);
        expect(await bucket.tryInfo(path), isNull);

        await syncExportedApi(packages: ['oxygen']);
        expect(await bucket.tryInfo(path), isNotNull);
      }
    });

    testWithProfile('modified files + selective sync', fn: () async {
      await syncExportedApi();
      final oldRoot = await listExportedApi();

      final oxygenFiles =
          oldRoot.keys.where((k) => k.contains('oxygen')).toList();
      expect(oxygenFiles, hasLength(greaterThan(5)));

      for (final path in oxygenFiles) {
        final oldData = oldRoot[path] as Map;
        final bucket =
            storageService.bucket(activeConfiguration.exportedApiBucketName!);
        await bucket.writeBytes(path, [1]);

        await syncExportedApi(packages: ['neon']);
        expect((await bucket.info(path)).length, 1);

        await syncExportedApi(packages: ['oxygen']);
        expect((await bucket.info(path)).length, greaterThan(1));

        // also check file content
        final newRoot = await listExportedApi();
        final newData = newRoot[path] as Map;
        expect(newData['length'], greaterThan(1));
        expect(oldData['bytes'], newData['bytes']);
      }
    });

    testWithProfile('modified metadata + selective sync', fn: () async {
      await syncExportedApi();
      final oldRoot = await listExportedApi();

      final oxygenFiles =
          oldRoot.keys.where((k) => k.contains('oxygen')).toList();
      expect(oxygenFiles, hasLength(greaterThan(5)));

      for (final path in oxygenFiles) {
        final oldData = oldRoot[path] as Map;
        final bucket =
            storageService.bucket(activeConfiguration.exportedApiBucketName!);
        await bucket.updateMetadataWithRetry(
          path,
          ObjectMetadata(
            contentType: 'text/plain',
            custom: {'x': 'x'},
          ),
        );

        await syncExportedApi(packages: ['neon']);
        expect((await bucket.info(path)).metadata.custom, {'x': 'x'});

        await syncExportedApi(packages: ['oxygen']);
        final newInfo = await bucket.info(path);
        expect(
            newInfo.metadata.contentType, oldData['metadata']['contentType']);
        expect(newInfo.metadata.custom, {'validated': isNotEmpty});

        // also check file content
        final newRoot = await listExportedApi();
        final newData = newRoot[path] as Map;
        expect(newData['length'], greaterThan(1));
        expect(oldData['bytes'], newData['bytes']);
      }
    });
  });
}
