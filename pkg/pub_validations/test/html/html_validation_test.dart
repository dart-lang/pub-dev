// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_validations/html/html_validation.dart';

void main() {
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
      expectException('<html><head></head><body attr="x\'></body></html>');
    });
  });

  group('pub restrictions', () {
    test('no onclick or other inline JS calls', () {
      expectError('<html><head></head><body onclick="x"></body></html>');
      expectError('<html><head></head><body onblur="x"></body></html>');
      expectError('<html><head></head><body onxyz="x"></body></html>');
    });

    test('target="_blank" with rel="noopener"', () {
      expectError(
          '<html><head></head><body><a href="x" target="_blank"></a></body></html>');
      expectError(
          '<html><head></head><body><a href="x" target="_blank" rel="noopen"></a></body></html>');
    });

    test('script with src only', () {
      expectError('<html><head></head><body><script></script></body></html>');
      expectError(
          '<html><head></head><body><script>window.alert("!");</script></body></html>');
      expectError(
          '<html><head></head><body><script src="x.js">window.alert("!");</script></body></html>');
    });

    test('more than one canonical url', () {
      expectError('<html><head><link rel="canonical" href="https://pub.dev/" />'
          '<link rel="canonical" href="https://pub.dev/x" /></head><body></body></html>');
    });

    test('canonical url on a different domain', () {
      expectError(
          '<html><head><link rel="canonical" href="https://example.com/" /></head></html>');
    });
  });

  group('valid html', () {
    test('minimal', () {
      parseAndValidateHtml('<html><head></head><body></body></html>');
    });

    test('pub restrictions used correctly', () {
      parseAndValidateHtml(
          '<html><head></head><body><a href="x" target="_blank" rel="x noopener y"></a></body></html>');
      parseAndValidateHtml(
          '<html><head></head><body><script src="x.js"></script></body></html>');
      parseAndValidateHtml(
          '<html><head></head><body><script type="application/ld+json">{}</script></body></html>');
      parseAndValidateHtml(
          '<html><head><link rel="canonical" href="https://pub.dev/" /></head><body></body></html>');
    });
  });
}
