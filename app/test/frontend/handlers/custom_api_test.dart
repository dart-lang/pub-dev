// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dev/shared/urls.dart' as urls;

import '../../shared/handlers_test_utils.dart';
import '../../shared/test_services.dart';

import '_utils.dart';

void main() {
  group('editor api', () {
    testWithProfile('/api/packages', fn: () async {
      await expectJsonResponse(
        await issueGet('/api/packages', host: urls.legacyHost),
        body: {
          'next_url': null,
          'packages': [
            {
              'name': 'oxygen',
              'latest': {
                'version': '1.2.0',
                'pubspec': {
                  'name': 'oxygen',
                  'version': '1.2.0',
                  'description': 'oxygen is awesome',
                  'homepage': 'https://oxygen.example.dev/',
                  'environment': {'sdk': '>=2.6.0 <3.0.0'},
                  'dependencies': {}
                },
                'archive_url':
                    'https://pub.dartlang.org/packages/oxygen/versions/1.2.0.tar.gz',
                'package_url': 'https://pub.dartlang.org/api/packages/oxygen',
                'url':
                    'https://pub.dartlang.org/api/packages/oxygen/versions/1.2.0'
              }
            },
            {
              'name': 'flutter_titanium',
              'latest': {
                'version': '1.10.0',
                'pubspec': {
                  'name': 'flutter_titanium',
                  'version': '1.10.0',
                  'description': 'flutter_titanium is awesome',
                  'homepage': 'https://flutter_titanium.example.dev/',
                  'environment': {'sdk': '>=2.6.0 <3.0.0'},
                  'dependencies': {
                    'flutter': {'sdk': 'flutter'}
                  }
                },
                'archive_url':
                    'https://pub.dartlang.org/packages/flutter_titanium/versions/1.10.0.tar.gz',
                'package_url':
                    'https://pub.dartlang.org/api/packages/flutter_titanium',
                'url':
                    'https://pub.dartlang.org/api/packages/flutter_titanium/versions/1.10.0'
              }
            },
            {
              'name': 'neon',
              'latest': {
                'version': '1.0.0',
                'pubspec': {
                  'name': 'neon',
                  'version': '1.0.0',
                  'description': 'neon is awesome',
                  'homepage': 'https://neon.example.dev/',
                  'environment': {'sdk': '>=2.6.0 <3.0.0'},
                  'dependencies': {}
                },
                'archive_url':
                    'https://pub.dartlang.org/packages/neon/versions/1.0.0.tar.gz',
                'package_url': 'https://pub.dartlang.org/api/packages/neon',
                'url':
                    'https://pub.dartlang.org/api/packages/neon/versions/1.0.0'
              }
            }
          ]
        },
      );
    });

    testWithProfile('/api/package-names', fn: () async {
      await expectJsonResponse(
        await issueGet('/api/package-names'),
        body: {
          'packages': containsAll([
            'neon',
            'oxygen',
          ]),
          'nextUrl': null,
        },
      );
    });
  });
}
