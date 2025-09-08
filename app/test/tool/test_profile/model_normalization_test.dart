// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:pub_dev/tool/test_profile/normalizer.dart';
import 'package:test/test.dart';

void main() {
  group('normalization tests', () {
    test('a package with a publisher', () {
      expect(
        normalize(
          TestProfile.fromYaml('''
defaultUser: user@domain.com
generatedPackages:
  - name: foo
    publisher: example.com
    versions: ['1.0.0', '2.0.0']
'''),
        ).toJson(),
        {
          'importedPackages': [],
          'generatedPackages': [
            {
              'name': 'foo',
              'publisher': 'example.com',
              'versions': [
                {'version': '1.0.0'},
                {'version': '2.0.0'},
              ],
            },
          ],
          'publishers': [
            {
              'name': 'example.com',
              'members': [
                {'email': 'user@domain.com', 'role': 'admin'},
              ],
            },
          ],
          'users': [
            {'email': 'user@domain.com', 'likes': []},
          ],
          'defaultUser': 'user@domain.com',
        },
      );
    });

    test('a package without publisher', () {
      expect(
        normalize(
          TestProfile.fromYaml('''
defaultUser: user@domain.com
generatedPackages:
  - name: foo
    versions: ['1.0.0', '2.0.0']
'''),
        ).toJson(),
        {
          'importedPackages': [],
          'generatedPackages': [
            {
              'name': 'foo',
              'versions': [
                {'version': '1.0.0'},
                {'version': '2.0.0'},
              ],
            },
          ],
          'publishers': [],
          'users': [
            {'email': 'user@domain.com', 'likes': []},
          ],
          'defaultUser': 'user@domain.com',
        },
      );
    });
  });
}
