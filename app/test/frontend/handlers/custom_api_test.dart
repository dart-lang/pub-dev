// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/shared/urls.dart' as urls;

import '../../shared/handlers_test_utils.dart';
import '../mocks.dart';
import '../utils.dart';

import '_utils.dart';

void main() {
  group('editor api', () {
    tScopedTest('/api/packages', () async {
      final backend =
          BackendMock(latestPackagesFun: ({offset, limit, detectedType}) {
        expect(offset, 0);
        expect(limit, greaterThan(10));
        return [testPackage];
      }, lookupLatestVersionsFun: (List<Package> packages) {
        expect(packages.length, 1);
        expect(packages.first, testPackage);
        return [testPackageVersion];
      });
      registerBackend(backend);
      await expectJsonResponse(
        await issueGet('/api/packages', host: urls.legacyHost),
        body: {
          'next_url': null,
          'packages': [
            {
              'name': 'foobar_pkg',
              'latest': {
                'version': '0.1.1+5',
                'pubspec': loadYaml(testPackagePubspec),
                'archive_url': 'https://pub.dartlang.org'
                    '/packages/foobar_pkg/versions/0.1.1%2B5.tar.gz',
                'package_url': 'https://pub.dartlang.org'
                    '/api/packages/foobar_pkg',
                'url': 'https://pub.dartlang.org'
                    '/api/packages/foobar_pkg/versions/0.1.1%2B5'
              },
              'url': 'https://pub.dartlang.org/api/packages/foobar_pkg',
              'version_url': 'https://pub.dartlang.org'
                  '/api/packages/foobar_pkg/versions/%7Bversion%7D',
              'new_version_url': 'https://pub.dartlang.org'
                  '/api/packages/foobar_pkg/new',
              'uploaders_url': 'https://pub.dartlang.org'
                  '/api/packages/foobar_pkg/uploaders'
            },
          ],
        },
      );
    });
  });
}
