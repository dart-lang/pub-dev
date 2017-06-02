// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';

import 'package:pub_dartlang_org/analyzer.dart';

void main() {
  group('Analysis', () {
    group('async-1.13.3', () {
      Analyzer analyzer;

      setUpAll(() async {
        analyzer = new Analyzer('test/analyzer_assets/async-1.13.3.tar.gz');
        await analyzer.setUp();
        await analyzer.analyzeAll();
      });

      tearDownAll(() async {
        await analyzer?.tearDown();
      });

      test('pubspec.yaml', () async {
        expect(analyzer.pubspec, isNotNull);
        expect(analyzer.pubspec.name, 'async');
        expect(analyzer.pubspec.version, '1.13.3');
      });

      // I expect this test to fail eventually, because the resolved versions
      // will differ.
      // TODO: fix test to be robust on the resolved versions
      test('pubspec.lock', () async {
        expect(analyzer.pubspecLock, isNotNull);
        expect(analyzer.pubspecLock.packages, hasLength(47));
        expect(
            analyzer.pubspecLock.packages[0],
            new LockedDependency(
              key: 'analyzer',
              descriptionName: 'analyzer',
              descriptionUrl: 'https://pub.dartlang.org',
              source: 'hosted',
              version: '0.30.0+2',
            ));
        expect(
            analyzer.pubspecLock.packages[17],
            new LockedDependency(
              key: 'http_parser',
              descriptionName: 'http_parser',
              descriptionUrl: 'https://pub.dartlang.org',
              source: 'hosted',
              version: '3.1.1',
            ));
      });
    });
  });
}
