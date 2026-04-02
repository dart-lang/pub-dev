// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:fake_gcloud/mem_storage.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:test/test.dart';

import '../shared/utils.dart';

void main() {
  group('snapshot upload and access', () {
    scopedTest('Both files are written', () async {
      final bucket = MemStorage(buckets: ['test']).bucket('test');
      final storage = VersionedJsonStorage(bucket, 'test/');
      await storage.uploadDataAsJsonMap({'data': 1});
      final list = await bucket.list(prefix: 'test/').toList();
      expect(list.map((l) => l.name).toSet(), {
        'test/$runtimeVersion.json.gz',
        'test/$runtimeVersion.tar.gz',
      });

      final info = await bucket.info('test/$runtimeVersion.tar.gz');
      expect(info.length, 103);

      expect(await storage.getContentAsJsonMap(), {'data': 1});
      expect(await storage.getContentAsJsonMapFromTarGz(), {'data': 1});
    });
  });
}
