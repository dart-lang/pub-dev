// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/fake/backend/fake_cdn_invalidator.dart';
import 'package:pub_dev/service/cdn/cdn_invalidator.dart';
import 'package:retry/retry.dart';
import 'package:test/test.dart';

const _fastRetry = RetryOptions(
  maxAttempts: 3,
  delayFactor: Duration.zero,
  maxDelay: Duration.zero,
);

void main() {
  group('validateCdnInvalidationPath', () {
    test('accepts valid paths', () {
      final validPaths = [
        '/',
        '/*',
        '/api/packages/foo',
        '/api/packages/foo/*',
        '/api/archives/foo-*',
        '/api/archives/foo-1.0.0+1.tar.gz',
        '/documentation/foo/1.0.0-dev.1+2/*',
        '/${'a' * 1023}',
      ];
      for (final path in validPaths) {
        expect(() => validateCdnInvalidationPath(path), returnsNormally);
      }
    });

    test('rejects invalid paths', () {
      final invalidPaths = [
        '',
        'api/packages/foo',
        '/api/packages/foo?a=1',
        '/api/packages/foo#frag',
        '/api/packages/foo bar',
        '/api/packages/foo\n',
        '/api/packages/foo\x7f',
        '/api/*/foo',
        '/api/packages/foo**',
        '/api/*/foo*',
        '/${'a' * 1024}',
        '/${'é' * 512}', // 1 + 1024 = 1025 UTF-8 bytes
      ];
      for (final path in invalidPaths) {
        expect(
          () => validateCdnInvalidationPath(path),
          throwsArgumentError,
          reason: 'Expected ArgumentError for "$path"',
        );
      }
    });
  });

  group('NoopCdnInvalidator', () {
    test('validates paths and completes', () async {
      const invalidator = NoopCdnInvalidator();
      await invalidator.invalidatePaths(const []);
      await invalidator.invalidatePaths(const ['/api/packages/foo']);
      await expectLater(
        invalidator.invalidatePaths(const ['bad-path']),
        throwsArgumentError,
      );
    });
  });

  group('FakeCdnInvalidator', () {
    test('deduplicates, validates, and invokes callback', () async {
      final invalidator = FakeCdnInvalidator();
      final batches = <List<String>>[];
      invalidator.onInvalidate = batches.add;

      await invalidator.invalidatePaths(const []);
      expect(invalidator.invalidatedPaths, isEmpty);
      expect(batches, isEmpty);

      await invalidator.invalidatePaths(const [
        '/api/packages/foo',
        '/api/packages/foo',
        '/api/archives/foo-1.0.0.tar.gz',
      ]);
      expect(invalidator.invalidatedPaths, [
        '/api/packages/foo',
        '/api/archives/foo-1.0.0.tar.gz',
      ]);
      expect(batches, [
        ['/api/packages/foo', '/api/archives/foo-1.0.0.tar.gz'],
      ]);

      await expectLater(
        invalidator.invalidatePaths(const ['/api/packages/bar', 'invalid']),
        throwsArgumentError,
      );
      expect(invalidator.invalidatedPaths, hasLength(2));
    });
  });

  group('GoogleCloudCdnInvalidator', () {
    test('rejects empty projectId or urlMap', () {
      final client = MockClient((_) async => http.Response('{}', 200));
      expect(
        () => GoogleCloudCdnInvalidator(
          client,
          projectId: '',
          urlMap: 'pub-urlmap',
        ),
        throwsArgumentError,
      );
      expect(
        () => GoogleCloudCdnInvalidator(
          client,
          projectId: 'dartlang-pub',
          urlMap: '',
        ),
        throwsArgumentError,
      );
    });

    test('posts expected invalidateCache request and deduplicates', () async {
      final requests = <http.Request>[];
      final client = MockClient((request) async {
        requests.add(request);
        return http.Response(
          json.encode({'name': 'op-1', 'status': 'DONE'}),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final invalidator = GoogleCloudCdnInvalidator(
        client,
        projectId: 'dartlang-pub',
        urlMap: 'pub-urlmap',
        retryOptions: _fastRetry,
      );

      await invalidator.invalidatePaths(const [
        '/api/packages/foo',
        '/api/packages/foo',
        '/api/archives/foo-1.0.0+1.tar.gz',
      ]);

      expect(requests, hasLength(2));
      for (final req in requests) {
        expect(req.method, 'POST');
        expect(req.url.host, 'compute.googleapis.com');
        expect(
          req.url.path,
          '/compute/v1/projects/dartlang-pub/global/urlMaps/pub-urlmap/invalidateCache',
        );
        expect(req.url.queryParameters['requestId'], isNotEmpty);
      }

      final bodies = requests
          .map((r) => json.decode(r.body) as Map<String, Object?>)
          .toList();
      expect(bodies, [
        {'path': '/api/packages/foo'},
        {'path': '/api/archives/foo-1.0.0+1.tar.gz'},
      ]);
      // Distinct requestIds for distinct paths.
      expect(
        requests[0].url.queryParameters['requestId'],
        isNot(requests[1].url.queryParameters['requestId']),
      );
    });

    test('validates all paths before making any HTTP calls', () async {
      var calls = 0;
      final client = MockClient((_) async {
        calls++;
        return http.Response('{}', 200);
      });
      final invalidator = GoogleCloudCdnInvalidator(
        client,
        projectId: 'dartlang-pub',
        urlMap: 'pub-urlmap',
        retryOptions: _fastRetry,
      );

      await expectLater(
        invalidator.invalidatePaths(const [
          '/api/packages/foo',
          '/api/packages/foo?query=1',
        ]),
        throwsArgumentError,
      );
      expect(calls, 0);
    });

    test('retries transient HTTP errors with the same requestId', () async {
      final requestIds = <String?>[];
      final client = MockClient((request) async {
        requestIds.add(request.url.queryParameters['requestId']);
        if (requestIds.length < 3) {
          return http.Response(
            json.encode({
              'error': {'code': 503, 'message': 'Backend unavailable'},
            }),
            503,
            headers: {'content-type': 'application/json'},
          );
        }
        return http.Response(
          json.encode({'name': 'op-ok', 'status': 'DONE'}),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final invalidator = GoogleCloudCdnInvalidator(
        client,
        projectId: 'dartlang-pub',
        urlMap: 'pub-urlmap',
        retryOptions: _fastRetry,
      );

      final logs = <LogRecord>[];
      final sub = Logger('pub.cdn_invalidator').onRecord.listen(logs.add);
      addTearDown(sub.cancel);

      await invalidator.invalidatePaths(const ['/api/packages/foo']);

      expect(requestIds, hasLength(3));
      expect(requestIds.toSet(), hasLength(1));
      expect(
        logs.where((r) => r.message.contains('cdn-invalidation-failed')),
        isEmpty,
      );
    });

    test('retries retryable Operation.error with a fresh requestId', () async {
      final requestIds = <String?>[];
      final client = MockClient((request) async {
        requestIds.add(request.url.queryParameters['requestId']);
        if (requestIds.length == 1) {
          return http.Response(
            json.encode({
              'name': 'op-fail',
              'status': 'DONE',
              'httpErrorStatusCode': 503,
              'httpErrorMessage': 'SERVICE UNAVAILABLE',
              'error': {
                'errors': [
                  {'code': 'BACKEND_ERROR', 'message': 'Transient failure'},
                ],
              },
            }),
            200,
            headers: {'content-type': 'application/json'},
          );
        }
        return http.Response(
          json.encode({'name': 'op-ok', 'status': 'DONE'}),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final invalidator = GoogleCloudCdnInvalidator(
        client,
        projectId: 'dartlang-pub',
        urlMap: 'pub-urlmap',
        retryOptions: _fastRetry,
      );

      final logs = <LogRecord>[];
      final sub = Logger('pub.cdn_invalidator').onRecord.listen(logs.add);
      addTearDown(sub.cancel);

      await invalidator.invalidatePaths(const ['/api/packages/foo']);

      expect(requestIds, hasLength(2));
      expect(requestIds[0], isNot(requestIds[1]));
      expect(
        logs.where((r) => r.message.contains('cdn-invalidation-failed')),
        isEmpty,
      );
    });

    test(
      'logs pubNoticeWarning without throwing on non-retryable error and isolates sibling paths',
      () async {
        final pathsSeen = <String>[];
        final client = MockClient((request) async {
          final body = json.decode(request.body) as Map<String, Object?>;
          final path = body['path'] as String;
          pathsSeen.add(path);
          if (path == '/api/packages/forbidden') {
            return http.Response(
              json.encode({
                'error': {'code': 403, 'message': 'Permission denied'},
              }),
              403,
              headers: {'content-type': 'application/json'},
            );
          }
          if (path == '/api/packages/op_bad_request') {
            return http.Response(
              json.encode({
                'name': 'op-bad',
                'status': 'DONE',
                'httpErrorStatusCode': 400,
                'httpErrorMessage': 'BAD REQUEST',
                'error': {
                  'errors': [
                    {'code': 'INVALID', 'message': 'Bad rule'},
                  ],
                },
              }),
              200,
              headers: {'content-type': 'application/json'},
            );
          }
          return http.Response(
            json.encode({'name': 'op-ok', 'status': 'DONE'}),
            200,
            headers: {'content-type': 'application/json'},
          );
        });

        final invalidator = GoogleCloudCdnInvalidator(
          client,
          projectId: 'dartlang-pub',
          urlMap: 'pub-urlmap',
          retryOptions: _fastRetry,
        );

        final logs = <LogRecord>[];
        final sub = Logger('pub.cdn_invalidator').onRecord.listen(logs.add);
        addTearDown(sub.cancel);

        await invalidator.invalidatePaths(const [
          '/api/packages/forbidden',
          '/api/packages/op_bad_request',
          '/api/packages/ok',
        ]);

        // Non-retryable errors must not be retried, and sibling paths still run.
        expect(
          pathsSeen,
          unorderedEquals([
            '/api/packages/forbidden',
            '/api/packages/op_bad_request',
            '/api/packages/ok',
          ]),
        );
        final warnings = logs
            .where(
              (r) => r.message.contains('[pub-notice:cdn-invalidation-failed]'),
            )
            .toList();
        expect(warnings, hasLength(2));
        expect(warnings.every((r) => r.level == Level.WARNING), isTrue);
      },
    );

    test('logs pubNoticeWarning when retries are exhausted', () async {
      var calls = 0;
      final client = MockClient((_) async {
        calls++;
        throw http.ClientException('connection reset');
      });

      final invalidator = GoogleCloudCdnInvalidator(
        client,
        projectId: 'dartlang-pub',
        urlMap: 'pub-urlmap',
        retryOptions: _fastRetry,
      );

      final logs = <LogRecord>[];
      final sub = Logger('pub.cdn_invalidator').onRecord.listen(logs.add);
      addTearDown(sub.cancel);

      await invalidator.invalidatePaths(const ['/api/packages/foo']);

      expect(calls, 3);
      final warnings = logs
          .where(
            (r) => r.message.contains('[pub-notice:cdn-invalidation-failed]'),
          )
          .toList();
      expect(warnings, hasLength(1));
      expect(warnings.single.level == Level.WARNING, isTrue);
    });
  });
}
