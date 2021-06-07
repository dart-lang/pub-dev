// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:pub_dev/search/models.dart';
import 'package:test/test.dart';

import 'package:pub_dev/search/sdk_mem_index.dart';

void main() {
  group('SdkMemIndex', () {
    SdkMemIndex index;

    setUpAll(() async {
      index = SdkMemIndex(
        sdk: 'dart',
        version: '',
        baseUri: Uri.parse('https://api.dart.dev/x/'),
      );
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
      ]));
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
            'url': 'https://api.dart.dev/x/',
            'score': closeTo(0.98, 0.01),
            'apiPages': [
              {
                'title': null,
                'path': 'dart-async/AsyncError-class.html',
                'url': 'https://api.dart.dev/x/dart-async/AsyncError-class.html'
              },
              {
                'title': null,
                'path': 'dart-async/AsyncError/AsyncError.html',
                'url':
                    'https://api.dart.dev/x/dart-async/AsyncError/AsyncError.html'
              },
              {
                'title': null,
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
            'url': 'https://api.dart.dev/x/',
            'score': closeTo(0.08, 0.01),
            'apiPages': [
              {
                'title': null,
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
            'url': 'https://api.dart.dev/x/',
            'score': closeTo(0.98, 0.01),
            'apiPages': [
              {
                'title': null,
                'path': 'dart-async/AsyncError/defaultStackTrace.html',
                'url':
                    'https://api.dart.dev/x/dart-async/AsyncError/defaultStackTrace.html'
              },
            ]
          },
        ],
      );
    });
  });
}
