// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/storage.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/package_storage.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/storage.dart';
import 'package:test/test.dart';

import '../shared/test_services.dart';

void main() {
  group('Object names', () {
    testWithProfile('namer', fn: () async {
      await storageService.createBucket('some-pub-bucket');
      final bucket = storageService.bucket('some-pub-bucket');
      expect(bucket.objectUrl('path/file.txt'),
          '${activeConfiguration.storageBaseUrl}/some-pub-bucket/path/file.txt');

      expect((await packageBackend.downloadUrl('oxygen', '1.0.0')).toString(),
          '${activeConfiguration.storageBaseUrl}/fake-public-packages/packages/oxygen-1.0.0.tar.gz');
    });

    test('helper methods', () {
      expect(tarballObjectName('foobar', '0.1.0'),
          equals('packages/foobar-0.1.0.tar.gz'));
      expect(tmpObjectName('guid'), equals('tmp/guid'));
    });
  });
}
