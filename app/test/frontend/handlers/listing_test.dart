// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/frontend/backend.dart';
import 'package:pub_dartlang_org/frontend/models.dart';

import '../../shared/handlers_test_utils.dart';
import '../../shared/utils.dart';
import '../mocks.dart';
import '../utils.dart';

import '_utils.dart';

void main() {
  group('old api', () {
    scopedTest('/packages.json', () async {
      final backend =
          new BackendMock(latestPackagesFun: ({offset, limit, detectedType}) {
        expect(offset, 0);
        expect(limit, greaterThan(pageSize));
        return [testPackage];
      }, lookupLatestVersionsFun: (List<Package> packages) {
        expect(packages.length, 1);
        expect(packages.first, testPackage);
        return [testPackageVersion];
      });
      registerBackend(backend);
      await expectJsonResponse(await issueGet('/packages.json'), body: {
        'packages': ['https://pub.dartlang.org/packages/foobar_pkg.json'],
        'next': null
      });
    });

    tScopedTest('/packages/foobar_pkg.json', () async {
      final backend = new BackendMock(lookupPackageFun: (String package) {
        expect(package, 'foobar_pkg');
        return testPackage;
      }, versionsOfPackageFun: (String package) {
        expect(package, 'foobar_pkg');
        return [testPackageVersion];
      });
      registerBackend(backend);
      await expectJsonResponse(await issueGet('/packages/foobar_pkg.json'),
          body: {
            'name': 'foobar_pkg',
            'uploaders': ['hans@juergen.com'],
            'versions': ['0.1.1+5'],
          });
    });
  });
}
