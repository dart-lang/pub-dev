// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:pub_dev/shared/handlers.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:test/test.dart';

void main() {
  group('accept encoding', () {
    final uri = Uri.parse('https://pub.dev/api/packages/retry');
    test('no header', () {
      final request = shelf.Request('GET', uri);
      expect(request.acceptsEncoding('gzip'), isFalse);
    });

    test('gzip header', () {
      final request = shelf.Request(
        'GET',
        uri,
        headers: {HttpHeaders.acceptEncodingHeader: 'deflate, gzip;q=0.1'},
      );
      expect(request.acceptsEncoding('gzip'), isTrue);
    });

    test('other header', () {
      final request = shelf.Request(
        'GET',
        uri,
        headers: {HttpHeaders.acceptEncodingHeader: 'deflate;q=1'},
      );
      expect(request.acceptsEncoding('gzip'), isFalse);
      expect(request.acceptsEncoding('deflate'), isTrue);
    });

    test('* header', () {
      final request = shelf.Request(
        'GET',
        uri,
        headers: {HttpHeaders.acceptEncodingHeader: 'deflate;q=1, *;q=0.2'},
      );
      expect(request.acceptsEncoding('gzip'), isFalse);
      expect(request.acceptsEncoding('anything'), isFalse);
      expect(request.acceptsEncoding('*'), isTrue);
    });
  });
}
