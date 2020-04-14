// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:test/test.dart';

import 'package:pub_dev/tool/mirror/mirror_config.dart';

void main() {
  group('normalization tests', () {
    test('only a publisher', () {
      expect(
        MirrorConfig.fromYaml(
          '''
defaultUser: user@domain.com
publishers:
  - name: example.com
    packages:
      - name: foo
        versions: ['1.0.0', '2.0.0']
''',
          normalize: true,
        ).toJson(),
        {
          'packages': [
            {
              'name': 'foo',
              'publisher': 'example.com',
              'versions': ['1.0.0', '2.0.0']
            }
          ],
          'publishers': [
            {
              'name': 'example.com',
              'members': [
                {'email': 'user@domain.com', 'role': 'admin'}
              ]
            }
          ],
          'users': [
            {'email': 'user@domain.com'}
          ],
          'defaultUser': 'user@domain.com'
        },
      );
    });

    test('only a package', () {
      expect(
        MirrorConfig.fromYaml(
          '''
defaultUser: user@domain.com
packages:
  - name: foo
    publisher: example.com
    versions: ['1.0.0', '2.0.0']
''',
          normalize: true,
        ).toJson(),
        {
          'packages': [
            {
              'name': 'foo',
              'publisher': 'example.com',
              'versions': ['1.0.0', '2.0.0']
            }
          ],
          'publishers': [
            {
              'name': 'example.com',
              'members': [
                {'email': 'user@domain.com', 'role': 'admin'}
              ]
            }
          ],
          'users': [
            {'email': 'user@domain.com'}
          ],
          'defaultUser': 'user@domain.com'
        },
      );
    });
  });
}
