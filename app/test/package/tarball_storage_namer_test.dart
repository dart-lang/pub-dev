// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.tarball_storage_namer_test;

import 'package:test/test.dart';

import 'package:pub_dev/package/backend.dart';

void main() {
  group('tarball_storage_namer', () {
    final bucket = 'pub.dartlang.org';

    test('empty namespace', () {
      for (var namespace in [null, '']) {
        final namer = TarballStorageNamer(
            'https://storage.googleapis.com', bucket, namespace);
        expect(namer.bucket, equals(bucket));
        expect(namer.namespace, equals(''));
        expect(namer.prefix, equals(''));
        expect(namer.tarballObjectName('foobar', '0.1.0'),
            equals('packages/foobar-0.1.0.tar.gz'));
        expect(namer.tmpObjectName('guid'), equals('tmp/guid'));
        expect(
            namer.tarballObjectUrl('foobar', '0.1.0'),
            equals('https://storage.googleapis.com/'
                '$bucket/packages/foobar-0.1.0.tar.gz'));
      }
    });

    test('staging namespace', () {
      final namer = TarballStorageNamer(
          'https://storage.googleapis.com', bucket, 'staging');
      expect(namer.bucket, equals(bucket));
      expect(namer.namespace, equals('staging'));
      expect(namer.prefix, equals('ns/staging/'));
      expect(namer.tarballObjectName('foobar', '0.1.0'),
          equals('ns/staging/packages/foobar-0.1.0.tar.gz'));
      expect(namer.tmpObjectName('guid'), equals('tmp/guid'));
      expect(
          namer.tarballObjectUrl('foobar', '0.1.0'),
          equals('https://storage.googleapis.com/'
              '$bucket/ns/staging/packages/foobar-0.1.0.tar.gz'));
    });
  });
}
