// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers_test;

import 'dart:async';
import 'dart:isolate';

import 'package:pub_dartlang_org/shared/search_service.dart';
import 'package:test/test.dart';

import 'package:pub_dartlang_org/search/backend.dart';
import 'package:pub_dartlang_org/search/index_ducene.dart';
import 'package:pub_dartlang_org/shared/task_client.dart';
import 'package:pub_dartlang_org/shared/task_scheduler.dart' show Task;

import '../shared/handlers_test_utils.dart';
import '../shared/utils.dart';

import 'handlers_test_utils.dart';

void main() {
  group('handlers', () {
    group('not found', () {
      scopedTest('/xxx', () async {
        await expectNotFoundResponse(await issueGet('/xxx'));
      });
      scopedTest('/packages', () async {
        await expectNotFoundResponse(await issueGet('/packages'));
      });

      scopedTest('/packages/pkg_foo', () async {
        registerSearchBackend(new MockSearchBackend());
        await expectNotFoundResponse(await issueGet('/packages/unknown'));
      });
    });

    group('trigger analysis', () {
      scopedTest('/packages/pkg_foo', () async {
        final ReceivePort rp = new ReceivePort();
        final Future<Task> taskFuture = rp.first;
        registerTaskSendPort(rp.sendPort);
        await expectJsonResponse(await issuePost('/packages/pkg_foo'),
            body: {'success': true});
        final Task task = await taskFuture;
        expect(task.package, 'pkg_foo');
        expect(task.version, isNull);
        rp.close();
      });
    });

    group('search', () {
      scopedTest('/search?q=json', () async {
        registerSearchBackend(new MockSearchBackend());
        registerPackageIndex(new DucenePackageIndex());
        await packageIndex
            .addAll(await searchBackend.loadDocuments(['pkg_foo']));
        await packageIndex.merge();
        expectJsonResponse(await issueGet('/search?q=json'), body: {
          'indexUpdated': isNotNull,
          'totalCount': 1,
          'packages': [
            {
              'url': 'https://pub.domain/packages/pkg_foo',
              'package': 'pkg_foo',
              'version': '1.0.1',
              'devVersion': '1.0.1-dev',
              'score': closeTo(48.0, 0.001),
            }
          ]
        });
      });
    });
  });
}

class MockSearchBackend implements SearchBackend {
  List<String> packages = ['pkg_foo'];

  @override
  Stream<String> listPackages({DateTime updatedAfter}) {
    return new Stream.fromIterable(packages);
  }

  @override
  Future<List<PackageDocument>> loadDocuments(List<String> packages) async {
    return packages.map((String package) {
      return new PackageDocument(
        url: 'https://pub.domain/packages/$package',
        package: package,
        version: '1.0.1',
        devVersion: '1.0.1-dev',
        detectedTypes: ['browser'],
        description: 'Foo package about nothing really. Maybe JSON.',
        readme: 'Some JSON to XML mapping.',
        popularity: 0.1,
      );
    }).toList();
  }
}
