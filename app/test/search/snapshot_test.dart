// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:fake_gcloud/mem_storage.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:pub_dev/shared/utils.dart' show jsonUtf8Encoder;
import 'package:pub_dev/shared/versions.dart';
import 'package:test/test.dart';

import '../shared/utils.dart';

void main() {
  group('snapshot upload and access', () {
    scopedTest('Only the .tar.gz file is written', () async {
      final bucket = MemStorage(buckets: ['test']).bucket('test');
      final storage = VersionedJsonStorage(bucket, 'test/');
      await storage.uploadDataAsJsonMap({'data': 1});
      final list = await bucket.list(prefix: 'test/').toList();
      expect(list.map((l) => l.name).toSet(), {'test/$runtimeVersion.tar.gz'});

      final info = await bucket.info('test/$runtimeVersion.tar.gz');
      expect(info.length, 103);

      expect(await storage.getContentAsJsonMapFromTarGz(), {'data': 1});
    });

    scopedTest(
      'large map round-trips correctly through chunked upload',
      () async {
        final bucket = MemStorage(buckets: ['test']).bucket('test');
        final storage = VersionedJsonStorage(bucket, 'test/');
        final largeMap = {
          'updated': '2026-09-03T12:00:00.000Z',
          'documents': {
            for (var i = 0; i < 500; i++)
              'pkg_$i': {
                'package': 'pkg_$i',
                'description': 'description for package $i',
                'tags': ['sdk:dart', 'is:null-safe'],
                'version': '1.0.$i',
              },
          },
        };

        await storage.uploadDataAsJsonMap(largeMap);
        final restored = await storage.getContentAsJsonMapFromTarGz();
        expect(restored, equals(largeMap));
      },
    );

    test(
      'chunkedJsonUtf8Encode produces identical bytes to jsonUtf8Encoder',
      () async {
        final largeMap = {
          'updated': '2026-09-03T12:00:00.000Z',
          'documents': {
            for (var i = 0; i < 250; i++)
              'pkg_$i': {
                'package': 'pkg_$i',
                'description': 'description for package $i',
                'tags': ['sdk:dart'],
              },
          },
        };

        final expectedBytes = jsonUtf8Encoder.convert(largeMap);
        final chunks = await chunkedJsonUtf8Encode(
          largeMap,
          batchSize: 50,
        ).toList();
        expect(chunks.length, greaterThan(1));

        final actualBytes = chunks.expand((c) => c).toList();
        expect(actualBytes, equals(expectedBytes));
      },
    );
  });
}
