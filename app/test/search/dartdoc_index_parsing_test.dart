// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:pub_dev/search/backend.dart';
import 'package:pub_dev/search/sdk_mem_index.dart';
import 'package:test/test.dart';

import '../shared/test_services.dart';

void main() {
  group('dartdoc index.json parsing', () {
    testWithProfile(
      'parse Dart SDK index.json',
      fn: () async {
        final textContent = await loadOrFetchSdkIndexJsonAsString(
          Uri.parse('https://api.dart.dev/stable/latest/index.json'),
          ttl: Duration(days: 1),
        );
        final index = DartdocIndex.parseJsonText(textContent);
        expect(index.entries, hasLength(greaterThan(10000)));

        final libraries = index.entries
            .where((e) => e.isLibrary)
            .map((e) => e.name)
            .toSet();
        expect(libraries, containsAll(['dart:ffi', 'dart:io', 'dart:js']));

        // making sure we don't miss any new attribute
        expect(json.decode(index.toJsonText()), json.decode(textContent));
      },
    );

    testWithProfile(
      'parse Flutter SDK index.json',
      fn: () async {
        final textContent = await loadOrFetchSdkIndexJsonAsString(
          Uri.parse('https://api.flutter.dev/flutter/index.json'),
          ttl: Duration(days: 1),
        );
        final index = DartdocIndex.parseJsonText(textContent);
        expect(index.entries, hasLength(greaterThan(10000)));

        final libraries = index.entries
            .where((e) => e.isLibrary)
            .map((e) => e.name)
            .toSet();
        expect(
          libraries,
          containsAll([
            // Dart VM libraries
            'dart:ffi',
            'dart:io',
            'dart:js',
            // additional libraries
            'animation',
            'cupertino',
            'flutter_driver',
            'flutter_test',
          ]),
        );

        // making sure we don't miss any new attribute
        final originalWithoutFirstEntry = (json.decode(textContent) as List)
          ..removeAt(0);
        final parserWithoutFirstEntry =
            (json.decode(index.toJsonText()) as List)..removeAt(0);
        expect(parserWithoutFirstEntry, originalWithoutFirstEntry);

        // parsing into SDK index
        final sdkMemIndex = SdkMemIndex(
          dartIndex: DartdocIndex([]),
          flutterIndex: index,
        );
        final rs = sdkMemIndex.search('StatelessWidget');
        expect(json.decode(json.encode(rs)), [
          {
            'sdk': 'flutter',
            'library': 'widgets',
            'description': 'The Flutter widgets framework.',
            'url': contains('https://api.flutter.dev/flutter/widgets'),
            'score': closeTo(0.98, 0.01),
            'apiPages': [
              {
                'path': 'widgets/StatelessWidget-class.html',
                'url':
                    'https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html',
              },
              {
                'path': 'widgets/StatelessWidget/StatelessWidget.html',
                'url':
                    'https://api.flutter.dev/flutter/widgets/StatelessWidget/StatelessWidget.html',
              },
              {
                'path': 'widgets/StatelessWidget/build.html',
                'url':
                    'https://api.flutter.dev/flutter/widgets/StatelessWidget/build.html',
              },
            ],
          },
        ]);
      },
    );
  });
}
