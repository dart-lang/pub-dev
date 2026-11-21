// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:_pub_shared/utils/http.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis/compute/v1.dart'
    show CacheInvalidationRule, ComputeApi;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pool/pool.dart';
import 'package:retry/retry.dart';

import '../../shared/monitoring.dart';
import '../../shared/utils.dart' show createUuid;

final _log = Logger('pub.cdn_invalidator');

final _cdnInvalidatorKey = #_cdnInvalidator;

/// Maximum UTF-8 byte length accepted by Cloud CDN invalidation path rules.
const _maxInvalidationPathBytes = 1024;

const _retryableOperationStatusCodes = {408, 429, 500, 502, 503, 504};

/// Sets the active [CdnInvalidator].
void registerCdnInvalidator(CdnInvalidator value) =>
    ss.register(_cdnInvalidatorKey, value);

/// Gets the active [CdnInvalidator].
CdnInvalidator get cdnInvalidator =>
    ss.lookup(_cdnInvalidatorKey) as CdnInvalidator;

/// Validates that [path] conforms to Cloud CDN cache invalidation path rules.
///
/// The [path] must start with `/`, contain no `?`, `#`, whitespace, or ASCII
/// control characters, contain at most one `*` (only as the final character),
/// and be at most 1024 UTF-8 bytes long.
void validateCdnInvalidationPath(String path) {
  if (!path.startsWith('/')) {
    throw ArgumentError.value(path, 'path', 'Must start with "/"');
  }
  if (path.contains('?') || path.contains('#')) {
    throw ArgumentError.value(path, 'path', 'Must not contain "?" or "#"');
  }
  for (var i = 0; i < path.length; i++) {
    final codeUnit = path.codeUnitAt(i);
    if (codeUnit <= 0x20 || codeUnit == 0x7f) {
      throw ArgumentError.value(
        path,
        'path',
        'Must not contain whitespace or control characters',
      );
    }
  }
  final wildcardIndex = path.indexOf('*');
  if (wildcardIndex != -1 && wildcardIndex != path.length - 1) {
    throw ArgumentError.value(
      path,
      'path',
      'Must contain at most one "*" and only at the end',
    );
  }
  if (utf8.encode(path).length > _maxInvalidationPathBytes) {
    throw ArgumentError.value(
      path,
      'path',
      'Must be at most $_maxInvalidationPathBytes UTF-8 bytes',
    );
  }
}

/// Invalidates cached responses in Cloud CDN.
abstract interface class CdnInvalidator {
  /// Invalidates cached CDN entries matching each path pattern in [paths].
  ///
  /// Each entry in [paths] must satisfy [validateCdnInvalidationPath].
  /// Duplicate paths are deduplicated.
  ///
  /// Invalidation is best-effort: network and API failures are logged rather
  /// than rethrown.
  Future<void> invalidatePaths(Iterable<String> paths);

  /// Releases resources held by this invalidator.
  Future<void> close();
}

/// A [CdnInvalidator] that validates paths and performs no network requests.
final class NoopCdnInvalidator implements CdnInvalidator {
  const NoopCdnInvalidator();

  @override
  Future<void> invalidatePaths(Iterable<String> paths) async {
    for (final path in paths) {
      validateCdnInvalidationPath(path);
    }
  }

  @override
  Future<void> close() async {}
}

/// Invalidates cached entries in Google Cloud CDN via Compute Engine
/// `urlMaps.invalidateCache`.
final class GoogleCloudCdnInvalidator implements CdnInvalidator {
  final ComputeApi _computeApi;
  final String _projectId;
  final String _urlMap;
  final Duration _requestTimeout;
  final RetryOptions _retryOptions;
  final Pool _pool = Pool(4);

  /// Creates a [GoogleCloudCdnInvalidator] targeting [urlMap] in [projectId].
  ///
  /// Both [projectId] and [urlMap] must be non-empty.
  /// The [client] should not be wrapped in a retry client because retries are
  /// managed per invalidation request with a Compute API `requestId`.
  GoogleCloudCdnInvalidator(
    http.Client client, {
    required String projectId,
    required String urlMap,
    Duration requestTimeout = const Duration(seconds: 30),
    @visibleForTesting RetryOptions? retryOptions,
  }) : _computeApi = ComputeApi(client),
       _projectId = projectId,
       _urlMap = urlMap,
       _requestTimeout = requestTimeout,
       _retryOptions =
           retryOptions ??
           const RetryOptions(
             maxAttempts: 3,
             delayFactor: Duration(milliseconds: 500),
             maxDelay: Duration(seconds: 10),
           ) {
    if (projectId.isEmpty) {
      throw ArgumentError.value(projectId, 'projectId', 'Must not be empty');
    }
    if (urlMap.isEmpty) {
      throw ArgumentError.value(urlMap, 'urlMap', 'Must not be empty');
    }
  }

  @override
  Future<void> invalidatePaths(Iterable<String> paths) async {
    final uniquePaths = <String>{};
    for (final path in paths) {
      validateCdnInvalidationPath(path);
      uniquePaths.add(path);
    }
    if (uniquePaths.isEmpty) {
      return;
    }

    await Future.wait(
      uniquePaths.map(
        (path) => _pool.withResource(() => _invalidatePath(path)),
      ),
    );
  }

  Future<void> _invalidatePath(String path) async {
    var requestId = createUuid();
    try {
      await _retryOptions.retry(
        () async {
          // Omit `host` so Cloud CDN invalidates across all hostnames on the
          // URL map (e.g. both pub.dev and pub.dartlang.org) in one rule.
          final operation = await _computeApi.urlMaps
              .invalidateCache(
                CacheInvalidationRule(path: path),
                _projectId,
                _urlMap,
                requestId: requestId,
              )
              .timeout(_requestTimeout);
          if (operation.error case final error?) {
            final details = error.errors
                ?.map((e) => '${e.code}: ${e.message}')
                .join('; ');
            final statusMessage = operation.httpErrorMessage != null
                ? ' (${operation.httpErrorMessage})'
                : '';
            final detailsSuffix = details != null && details.isNotEmpty
                ? ': $details'
                : '';
            throw _CdnInvalidationOperationException(
              statusCode: operation.httpErrorStatusCode,
              message:
                  'Operation ${operation.name} failed'
                  '$statusMessage$detailsSuffix',
            );
          }
        },
        retryIf: (e) =>
            isRetryableException(e) ||
            (e is _CdnInvalidationOperationException && e.isRetryable),
        onRetry: (e) {
          if (e is _CdnInvalidationOperationException) {
            // Compute Engine caches completed Operation results by requestId;
            // use a fresh requestId when retrying a failed Operation.
            requestId = createUuid();
          }
          _log.warning(
            'Retrying Cloud CDN invalidation for "$path" '
            '(urlMap=$_urlMap, requestId=$requestId): $e',
          );
        },
      );
      _log.info('Invalidated Cloud CDN cache path "$path" (urlMap=$_urlMap).');
    } catch (e, st) {
      _log.pubNoticeWarning(
        'cdn-invalidation-failed',
        'Failed to invalidate Cloud CDN cache path "$path" '
            '(project=$_projectId, urlMap=$_urlMap, requestId=$requestId).',
        e,
        st,
      );
    }
  }

  @override
  Future<void> close() => _pool.close();
}

final class _CdnInvalidationOperationException implements Exception {
  final int? statusCode;
  final String message;

  _CdnInvalidationOperationException({
    required this.statusCode,
    required this.message,
  });

  bool get isRetryable =>
      statusCode == null || _retryableOperationStatusCodes.contains(statusCode);

  @override
  String toString() =>
      '_CdnInvalidationOperationException(statusCode=$statusCode): $message';
}
