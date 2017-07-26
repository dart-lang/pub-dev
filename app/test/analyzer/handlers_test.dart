// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers_test;

import 'dart:async';
import 'dart:isolate';

import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:pub_dartlang_org/shared/analyzer_service.dart';

import 'package:pub_dartlang_org/analyzer/backend.dart';
import 'package:pub_dartlang_org/analyzer/models.dart';
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

      scopedTest('/packages/unknown', () async {
        registerAnalysisBackend(new MockAnalysisBackend());
        await expectNotFoundResponse(await issueGet('/packages/unknown'));
      });

      scopedTest('/packages/pkg_foo/unknown', () async {
        registerAnalysisBackend(new MockAnalysisBackend());
        await expectNotFoundResponse(
            await issueGet('/packages/pkg_foo/unknown'));
      });

      scopedTest('/packages/pkg_foo/1.2.3/unknown', () async {
        registerAnalysisBackend(new MockAnalysisBackend());
        await expectNotFoundResponse(
            await issueGet('/packages/pkg_foo/1.2.3/unknown'));
      });

      scopedTest('/packages/pkg_foo/1.2.3/1', () async {
        registerAnalysisBackend(new MockAnalysisBackend());
        await expectNotFoundResponse(
            await issueGet('/packages/pkg_foo/1.2.3/1'));
      });
    });

    group('get analysis', () {
      scopedTest('/packages/pkg_foo', () async {
        registerAnalysisBackend(new MockAnalysisBackend());
        await expectJsonResponse(await issueGet('/packages/pkg_foo'), body: {
          'packageName': 'pkg_foo',
          'packageVersion': '1.2.3',
          'analysis': 242345,
          'timestamp': '2017-06-26T12:48:00.000',
          'panaVersion': '0.2.0',
          'flutterVersion': '0.0.11',
          'analysisStatus': 'success',
          'analysisContent': {'content': 'from-pana'}
        });
      });

      scopedTest('/packages/pkg_foo?only-meta=true', () async {
        registerAnalysisBackend(new MockAnalysisBackend());
        await expectJsonResponse(
            await issueGet('/packages/pkg_foo?only-meta=true'),
            body: {
              'packageName': 'pkg_foo',
              'packageVersion': '1.2.3',
              'analysis': 242345,
              'timestamp': '2017-06-26T12:48:00.000',
              'panaVersion': '0.2.0',
              'flutterVersion': '0.0.11',
              'analysisStatus': 'success',
              'analysisContent': null,
            });
      });

      scopedTest('/packages/pkg_foo/1.2.3', () async {
        registerAnalysisBackend(new MockAnalysisBackend());
        await expectJsonResponse(await issueGet('/packages/pkg_foo/1.2.3'),
            body: {
              'packageName': 'pkg_foo',
              'packageVersion': '1.2.3',
              'analysis': 242345,
              'timestamp': '2017-06-26T12:48:00.000',
              'panaVersion': '0.2.0',
              'flutterVersion': '0.0.11',
              'analysisStatus': 'success',
              'analysisContent': {'content': 'from-pana'}
            });
      });

      scopedTest('/packages/pkg_foo/1.2.3/242345', () async {
        registerAnalysisBackend(new MockAnalysisBackend());
        await expectJsonResponse(
            await issueGet('/packages/pkg_foo/1.2.3/242345'),
            body: {
              'packageName': 'pkg_foo',
              'packageVersion': '1.2.3',
              'analysis': 242345,
              'timestamp': '2017-06-26T12:48:00.000',
              'panaVersion': '0.2.0',
              'flutterVersion': '0.0.11',
              'analysisStatus': 'success',
              'analysisContent': {'content': 'from-pana'}
            });
      });
    });

    group('trigger analysis', () {
      scopedTest('/packages/pkg', () async {
        await expectNotFoundResponse(await issuePost('/packages/pkg'));
      });

      scopedTest('/packages/pkg/1.0.1', () async {
        final ReceivePort rp = new ReceivePort();
        final Future<Task> taskFuture = rp.first;
        registerTaskSendPort(rp.sendPort);
        await expectJsonResponse(await issuePost('/packages/pkg/1.0.1'),
            body: {'status': 'OK'});
        final Task task = await taskFuture;
        expect(task.package, 'pkg');
        expect(task.version, '1.0.1');
        rp.close();
      });
    });
  });
}

class MockAnalysisBackend implements AnalysisBackend {
  final Map<String, Analysis> _map = {};

  MockAnalysisBackend() {
    storeAnalysis(testAnalysis);
  }

  @override
  DatastoreDB get db => throw 'No DB access.';

  @override
  Future<Analysis> getAnalysis(String package,
      [String version, int analysis]) async {
    return _map.values.firstWhere(
        (Analysis a) =>
            (package == a.packageName) &&
            (version == null || a.packageVersion == version) &&
            (analysis == null || a.analysis == analysis),
        orElse: () => null);
  }

  @override
  Future storeAnalysis(Analysis analysis) async {
    final String key = [
      analysis.packageName,
      analysis.packageVersion,
      analysis.analysis,
    ].join('/');
    _map[key] = analysis;
  }

  @override
  Future<bool> isValidTarget(String packageName, String packageVersion) {
    throw 'Not implemented yet.';
  }
}

final Analysis testAnalysis = new Analysis()
  ..packageName = 'pkg_foo'
  ..packageVersion = '1.2.3'
  ..id = 242345
  ..analysisStatus = AnalysisStatus.success
  ..panaVersion = '0.2.0'
  ..flutterVersion = '0.0.11'
  ..timestamp = new DateTime(2017, 06, 26, 12, 48, 00)
  ..analysisJson = {'content': 'from-pana'};
