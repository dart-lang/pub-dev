// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import 'package:pub_dev/shared/urls.dart' as urls;

import '../../shared/handlers_test_utils.dart';
import '../../shared/test_models.dart';
import '../../shared/test_services.dart';

import '_utils.dart';

void main() {
  group('editor api', () {
    testWithServices('/api/packages', () async {
      await expectJsonResponse(
        await issueGet('/api/packages', host: urls.legacyHost),
        body: {
          'next_url': null,
          'packages': [
            {
              'name': 'foobar_pkg',
              'latest': {
                'version': '0.1.1+5',
                'pubspec': loadYaml(foobarStablePubspec),
                'archive_url': 'https://pub.dartlang.org'
                    '/packages/foobar_pkg/versions/0.1.1%2B5.tar.gz',
                'package_url': 'https://pub.dartlang.org'
                    '/api/packages/foobar_pkg',
                'url': 'https://pub.dartlang.org'
                    '/api/packages/foobar_pkg/versions/0.1.1%2B5'
              },
            },
            {
              'name': 'lithium',
              'latest': {
                'version': '5.8.6',
                'pubspec': {
                  'homepage': 'https://example.com/lithium',
                  'environment': {'sdk': '>=2.4.0 <3.0.0'},
                  'version': '5.8.6',
                  'name': 'lithium',
                  'author': 'hans@juergen.com',
                  'description': 'lithium is a Dart package'
                },
                'archive_url':
                    'https://pub.dartlang.org/packages/lithium/versions/5.8.6.tar.gz',
                'package_url': 'https://pub.dartlang.org/api/packages/lithium',
                'url':
                    'https://pub.dartlang.org/api/packages/lithium/versions/5.8.6'
              }
            },
            {
              'name': 'helium',
              'latest': {
                'version': '2.0.5',
                'pubspec': {
                  'homepage': 'https://example.com/helium',
                  'environment': {'sdk': '>=2.4.0 <3.0.0'},
                  'version': '2.0.5',
                  'name': 'helium',
                  'author': 'hans@juergen.com',
                  'flutter': {
                    'plugin': {'class': 'SomeClass'}
                  },
                  'description': 'helium is a Dart package'
                },
                'archive_url':
                    'https://pub.dartlang.org/packages/helium/versions/2.0.5.tar.gz',
                'package_url': 'https://pub.dartlang.org/api/packages/helium',
                'url':
                    'https://pub.dartlang.org/api/packages/helium/versions/2.0.5'
              }
            },
            {
              'name': 'hydrogen',
              'latest': {
                'version': '2.0.8',
                'pubspec': {
                  'homepage': 'https://example.com/hydrogen',
                  'environment': {'sdk': '>=2.4.0 <3.0.0'},
                  'version': '2.0.8',
                  'name': 'hydrogen',
                  'author': 'hans@juergen.com',
                  'description': 'hydrogen is a Dart package'
                },
                'archive_url':
                    'https://pub.dartlang.org/packages/hydrogen/versions/2.0.8.tar.gz',
                'package_url': 'https://pub.dartlang.org/api/packages/hydrogen',
                'url':
                    'https://pub.dartlang.org/api/packages/hydrogen/versions/2.0.8'
              }
            },
          ],
        },
      );
    });
  });
}
