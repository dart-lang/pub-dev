// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:pub_dev/search/dart_sdk_mem_index.dart';
import 'package:pub_dev/search/models.dart';
import 'package:pub_dev/search/sdk_mem_index.dart';
import 'package:test/test.dart';

void main() {
  group('SdkMemIndex', () {
    late SdkMemIndex index;

    setUpAll(() async {
      index = SdkMemIndex(
        sdk: 'dart',
        version: '',
        baseUri: Uri.parse('https://api.dart.dev/x/'),
      );
      index.updateWeights(
        libraryWeights: dartSdkLibraryWeights,
        apiPageDirWeights: {
          'dart:html/FakeIcons': 0.7,
        },
      );
      await index.addDartdocIndex(DartdocIndex.fromJsonList([
        {
          'name': 'dart:async',
          'qualifiedName': 'dart:async',
          'href': 'dart-async/dart-async-library.html',
          'kind': 8,
          'overriddenDepth': 0,
          'packageName': 'Dart',
        },
        {
          'name': 'AsyncError',
          'qualifiedName': 'dart:async.AsyncError',
          'href': 'dart-async/AsyncError-class.html',
          'kind': 3,
          'overriddenDepth': 0,
          'packageName': 'Dart',
          'enclosedBy': {'name': 'dart:async', 'kind': 8},
        },
        {
          'name': 'AsyncError',
          'qualifiedName': 'dart:async.AsyncError.AsyncError',
          'href': 'dart-async/AsyncError/AsyncError.html',
          'kind': 2,
          'overriddenDepth': 0,
          'packageName': 'Dart',
          'enclosedBy': {'name': 'AsyncError', 'kind': 3},
        },
        {
          'name': 'defaultStackTrace',
          'qualifiedName': 'dart:async.AsyncError.defaultStackTrace',
          'href': 'dart-async/AsyncError/defaultStackTrace.html',
          'kind': 9,
          'overriddenDepth': 0,
          'packageName': 'Dart',
          'enclosedBy': {'name': 'AsyncError', 'kind': 3},
        },
        {
          'name': 'Window',
          'qualifiedName': 'dart:html.Window',
          'href': 'dart-html/Window-class.html',
          'kind': 3,
          'overriddenDepth': 0,
          'packageName': 'Dart',
          'enclosedBy': {'name': 'dart:html', 'kind': 8},
        },
        {
          'name': 'flame',
          'qualifiedName': 'dart:html.FakeIcons.flame',
          'href': 'dart-html/FakeIcons/flame-constant.html',
          'kind': 1,
          'overriddenDepth': 0,
          'packageName': 'Dart',
          'enclosedBy': {'name': 'dart:html.FakeIcons', 'kind': 3},
        },
      ]));
      index.addLibraryDescriptions({'dart:async': 'async description'});
      index.addLibraryDescriptions({'dart:html': 'html description'});
    });

    test('AsyncError', () async {
      final rs = index.search('AsyncError');
      expect(
        json.decode(json.encode(rs)),
        [
          {
            'sdk': 'dart',
            'version': '',
            'library': 'dart:async',
            'description': 'async description',
            'url': 'https://api.dart.dev/x/dart-async/dart-async-library.html',
            'score': closeTo(0.98, 0.01),
            'apiPages': [
              {
                'path': 'dart-async/AsyncError-class.html',
                'url': 'https://api.dart.dev/x/dart-async/AsyncError-class.html'
              },
              {
                'path': 'dart-async/AsyncError/AsyncError.html',
                'url':
                    'https://api.dart.dev/x/dart-async/AsyncError/AsyncError.html'
              },
              {
                'path': 'dart-async/AsyncError/defaultStackTrace.html',
                'url':
                    'https://api.dart.dev/x/dart-async/AsyncError/defaultStackTrace.html'
              },
            ]
          },
        ],
      );
    });

    test('stack trace', () async {
      final rs = index.search('stack trace');
      expect(
        json.decode(json.encode(rs)),
        [
          {
            'sdk': 'dart',
            'version': '',
            'library': 'dart:async',
            'description': 'async description',
            'url': 'https://api.dart.dev/x/dart-async/dart-async-library.html',
            'score': closeTo(0.28, 0.01),
            'apiPages': [
              {
                'path': 'dart-async/AsyncError/defaultStackTrace.html',
                'url':
                    'https://api.dart.dev/x/dart-async/AsyncError/defaultStackTrace.html'
              },
            ]
          },
        ],
      );
    });

    test('defaultStackTrace', () async {
      final rs = index.search('defaultStackTrace');
      expect(
        json.decode(json.encode(rs)),
        [
          {
            'sdk': 'dart',
            'version': '',
            'library': 'dart:async',
            'description': 'async description',
            'url': 'https://api.dart.dev/x/dart-async/dart-async-library.html',
            'score': closeTo(0.98, 0.01),
            'apiPages': [
              {
                'path': 'dart-async/AsyncError/defaultStackTrace.html',
                'url':
                    'https://api.dart.dev/x/dart-async/AsyncError/defaultStackTrace.html'
              },
            ]
          },
        ],
      );
    });

    test('reduced score with library', () async {
      // qualified query gets higher score
      final rs1 = index.search('window');
      final rs2 = index.search('html window');
      expect(rs1.single.library, 'dart:html');
      expect(rs2.single.library, 'dart:html');
      expect(rs1.single.score < rs2.single.score * 0.8, isTrue);

      // the keyword would match dart:html too, but the low score will be removed from the list
      final rs3 = index.search('dart');
      expect(rs3.single.library, 'dart:async');
    });

    test('reduced score with api page', () async {
      // qualified query gets higher score
      final rs1 = index.search('flame');
      final rs2 = index.search('html flame');
      expect(rs1.single.library, 'dart:html');
      expect(rs2.single.library, 'dart:html');
      expect(rs1.single.score < rs2.single.score * 0.8, isTrue);
    });
  });
}
