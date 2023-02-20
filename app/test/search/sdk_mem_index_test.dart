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
      index.updatesLibraryWeights(dartSdkLibraryWeights);
      await index.addDartdocIndex(DartdocIndex.fromJsonList([
        {
          'name': 'dart:async',
          'qualifiedName': 'dart:async',
          'href': 'dart-async/dart-async-library.html',
          'type': 'library',
          'overriddenDepth': 0,
          'packageName': 'Dart',
        },
        {
          'name': 'AsyncError',
          'qualifiedName': 'dart:async.AsyncError',
          'href': 'dart-async/AsyncError-class.html',
          'type': 'class',
          'overriddenDepth': 0,
          'packageName': 'Dart',
          'enclosedBy': {'name': 'dart:async', 'type': 'library'},
        },
        {
          'name': 'AsyncError',
          'qualifiedName': 'dart:async.AsyncError.AsyncError',
          'href': 'dart-async/AsyncError/AsyncError.html',
          'type': 'constructor',
          'overriddenDepth': 0,
          'packageName': 'Dart',
          'enclosedBy': {'name': 'AsyncError', 'type': 'class'},
        },
        {
          'name': 'defaultStackTrace',
          'qualifiedName': 'dart:async.AsyncError.defaultStackTrace',
          'href': 'dart-async/AsyncError/defaultStackTrace.html',
          'type': 'method',
          'overriddenDepth': 0,
          'packageName': 'Dart',
          'enclosedBy': {'name': 'AsyncError', 'type': 'class'},
        },
        {
          'name': 'Window',
          'qualifiedName': 'dart:html.Window',
          'href': 'dart-html/Window-class.html',
          'type': 'class',
          'overriddenDepth': 0,
          'packageName': 'Dart',
          'enclosedBy': {'name': 'dart:html', 'type': 'library'},
        },
      ]));
      index.addLibraryDescriptions({'dart:async': 'async description'});
      index.addLibraryDescriptions({'dart:html': 'html description'});
    });

    test('AsyncError', () async {
      final rs = await index.search('AsyncError');
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
      final rs = await index.search('stack trace');
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
      final rs = await index.search('defaultStackTrace');
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

    test('html reduced score', () async {
      // qualified query gets higher score
      final rs1 = await index.search('window');
      final rs2 = await index.search('html window');
      expect(rs1.single.library, 'dart:html');
      expect(rs2.single.library, 'dart:html');
      expect(rs1.single.score < rs2.single.score * 0.8, isTrue);

      // the keyword would match dart:html too, but the low score will be removed from the list
      final rs3 = await index.search('dart');
      expect(rs3.single.library, 'dart:async');
    });
  });
}
