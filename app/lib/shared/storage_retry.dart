import 'dart:async' show FutureOr;

import 'package:http_retry/http_retry.dart' show RetryClient;
import 'package:gcloud/storage.dart'
    show registerStorageService, Storage, storageService;
import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/http.dart' show authClientService;

import '../shared/utils.dart' show httpRetryClient;
import 'configuration.dart' show activeConfiguration;

/// Wrap the [storageService] exposed from `package:gcloud` and
/// `package:appengine` with [RetryClient]. And retry 500, 503, and 429 errors.
///
/// Note. this should not be used if uploading files that won't easily fit in
/// memory! As [RetryClient] will cache the entire request body in memory
/// in-order to do retries.
Future<void> withStorageRetry(FutureOr<void> Function() fn) async {
  return await ss.fork(() async {
    // Ensure we're we have a client...
    if (authClientService == null) {
      throw StateError('gcloud/appengine must be setup');
    }

    // Create a that retries on transient errors
    final client = httpRetryClient(innerClient: authClientService);

    // Register a new storage service.
    registerStorageService(Storage(
      client,
      activeConfiguration.projectId,
    ));

    await fn();
  });
}
