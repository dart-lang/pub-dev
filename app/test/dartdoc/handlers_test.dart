// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.handlers_test;

import 'dart:async';

import 'package:shelf/shelf.dart' as shelf;
import 'package:test/test.dart';

import 'package:pub_dartlang_org/dartdoc/handlers.dart';

import '../shared/handlers_test_utils.dart';

void main() {
  group('path parsing', () {
    void testUri(String rqPath, String package, [String version, String path]) {
      final p = parseRequestUri(Uri.parse('https://pub.dartlang.org$rqPath'));
      if (package == null) {
        expect(p, isNull);
      } else {
        expect(p, isNotNull);
        expect(p.package, package);
        expect(p.version, version);
        expect(p.path, path);
      }
    }

    test('/documentation', () {
      testUri('/documentation', null);
    });
    test('/documentation/', () {
      testUri('/documentation/', null);
    });
    test('/documentation/angular', () {
      testUri('/documentation/angular', null);
    });
    test('/documentation/angular/', () {
      testUri('/documentation/angular/', null);
    });
    test('/documentation/angular/4.0.0%2B2', () {
      testUri('/documentation/angular/4.0.0%2B2', 'angular', '4.0.0+2',
          'index.html');
    });
    test('/documentation/angular/4.0.0%2B2/', () {
      testUri('/documentation/angular/4.0.0%2B2/', 'angular', '4.0.0+2',
          'index.html');
    });
    test('/documentation/angular/4.0.0%2B2/subdir/', () {
      testUri('/documentation/angular/4.0.0%2B2/subdir/', 'angular', '4.0.0+2',
          'subdir/index.html');
    });
    test('/documentation/angular/4.0.0%2B2/file.html', () {
      testUri('/documentation/angular/4.0.0%2B2/file.html', 'angular',
          '4.0.0+2', 'file.html');
    });
    test('/documentation/angular/4.0.0+2/file.html', () {
      testUri('/documentation/angular/4.0.0%2B2/file.html', 'angular',
          '4.0.0+2', 'file.html');
    });
  });

  group('dartdoc handlers', () {
    Future<shelf.Response> issueGet(String uri) => dartdocServiceHandler(
        new shelf.Request('GET', Uri.parse('https://www.dartdocs.org$uri')));

    test('/documentation/flutter redirect', () async {
      expectRedirectResponse(
        await issueGet('/documentation/flutter'),
        'https://docs.flutter.io/',
      );
    });
    test('/documentation/flutter/version redirect', () async {
      expectRedirectResponse(
        await issueGet('/documentation/flutter/version'),
        'https://docs.flutter.io/',
      );
    });
  });
}
