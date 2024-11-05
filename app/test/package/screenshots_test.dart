// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/package/screenshots/backend.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:test/test.dart';

import '../shared/test_services.dart';

void main() {
  group('image upload', () {
    testWithProfile('succesful upload', fn: () async {
      await imageStorage.upload(
          'new_pkg',
          '1.2.3',
          () => Stream.fromIterable([
                [1],
              ]),
          'image.svg',
          1);

      expect(
          await imageStorage.bucket.read('new_pkg/1.2.3/image.svg').foldBytes(),
          [1]);
    });

    testWithProfile('unsupported file extension', fn: () async {
      final rs = imageStorage.upload(
          'new_pkg',
          '1.2.3',
          () => Stream.fromIterable([
                [1]
              ]),
          'image.txt',
          1);

      await expectLater(
        rs,
        throwsA(
          isA<ArgumentError>().having(
              (e) => '$e', 'text', contains('Failed to upload image file')),
        ),
      );
    });

    testWithProfile('no file extension', fn: () async {
      final rs = imageStorage.upload(
          'new_pkg',
          '1.2.3',
          () => Stream.fromIterable([
                [1]
              ]),
          'image',
          1);

      await expectLater(
        rs,
        throwsA(
          isA<ArgumentError>().having(
              (e) => '$e', 'text', contains('Failed to upload image file')),
        ),
      );
    });
  });
}
