// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:clock/clock.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:pub_dev/search/models.dart';
import 'package:pub_dev/search/sdk_mem_index.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:retry/retry.dart';
import 'package:test/test.dart';

final _indexTypes = <String>{
  'class',
  'constant',
  'constructor',
  'enum',
  'extension',
  'function',
  'library',
  'method',
  'mixin',
  'property',
  'top-level constant',
  'top-level property',
  'typedef',
};

void main() {
  group('dartdoc index.json parsing', tags: ['sanity'], () {
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

      final libraries = index.entries
          .where((e) => e.type == 'library')
          .map((e) => e.name)
          .toSet();
      expect(
          libraries,
          containsAll([
            'dart:ffi',
            'dart:io',
            'dart:js',
          ]));

      final types = index.entries.map((e) => e.type).toSet();
      for (final type in types) {
        expect(_indexTypes.contains(type), isTrue, reason: type);
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

      final libraries = index.entries
          .where((e) => e.type == 'library')
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
          ]));

      final types = index.entries.map((e) => e.type).toSet();
      for (final type in types) {
        expect(_indexTypes.contains(type), isTrue, reason: type);
      }

      // making sure we don't miss any new attribute
      expect(json.decode(index.toJsonText()), json.decode(textContent));

      // parsing into SDK index
      final sdkMemIndex = SdkMemIndex.flutter();
      await sdkMemIndex.addDartdocIndex(index);
      final rs = await sdkMemIndex.search('StatelessWidget');
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
