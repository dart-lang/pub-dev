// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/validation/html/html_validation.dart';
import 'package:test/test.dart';

void main() {
  final defaultHeader = '<head><meta name="robots" content="noindex" /></head>';

  void expectException(String html) {
    expect(() => parseAndValidateHtml(html), throwsA(isA<Exception>()));
  }

  void expectError(String html) {
    expect(() => parseAndValidateHtml(html), throwsA(isA<Error>()));
  }

  group('invalid html', () {
    test('bad tag', () {
      expectException('<html></htm>');
      expectException('<html><head><body></head></body></html>');
    });

    test('bad attribute quotes', () {
      expectException('<html>$defaultHeader<body attr="x\'></body></html>');
    });
  });

  group('pub restrictions', () {
    test('no onclick or other inline JS calls', () {
      expectError('<html>$defaultHeader<body onclick="x"></body></html>');
      expectError('<html>$defaultHeader<body onblur="x"></body></html>');
      expectError('<html>$defaultHeader<body onxyz="x"></body></html>');
    });

    test('target="_blank" with rel="noopener"', () {
      expectError(
        '<html>$defaultHeader<body><a href="x" target="_blank"></a></body></html>',
      );
      expectError(
        '<html>$defaultHeader<body><a href="x" target="_blank" rel="noopen"></a></body></html>',
      );
    });

    test('script with src only', () {
      expectError('<html>$defaultHeader<body><script></script></body></html>');
      expectError(
        '<html>$defaultHeader<body><script>window.alert("!");</script></body></html>',
      );
      expectError(
        '<html>$defaultHeader<body><script src="x.js">window.alert("!");</script></body></html>',
      );
    });

    test('without canonical url or noindex', () {
      expectError('<html><head></head><body></body></html>');
    });

    test('more than one canonical url', () {
      expectError(
        '<html><head><link rel="canonical" href="https://pub.dev/" />'
        '<link rel="canonical" href="https://pub.dev/x" /></head><body></body></html>',
      );
    });

    test('canonical url on a different domain', () {
      expectError(
        '<html><head><link rel="canonical" href="https://example.com/" /></head></html>',
      );
    });
  });

  group('valid html', () {
    test('minimal', () {
      parseAndValidateHtml(
        '<html><head><meta name="robots" content="noindex" /></head><body></body></html>',
      );
    });

    test('pub restrictions used correctly', () {
      parseAndValidateHtml(
        '<html>$defaultHeader<body><a href="x" target="_blank" rel="x noopener y"></a></body></html>',
      );
      parseAndValidateHtml(
        '<html>$defaultHeader<body><script src="x.js"></script></body></html>',
      );
      parseAndValidateHtml(
        '<html>$defaultHeader<body><script type="application/ld+json">{}</script></body></html>',
      );
      parseAndValidateHtml(
        '<html><head><link rel="canonical" href="https://pub.dev/" /></head><body></body></html>',
      );
      parseAndValidateHtml(
        '<html><head><meta name="robots" content="noindex" />'
        '<link rel="canonical" href="https://pub.dev/" /></head>'
        '<body></body></html>',
      );
    });
  });
}
