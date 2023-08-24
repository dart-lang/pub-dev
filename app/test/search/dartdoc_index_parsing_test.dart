// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:clock/clock.dart';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:pub_dev/search/models.dart';
import 'package:pub_dev/search/sdk_mem_index.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:retry/retry.dart';
import 'package:test/test.dart';

final _indexedKinds = <int>{
  3, // class
  1, // constant,
  2, // constructor
  5, // enum
  6, // extension
  7, // function
  8, // library
  9, // method
  10, // mixin
  15, // property
  18, // top-level constant
  19, // top-level property
  20, // typedef
};

void main() {
  group('dartdoc index.json parsing', () {
    /// Downloads [url and creates a cached file in the .dart_tool/pub-search-data directory.
    ///
    /// Reuses the same file up to a week.
    Future<File> getCachedFile(String name, String url) async {
      final file = File(p.join('.dart_tool', 'pub-search-data', name));
      if (await file.exists()) {
        final lastModified = await file.lastModified();
        final age = clock.now().difference(lastModified);
        if (age.inDays < 7) {
          return file;
        }
      }
      await file.parent.create(recursive: true);
      return retry(() async {
        final rs = await http.get(Uri.parse(url));
        if (rs.statusCode != 200) {
          throw Exception('Unexpected status code for $url: ${rs.statusCode}');
        }
        await file.writeAsBytes(rs.bodyBytes);
        return file;
      });
    }

    test('parse Dart SDK index.json', () async {
      final file = await getCachedFile(
          'dart-sdk-$toolStableDartSdkVersion.json',
          'https://api.dart.dev/stable/$toolStableDartSdkVersion/index.json');
      final textContent = await file.readAsString();
      final index = DartdocIndex.parseJsonText(await file.readAsString());
      expect(index.entries, hasLength(greaterThan(10000)));

      final libraries =
          index.entries.where((e) => e.isLibrary).map((e) => e.name).toSet();
      expect(
          libraries,
          containsAll([
            'dart:ffi',
            'dart:io',
            'dart:js',
          ]));

      final kinds = index.entries.map((e) => e.kind).whereNotNull().toSet();
      for (final kind in kinds) {
        expect(_indexedKinds.contains(kind), isTrue,
            reason: 'unknown kind: $kind');
      }

      // making sure we don't miss any new attribute
      expect(json.decode(index.toJsonText()), json.decode(textContent));
    });

    test('parse Flutter SDK index.json', () async {
      final file = await getCachedFile(
          'flutter-sdk.json', 'https://api.flutter.dev/flutter/index.json');
      final textContent = await file.readAsString();
      final index = DartdocIndex.parseJsonText(await file.readAsString());
      expect(index.entries, hasLength(greaterThan(10000)));

      final libraries =
          index.entries.where((e) => e.isLibrary).map((e) => e.name).toSet();
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
          ]));

      final kinds = index.entries.map((e) => e.kind).whereNotNull().toSet();
      for (final kind in kinds) {
        expect(_indexedKinds.contains(kind), isTrue,
            reason: 'unknown kind: $kind');
      }

      // making sure we don't miss any new attribute
      final originalWithoutFirstEntry = (json.decode(textContent) as List)
        ..removeAt(0);
      final parserWithoutFirstEntry = (json.decode(index.toJsonText()) as List)
        ..removeAt(0);
      expect(parserWithoutFirstEntry, originalWithoutFirstEntry);

      // parsing into SDK index
      final sdkMemIndex = SdkMemIndex.flutter();
      await sdkMemIndex.addDartdocIndex(index);
      final rs = sdkMemIndex.search('StatelessWidget');
      expect(json.decode(json.encode(rs)), [
        {
          'sdk': 'flutter',
          'library': 'widgets',
          'url': 'https://api.flutter.dev/flutter/widgets/widgets-library.html',
          'score': closeTo(0.98, 0.01),
          'apiPages': [
            {
              'path': 'widgets/StatelessWidget-class.html',
              'url':
                  'https://api.flutter.dev/flutter/widgets/StatelessWidget-class.html'
            },
            {
              'path': 'widgets/StatelessWidget/StatelessWidget.html',
              'url':
                  'https://api.flutter.dev/flutter/widgets/StatelessWidget/StatelessWidget.html'
            },
            {
              'path': 'widgets/StatelessWidget/build.html',
              'url':
                  'https://api.flutter.dev/flutter/widgets/StatelessWidget/build.html'
            },
          ],
        },
      ]);
    });
  });
}
