// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:_pub_shared/utils/http.dart';
import 'package:googleapis/storage/v1.dart'
    show ApiRequestError, DetailedApiRequestError;
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  const transientCodes = [408, 429, 500, 502, 503, 504];
  const nonTransientCodes = [400, 401, 403, 404, 409, 501];
  final testUri = Uri.parse('https://example.com/resource');

  group('isRetryableException', () {
    test('retries transient DetailedApiRequestError status codes', () {
      for (final code in transientCodes) {
        expect(
          isRetryableException(DetailedApiRequestError(code, 'transient')),
          isTrue,
          reason: 'Expected status $code to be retryable',
        );
      }
      expect(
        isRetryableException(DetailedApiRequestError(null, 'unknown')),
        isTrue,
      );
    });

    test(
      'does not retry non-transient DetailedApiRequestError status codes',
      () {
        for (final code in nonTransientCodes) {
          expect(
            isRetryableException(
              DetailedApiRequestError(code, 'non-transient'),
            ),
            isFalse,
            reason: 'Expected status $code not to be retryable',
          );
        }
      },
    );

    test('retries transient UnexpectedStatusException status codes', () {
      for (final code in transientCodes) {
        expect(
          isRetryableException(UnexpectedStatusException(code, testUri)),
          isTrue,
          reason: 'Expected status $code to be retryable',
        );
      }
    });

    test(
      'does not retry non-transient UnexpectedStatusException status codes',
      () {
        for (final code in nonTransientCodes) {
          expect(
            isRetryableException(UnexpectedStatusException(code, testUri)),
            isFalse,
            reason: 'Expected status $code not to be retryable',
          );
        }
      },
    );

    test('retries timeout, IO, HTTP client, and generic API errors', () {
      expect(isRetryableException(TimeoutException('timeout')), isTrue);
      expect(isRetryableException(const SocketException('reset')), isTrue);
      expect(isRetryableException(http.ClientException('closed')), isTrue);
      expect(isRetryableException(ApiRequestError('malformed')), isTrue);
      expect(isRetryableException(const FormatException('bad')), isFalse);
    });
  });

  group('httpRetryClient', () {
    for (final code in [408, 504]) {
      test('retries HTTP $code', () async {
        var attempts = 0;
        final client = httpRetryClient(
          retries: 1,
          innerClient: MockClient((request) async {
            attempts++;
            return http.Response('', attempts == 1 ? code : 200);
          }),
        );
        addTearDown(client.close);

        final response = await client.get(testUri);
        expect(response.statusCode, 200);
        expect(attempts, 2);
      });
    }

    test('does not retry HTTP 404', () async {
      var attempts = 0;
      final client = httpRetryClient(
        retries: 1,
        innerClient: MockClient((request) async {
          attempts++;
          return http.Response('', 404);
        }),
      );
      addTearDown(client.close);

      final response = await client.get(testUri);
      expect(response.statusCode, 404);
      expect(attempts, 1);
    });
  });
}
