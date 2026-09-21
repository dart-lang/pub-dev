// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:fake_gcloud/mem_storage.dart';
import 'package:pub_dev/shared/storage.dart';
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
      expect(info.length, greaterThan(0));

      expect(await storage.getContentAsJsonMapFromTarGz(), {'data': 1});
    });

    scopedTest('Round-trips a payload spanning many encoder chunks', () async {
      // Exceeds the 64 KiB chunk size used when encoding snapshots to disk.
      final random = Random(123);
      final map = {
        for (var i = 0; i < 20000; i++)
          'key-$i': {
            'index': i,
            'value': random.nextDouble(),
            'text': 'padding-${random.nextInt(1 << 32)}',
          },
      };

      final bucket = MemStorage(buckets: ['test']).bucket('test');
      final storage = VersionedJsonStorage(bucket, 'test/');
      await storage.uploadDataAsJsonMap(map);

      final info = await bucket.info('test/$runtimeVersion.tar.gz');
      expect(info.length, greaterThan(64 * 1024));

      expect(await storage.getContentAsJsonMapFromTarGz(), map);
    });
  });
}
